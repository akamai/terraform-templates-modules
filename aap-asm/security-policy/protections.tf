resource "akamai_appsec_waf_protection" "this" {
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  enabled            = var.enable_waf
}

resource "akamai_appsec_api_constraints_protection" "this" {
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  enabled            = var.enable_request_constraints
}

resource "akamai_appsec_ip_geo_protection" "this" {
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  enabled            = var.enable_ip_geo
}

resource "akamai_appsec_malware_protection" "this" {
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  enabled            = var.enable_malware
}

resource "akamai_appsec_rate_protection" "this" {
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  enabled            = var.enable_rate
}

resource "akamai_appsec_slowpost_protection" "this" {
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  enabled            = var.enable_slow_post
}
