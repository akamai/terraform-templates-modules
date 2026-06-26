resource "akamai_appsec_penalty_box" "this" {
  count                  = var.enable_waf ? 1 : 0
  config_id              = var.config_id
  security_policy_id     = akamai_appsec_security_policy.this.security_policy_id
  penalty_box_protection = true
  penalty_box_action     = var.penalty_box_action
}
