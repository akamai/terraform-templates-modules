output "property_id" {
  description = "ID of the created property."
  value       = akamai_property.this.id
}

output "cpcode_id" {
  description = "ID of the created CP code."
  value       = akamai_cp_code.this.id
}

output "cert_status" {
  description = "Hostname-to-edge-hostname mapping with certificate provisioning type, for reference."
  value = [
    for key, h in local.hostnames : {
      cname_from             = h.cname_from
      cname_to               = h.cname_to
      cert_provisioning_type = local.edge_hostname_cert_provisioning_type[var.edge_hostname_type]
    }
  ]
}

output "rule_errors" {
  description = "Validation errors returned by Property Manager for the rendered rule tree, if any."
  value       = akamai_property.this.rule_errors
}
