output "config_id" {
  description = "Akamai AppSec configuration ID resolved by name"
  value       = data.akamai_appsec_configuration.config.config_id

}