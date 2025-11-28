// Slow Post Protection
resource "akamai_appsec_slow_post" "tfdemo" {
  config_id                  = akamai_appsec_configuration.config.config_id
  security_policy_id         = data.akamai_appsec_security_policy.policy.security_policy_id
  slow_rate_action           = var.slow_post_action
  slow_rate_threshold_rate   = 10
  slow_rate_threshold_period = 60
}

