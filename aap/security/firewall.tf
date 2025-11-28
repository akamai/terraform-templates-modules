// IP/GEO/ASN Firewall
resource "akamai_appsec_ip_geo" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = data.akamai_appsec_security_policy.policy.security_policy_id
  mode               = "block"
  ip_controls {
    ip_network_lists = var.client_lists_ipblock
    action           = "deny"
  }
  geo_controls {
    geo_network_lists = var.client_lists_geoblock
    action            = "deny"
  }
  exception_ip_network_lists = var.client_lists_exception_ipblock
  ukraine_geo_control_action = "none"
}

