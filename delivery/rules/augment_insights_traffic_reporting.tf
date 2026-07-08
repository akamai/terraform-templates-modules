
data "akamai_property_rules_builder" "rule_traffic_reporting" {
  rules_v2026_02_16 {
    name                  = "Traffic reporting"
    comments              = "Identify your main traffic segments so you can granularly zoom in your traffic statistics like hits, bandwidth, offload, response codes, and errors."
    criteria_must_satisfy = "all"
    behavior {
      cp_code {
        enable_default_content_provider_code = var.default_cpcode
        dynamic "value" {
          for_each = var.default_cpcode ? [] : [1]
          content {
            id       = var.cpcode_id
            name     = var.cpcode_name
            products = [var.product_id, ]
          }
        }
      }
    }
  }
}
