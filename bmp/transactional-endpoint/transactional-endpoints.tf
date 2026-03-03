locals {
  ops_spec = jsondecode(file(var.operation_json))

  # Build plan-time keys: "/pets|Update|SEARCH"
  desired_keys = flatten([
    for resource_path, ops_by_name in local.ops_spec.operations : [
      for op_name, meta in ops_by_name :
      "${resource_path}|${op_name}|${meta.purpose}"
    ]
  ])

  akamai_operations_safe = coalesce(var.akamai_operations, [])

  # Build lookup map from Akamai response using same key
  akamai_by_key = {
    for op in var.akamai_operations :
    "${op.resource_path}|${op.name}|${op.purpose}" => op
  }
}

locals {
  # Shared schema for Standard + Inline telemetry buckets
  traffic_standard_inline = {
    aggressiveAction    = "monitor"
    aggressiveThreshold = 90
    overrideThresholds  = false
    strictAction        = "monitor"
    strictThreshold     = 50
  }

  # SDK schema (adds bypassPreSdkVersion)
  traffic_native_sdk = {
    aggressiveAction     = "monitor"
    aggressiveThreshold  = 90
    bypassPreSdkVersion  = false
    overrideThresholds   = false
    strictAction         = "monitor"
    strictThreshold      = 50
  }

  # Build traffic map with only the required buckets
  endpoint_traffic = merge(
    var.expect_standard_traffic ? { standardTelemetry = local.traffic_standard_inline } : {},
    var.expect_inline_traffic   ? { inlineTelemetry   = local.traffic_standard_inline } : {},
    var.expect_sdk_traffic ? {
      nativeSdkAndroid = local.traffic_native_sdk
      nativeSdkIos     = local.traffic_native_sdk
    } : {}
  )
}


resource "akamai_botman_transactional_endpoint" "bmp_endpoint" {
  for_each = toset(local.desired_keys)

  config_id          = local.config_id
  security_policy_id = local.policy_id
  operation_id       = local.akamai_by_key[each.key].id
  transactional_endpoint = jsonencode(
    {
      "apiEndPointId" : local.akamai_by_key[each.key].api_id,
      "telemetryTypeStates" : {
        "inline" : {
          "enabled" : var.expect_inline_traffic
        },
        "nativeSdk" : merge(
                    { "enabled" : var.expect_sdk_traffic },var.expect_sdk_traffic == false ? { "disabledAction" : "monitor" } : {}
        ),
        "standard" : merge(
          {"enabled" : var.expect_standard_traffic}, var.expect_standard_traffic == false ? {"disabledAction" : "monitor" } : {}
  )
      },
        traffic = local.endpoint_traffic



    }
  )
  lifecycle {
    precondition {
      condition     = contains(keys(local.akamai_by_key), each.key)
      error_message = "Operation '${each.key}' from operation_json not found in Akamai returned operations."
    }
  }
}