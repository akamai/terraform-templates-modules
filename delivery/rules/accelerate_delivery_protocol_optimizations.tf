
data "akamai_property_rules_builder" "rule_protocol_optimizations" {
  rules_v2025_10_16 {
    name                  = "Protocol optimizations"
    comments              = "Serve your website using modern and fast protocols."
    criteria_must_satisfy = "all"

    dynamic "behavior" {
      for_each = var.product_id != "Site_Accel" ? [1] : []
      content {
        enhanced_akamai_protocol {
          display = ""
        }
      }
    }

    behavior {
      http3 {
        enable = true
      }
    }
    behavior {
      http2 {
        enabled = ""
      }
    }
    behavior {
      allow_transfer_encoding {
        enabled = true
      }
    }
    behavior {
      sure_route {
        enable_custom_key      = false
        enabled                = true
        force_ssl_forward      = false
        race_stat_ttl          = "30m"
        sr_download_link_title = ""
        test_object_url        = var.sure_route_test_object
        to_host_status         = "INCOMING_HH"
        type                   = "PERFORMANCE"
      }
    }
  }
}
