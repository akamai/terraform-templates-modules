data "akamai_property_rules_builder" "rule_additional_origins" {
  rules_v2026_02_16 {
    name                  = "Additional Origins"
    comments              = "Parent rule for adding extra origins based on hostname matches."
    criteria_must_satisfy = "all"
    children = concat(
      [for instance in data.akamai_property_rules_builder.rule_additional_origin : instance.json]
    )
  }
}

data "akamai_property_rules_builder" "rule_additional_origin" {
  count = var.additional_origins != null ? length(keys(var.additional_origins)) : 0

  rules_v2026_02_16 {
    name                  = var.additional_origins[keys(var.additional_origins)[count.index]].origin_name
    criteria_must_satisfy = "all"

    # Hostname criterion (conditionally included)
    dynamic "criterion" {
      for_each = var.additional_origins[keys(var.additional_origins)[count.index]].hostname_match != null ? [1] : []
      content {
        hostname {
          match_operator = "IS_ONE_OF"
          values         = var.additional_origins[keys(var.additional_origins)[count.index]].hostname_match
        }
      }
    }

    # Response code criterion (conditionally included)
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
        cache_key_hostname               = "REQUEST_HOST_HEADER"
        compress                         = true
        custom_valid_cn_values           = ["{{Origin Hostname}}", "{{Forward Host Header}}", ]
        custom_forward_host_header       = contains(["REQUEST_HOST_HEADER", "ORIGIN_HOSTNAME"], var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header) ? null : var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header
        enable_true_client_ip            = true
        forward_host_header              = contains(["REQUEST_HOST_HEADER", "ORIGIN_HOSTNAME"], var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header) ? var.additional_origins[keys(var.additional_origins)[count.index]].forward_host_header : "CUSTOM"
        hostname                         = var.additional_origins[keys(var.additional_origins)[count.index]].origin_name
        http2_enabled                     = false
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
  }
}