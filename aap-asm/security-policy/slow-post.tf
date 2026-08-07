resource "akamai_appsec_slow_post" "this" {
  count                      = var.enable_slow_post ? 1 : 0
  config_id                  = var.config_id
  security_policy_id         = akamai_appsec_slowpost_protection.this.security_policy_id
  slow_rate_action           = var.slow_post_action
  slow_rate_threshold_rate   = 10
  slow_rate_threshold_period = 60
}
