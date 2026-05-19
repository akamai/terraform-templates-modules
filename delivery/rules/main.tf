
data "akamai_property_rules_builder" "rule_default" {
  rules_v2025_10_16 {
    name      = "default"
    is_secure = var.etls
    comments  = "The Default Rule template contains all the necessary and recommended behaviors. Rules are evaluated from top to bottom and the last matching rule wins."
    behavior {
      origin {
        cache_key_hostname               = "REQUEST_HOST_HEADER"
        compress                         = true
        custom_valid_cn_values           = ["{{Origin Hostname}}", "{{Forward Host Header}}", ]
        enable_true_client_ip            = true
        forward_host_header              = "REQUEST_HOST_HEADER"
        hostname                         = var.default_origin
        http_port                        = 80
        https_port                       = 443
        ip_version                       = "IPV4"
        min_tls_version                  = "DYNAMIC"
        origin_certificate               = ""
        origin_certs_to_honor            = "STANDARD_CERTIFICATE_AUTHORITIES"
        origin_sni                       = true
        origin_type                      = "CUSTOMER"
        ports                            = ""
        standard_certificate_authorities = ["akamai-permissive", ]
        tls_version_title                = ""
        true_client_ip_client_setting    = false
        true_client_ip_header            = "True-Client-IP"
        verification_mode                = "CUSTOM"
      }
    }
    behavior {
      global_request_number {
        header_name   = "Akamai-GRN"
        output_option = "RESPONSE_HEADER"
      }
    }
    children = compact([
      var.additional_origins != null ? data.akamai_property_rules_builder.rule_additional_origins.json : null,
      data.akamai_property_rules_builder.rule_augment_insights.json,
      data.akamai_property_rules_builder.rule_accelerate_delivery.json,
      data.akamai_property_rules_builder.rule_offload_origin.json,
      data.akamai_property_rules_builder.rule_strengthen_security.json,
      data.akamai_property_rules_builder.rule_increase_availability.json,
      data.akamai_property_rules_builder.rule_minimize_payload.json,
    ])
  }
}
