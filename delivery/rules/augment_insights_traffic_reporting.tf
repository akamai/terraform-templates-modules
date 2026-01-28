
data "akamai_property_rules_builder" "rule_traffic_reporting" {
  rules_v2025_10_16 {
    name                  = "Traffic reporting"
    comments              = "Identify your main traffic segments so you can granularly zoom in your traffic statistics like hits, bandwidth, offload, response codes, and errors."
    criteria_must_satisfy = "all"
    behavior {
      cp_code {
        enable_default_content_provider_code = false
        value {
          id       = var.cpcode_id
          name     = var.cpcode_name
          products = [var.product_id, ]
        }
      }
    }
  }
}
