output "property_id" {
  value       = akamai_property.this.id
  description = "The property's unique identifier."
}

output "rules_errors" {
  value       = akamai_property.this.rule_errors
  description = "The contents of errors field returned by the API."
}

output "cpcode_id" {
  value       = var.default_cpcode ? 0 : tonumber(trimprefix(akamai_cp_code.this[0].id, "cpc_"))
  description = "The CP Code's unique identifier."
}

output "cert_status" {
  value       = akamai_property.this.hostnames
  description = "The status of the certificate, which may include any challenge required to generate it (DNS CNAME or other type)"
}
