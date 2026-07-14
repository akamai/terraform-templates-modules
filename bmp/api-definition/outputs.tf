




output "api_operations" {
  description = "Decoded operations returned by Akamai for this API"
  value = jsondecode(
    data.akamai_apidefinitions_resource_operations.operations.resource_operations
  )
}

output "api_id" {
  description = "Created API ID"
  value       = akamai_apidefinitions_api.api.id
}
