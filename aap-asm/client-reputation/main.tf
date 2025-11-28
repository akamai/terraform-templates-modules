/**
 * # Onboarding: Application Security Configuration for Client Reputation
 *
 * The use case for this module is to quickly create a new Application Security Configuration for Client Reputation
 * serving a set of hostnames following Akamai Professional Services Best Practices.
 *
 * Read on to find out which resources are provisioned as part of this
 * process, and how to customize!
 *
 */

resource "akamai_appsec_reputation_protection" "tfdemo" {
  config_id          = var.config_id
  security_policy_id = var.security_policy_id
  enabled            = true
}
