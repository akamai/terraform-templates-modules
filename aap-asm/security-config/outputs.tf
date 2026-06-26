output "config_id" {
  value       = akamai_appsec_configuration.config.config_id
  description = "Security Configuration ID"
}

output "rate_policy_origin_error_id" {
  value       = akamai_appsec_rate_policy.origin_error.rate_policy_id
  description = "Rate Policy ID for Origin Error"
}

output "rate_policy_post_page_requests_id" {
  value       = akamai_appsec_rate_policy.post_page_requests.rate_policy_id
  description = "Rate Policy ID for POST Page Requests"
}

output "rate_policy_page_view_requests_id" {
  value       = akamai_appsec_rate_policy.page_view_requests.rate_policy_id
  description = "Rate Policy ID for Page View Requests"
}

output "reputation_profile_ids" {
  description = "Map of reputation profile IDs"
  value = var.enable_client_reputation ? {
    web_attackers_high_threat         = akamai_appsec_reputation_profile.web_attackers_high_threat[0].reputation_profile_id
    web_attackers_high_threat_shared  = akamai_appsec_reputation_profile.web_attackers_high_threat_shared[0].reputation_profile_id
    web_attackers_low_threat          = akamai_appsec_reputation_profile.web_attackers_low_threat[0].reputation_profile_id
    web_attackers_low_threat_shared   = akamai_appsec_reputation_profile.web_attackers_low_threat_shared[0].reputation_profile_id
    dos_attackers_high_threat         = akamai_appsec_reputation_profile.dos_attackers_high_threat[0].reputation_profile_id
    dos_attackers_high_threat_shared  = akamai_appsec_reputation_profile.dos_attackers_high_threat_shared[0].reputation_profile_id
    dos_attackers_low_threat          = akamai_appsec_reputation_profile.dos_attackers_low_threat[0].reputation_profile_id
    dos_attackers_low_threat_shared   = akamai_appsec_reputation_profile.dos_attackers_low_threat_shared[0].reputation_profile_id
    scanning_tools_high_threat        = akamai_appsec_reputation_profile.scanning_tools_high_threat[0].reputation_profile_id
    scanning_tools_high_threat_shared = akamai_appsec_reputation_profile.scanning_tools_high_threat_shared[0].reputation_profile_id
    scanning_tools_low_threat         = akamai_appsec_reputation_profile.scanning_tools_low_threat[0].reputation_profile_id
    scanning_tools_low_threat_shared  = akamai_appsec_reputation_profile.scanning_tools_low_threat_shared[0].reputation_profile_id
    web_scrapers_high_threat          = akamai_appsec_reputation_profile.web_scrapers_high_threat[0].reputation_profile_id
    web_scrapers_high_threat_shared   = akamai_appsec_reputation_profile.web_scrapers_high_threat_shared[0].reputation_profile_id
    web_scrapers_low_threat           = akamai_appsec_reputation_profile.web_scrapers_low_threat[0].reputation_profile_id
    web_scrapers_low_threat_shared    = akamai_appsec_reputation_profile.web_scrapers_low_threat_shared[0].reputation_profile_id
  } : {}
}

output "bypass_network_lists" {
  value       = local.bypass_network_lists
  description = "Bypass network lists with ID and name"
}
