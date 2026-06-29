
data "akamai_property_rules_builder" "rule_adaptive_acceleration" {
  rules_v2026_02_16 {
    name                  = "Adaptive acceleration"
    comments              = "Automatically and continuously apply performance optimizations to your website using machine learning."
    criteria_must_satisfy = "all"
    behavior {
      adaptive_acceleration {
        ab_logic                  = "DISABLED"
        enable_brotli_compression = true
        enable_for_noncacheable   = false
        enable_preconnect         = true
        enable_push               = true
        enable_ro                 = false
        preload_enable            = true
        source                    = "MPULSE"
        title_http2_server_push   = ""
        title_preconnect          = ""
        title_preload             = ""
        title_ro                  = ""
      }
    }
  }
}
