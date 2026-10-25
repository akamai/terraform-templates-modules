data "akamai_property_rules_builder" "rule_additional_origins" {
  count = length(var.additional_origins) > 0 ? 1 : 0

  rules_v2026_07_21 {
    name                  = "Origin Servers"
    comments              = "Routes matching requests to additional origin servers."
    criteria_must_satisfy = "all"
    children = [
      for instance in data.akamai_property_rules_builder.rule_additional_origin : instance.json
    ]
  }
}

data "akamai_property_rules_builder" "rule_additional_origin" {
  count = length(var.additional_origins)

  rules_v2026_07_21 {
    name                  = var.additional_origins[keys(var.additional_origins)[count.index]].origin_name
    criteria_must_satisfy = "all"

    dynamic "criterion" {
      for_each = var.additional_origins[keys(var.additional_origins)[count.index]].hostname_match != null ? [1] : []
      content {
        hostname {
          match_operator = "IS_ONE_OF"
          values         = var.additional_origins[keys(var.additional_origins)[count.index]].hostname_match
        }
      }
    }

    dynamic "criterion" {
      for_each = var.additional_origins[keys(var.additional_origins)[count.index]].path_match != null ? [1] : []
      content {
        path {
          match_case_sensitive = false
          match_operator       = "MATCHES_ONE_OF"
          normalize            = false
          values               = var.additional_origins[keys(var.additional_origins)[count.index]].path_match
        }
      }
    }

    behavior {
      origin {
        cache_key_hostname            = "ORIGIN_HOSTNAME"
        compress                      = true
        enable_true_client_ip         = true
        custom_forward_host_header    = contains(["REQUEST_HOST_HEADER", "ORIGIN_HOSTNAME"], var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header) ? null : var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header
        forward_host_header           = contains(["REQUEST_HOST_HEADER", "ORIGIN_HOSTNAME"], var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header) ? var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header : "CUSTOM"
        hostname                      = var.additional_origins[keys(var.additional_origins)[count.index]].origin_name
        http2_enabled                 = var.http2_enabled
        http2_title                   = ""
        http_port                     = 80
        https_port                    = 443
        ip_version                    = "IPV4"
        min_tls_version               = var.min_tls_version
        origin_certificate            = ""
        origin_sni                    = true
        origin_type                   = "CUSTOMER"
        ports                         = ""
        tls_version_title             = ""
        true_client_ip_client_setting = false
        true_client_ip_header         = "True-Client-IP"
        verification_mode             = var.verification_mode
      }
    }
  }
}
