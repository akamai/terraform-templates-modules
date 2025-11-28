# Random string for enabling pragma headers
resource "random_string" "secret_header" {
  length           = 20
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "-"
  min_special      = "1"
}


// Global Advanced

resource "akamai_appsec_advanced_settings_request_body" "config_settings" {
  config_id                     = akamai_appsec_configuration.config.config_id
  request_body_inspection_limit = var.inspection_size
}

resource "akamai_appsec_advanced_settings_logging" "logging" {
  config_id = akamai_appsec_configuration.config.config_id
  logging = jsonencode(
    {
      "allowSampling" : true,
      "cookies" : {
        "type" : "all"
      },
      "customHeaders" : {
        "type" : "all"
      },
      "standardHeaders" : {
        "type" : "all"
      }
    }
  )
}


resource "akamai_appsec_advanced_settings_attack_payload_logging" "attack_payload_logging" {
  config_id = akamai_appsec_configuration.config.config_id
  attack_payload_logging = jsonencode(
    {
      "enabled" : true,
      "requestBody" : {
        "type" : "ATTACK_PAYLOAD"
      },
      "responseBody" : {
        "type" : "ATTACK_PAYLOAD"
      }
    }
  )
}

resource "akamai_appsec_advanced_settings_pragma_header" "pragma_header" {
  config_id = akamai_appsec_configuration.config.config_id
  pragma_header = jsonencode(
    {
      "action" : "REMOVE",
      "conditionOperator" : "OR",
      "excludeCondition" : [
        {
          "type" : "requestHeaderValueMatch",
          "positiveMatch" : true,
          "header" : "X-Akamai-Debug-Pragma",
          "value" : [
            random_string.secret_header.result
          ],
          "name" : "",
          "valueCase" : false,
          "valueWildcard" : false,
          "useHeaders" : false
        },
        {
          "type" : "networkList"
          "positiveMatch" : true,
          "header" : "",
          "value" : var.client_lists_pragmabypass
          "name" : "",
          "valueCase" : false,
          "valueWildcard" : false,
          "useHeaders" : false
        }
      ]
    }
  )
}

# // Override advanced settings on the policy level by add the below line,
# // security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
# // Where tfdemo is the reference name of the policy created, different policies will have different reference name

# resource "akamai_appsec_advanced_settings_evasive_path_match" "tfdemo" {
#   config_id          = akamai_appsec_configuration.config.config_id
#   security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
#   enable_path_match  = false
# }


