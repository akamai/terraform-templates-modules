resource "akamai_appsec_rate_policy_action" "origin_error" {
  count              = var.enable_rate ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_rate_protection.this.security_policy_id
  rate_policy_id     = var.rate_policy_origin_error_id
  ipv4_action        = var.dos_origin_error_action
  ipv6_action        = var.dos_origin_error_action
}

resource "akamai_appsec_rate_policy_action" "post_page_requests" {
  count              = var.enable_rate ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_rate_protection.this.security_policy_id
  rate_policy_id     = var.rate_policy_post_page_requests_id
  ipv4_action        = var.dos_post_page_requests_action
  ipv6_action        = var.dos_post_page_requests_action
}

resource "akamai_appsec_rate_policy_action" "page_view_requests" {
  count              = var.enable_rate ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_rate_protection.this.security_policy_id
  rate_policy_id     = var.rate_policy_page_view_requests_id
  ipv4_action        = var.dos_page_view_requests_action
  ipv6_action        = var.dos_page_view_requests_action
}
