/**
 * # AMD rules submodule
 *
 * Renders the default rule tree for an Adaptive Media Delivery property:
 * origin config, CP code, AMD-specific behaviors (segmented media
 * optimization, content characteristics, throughput optimization, HTTP/3,
 * optional debug), plus the default CORS policy child rule.
 */

data "akamai_property_rules_builder" "rule_default" {
  rules_v2026_07_21 {
    name      = "default"
    is_secure = var.etls

    behavior {
      origin {
        cache_key_hostname            = "ORIGIN_HOSTNAME"
        compress                      = true
        enable_true_client_ip         = true
        forward_host_header           = var.forward_host_header
        hostname                      = var.default_origin
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

    ### CP code (created by parent module)
    behavior {
      cp_code {
        enable_default_content_provider_code = false
        value {
          id       = var.cpcode_id
          name     = var.cpcode_name
          products = ["Adaptive_Media_Delivery"]
        }
      }
    }

    behavior {
      segmented_media_optimization {
        behavior = var.segmented_media_optimization_behavior
      }
    }

    behavior {
      origin_characteristics {
        authentication_method       = var.origin_authentication_method
        authentication_method_title = ""
        country                     = var.origin_country
        origin_location_title       = ""
      }
    }

    behavior {
      content_characteristics_amd {
        catalog_size            = var.content_catalog_size
        content_type            = var.content_type
        dash                    = var.enable_dash
        hds                     = var.enable_hds
        hls                     = var.enable_hls
        popularity_distribution = var.content_popularity_distribution
        segment_duration_dash   = var.segment_duration_dash
        segment_duration_hds    = var.segment_duration_hds
        segment_duration_hls    = var.segment_duration_hls
        segment_duration_smooth = var.segment_duration_smooth
        segment_size_dash       = "UNKNOWN"
        segment_size_hds        = "UNKNOWN"
        segment_size_hls        = "UNKNOWN"
        segment_size_smooth     = "UNKNOWN"
        smooth                  = var.enable_smooth
      }
    }

    behavior {
      client_characteristics {
        country = var.client_country
      }
    }

    behavior {
      cache_key_query_params {
        behavior = var.cache_key_query_params_behavior
      }
    }

    behavior {
      segmented_content_protection {
        dash_media_encryption      = var.enable_segmented_content_protection && var.dash_media_encryption
        enabled                    = var.enable_segmented_content_protection
        hls_media_encryption       = var.enable_segmented_content_protection && var.hls_media_encryption
        media_encryption_title     = ""
        token_authentication_title = ""
      }
    }

    behavior {
      dynamic_throughtput_optimization {
        enabled = var.enable_dynamic_throughput_optimization
      }
    }

    behavior {
      http3 {
        enable = var.enable_http3
      }
    }

    behavior {
      enhanced_debug {
        debug_key      = var.enable_debug ? var.debug_key : null
        disable_pragma = var.enable_debug ? true : null
        enable_debug   = var.enable_debug
        generate_grn   = var.enable_debug ? true : null
      }
    }

    children = concat(
      length(var.additional_origins) > 0 ? [data.akamai_property_rules_builder.rule_additional_origins[0].json] : [],
      [data.akamai_property_rules_builder.rule_cors_policy.json],
    )
  }
}

