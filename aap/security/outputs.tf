output "config_id" {
  value       = akamai_appsec_configuration.config.config_id
  description = "Security Configuration ID"
}

output "security_policy_id" {
  value       = data.akamai_appsec_security_policy.policy.security_policy_id
  description = "Security Policy ID"
}

output "rate" {
  value = {
    origin = [for policy in jsondecode(data.akamai_appsec_rate_policies.rate.json)["ratePolicies"] : policy["id"] if policy["name"] == "Origin Error"]
    post   = [for policy in jsondecode(data.akamai_appsec_rate_policies.rate.json)["ratePolicies"] : policy["id"] if policy["name"] == "POST Page Requests"]
    page   = [for policy in jsondecode(data.akamai_appsec_rate_policies.rate.json)["ratePolicies"] : policy["id"] if policy["name"] == "Page View Requests"]
  }
  description = "Rate Policy IDs"
}
