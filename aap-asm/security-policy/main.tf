/**
 * # Security Policy (Per-Policy)
 *
 * Creates a single security policy within an existing Akamai Application Security
 * configuration, including all protection settings, WAF rules, DoS protections,
 * client reputation actions, and bot manager actions.
 *
 * This module is designed to be called with `for_each` to create multiple
 * policies per security configuration.
 *
 */

resource "akamai_appsec_security_policy" "this" {
  config_id              = var.config_id
  default_settings       = true
  security_policy_name   = var.policy_name
  security_policy_prefix = var.policy_prefix
}
