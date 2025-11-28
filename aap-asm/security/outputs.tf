output "config_id" {
  value       = akamai_appsec_configuration.config.config_id
  description = "Security Configuration ID"
}

output "security_policy_id" {
  value       = akamai_appsec_security_policy.tfdemo.security_policy_id
  description = "Security Policy ID"
}

output "client_lists_id_to_name_map" {
  description = "Mapping of client list IDs to their names"
  value       = local.bypass_network_lists
}
