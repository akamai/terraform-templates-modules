output "stream_id" {
  description = "The ID of the created DataStream."
  value       = akamai_datastream.this.id
}

output "stream_name" {
  description = "The name of the created DataStream."
  value       = akamai_datastream.this.stream_name
}

output "cpcode_id" {
  description = "The CP Code ID (created by this module or passed in via cpcode_id)."
  value       = local.effective_cpcode_id
}

output "cpcode_name" {
  description = "The name of the CP Code. Null when an existing cpcode_id was provided."
  value       = length(akamai_cp_code.this) > 0 ? akamai_cp_code.this[0].name : null
}