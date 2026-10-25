data "akamai_property_rules_builder" "rule_cors_policy" {
  rules_v2026_07_21 {
    name                  = "Default CORS Policy"
    criteria_must_satisfy = "all"

    behavior {
      modify_outgoing_response_header {
        action                      = "MODIFY"
        avoid_duplicate_headers     = false
        new_header_value            = "*"
        standard_modify_header_name = "ACCESS_CONTROL_ALLOW_ORIGIN"
      }
    }
    behavior {
      modify_outgoing_response_header {
        action                      = "MODIFY"
        avoid_duplicate_headers     = false
        new_header_value            = "GET,POST,OPTIONS"
        standard_modify_header_name = "ACCESS_CONTROL_ALLOW_METHODS"
      }
    }
    behavior {
      modify_outgoing_response_header {
        action                      = "MODIFY"
        avoid_duplicate_headers     = false
        new_header_value            = "origin,range,hdntl,hdnts,CMCD-Request,CMCD-Object,CMCD-Status,CMCD-Session"
        standard_modify_header_name = "ACCESS_CONTROL_ALLOW_HEADERS"
      }
    }
    behavior {
      modify_outgoing_response_header {
        action                      = "MODIFY"
        avoid_duplicate_headers     = false
        new_header_value            = "Server,range,hdntl,hdnts,Akamai-Mon-Iucid-Ing,Akamai-Mon-Iucid-Del,Akamai-Request-BC"
        standard_modify_header_name = "ACCESS_CONTROL_EXPOSE_HEADERS"
      }
    }
    behavior {
      modify_outgoing_response_header {
        action                      = "MODIFY"
        avoid_duplicate_headers     = false
        new_header_value            = "true"
        standard_modify_header_name = "ACCESS_CONTROL_ALLOW_CREDENTIALS"
      }
    }
    behavior {
      modify_outgoing_response_header {
        action                      = "MODIFY"
        avoid_duplicate_headers     = false
        new_header_value            = "86400"
        standard_modify_header_name = "ACCESS_CONTROL_MAX_AGE"
      }
    }
  }
}
