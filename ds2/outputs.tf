output "stream_id" {
  description = "The ID of the created DataStream."
  value       = akamai_datastream.this.id
}

output "stream_name" {
  description = "The name of the created DataStream."
  value       = akamai_datastream.this.stream_name
}

output "cpcode_id" {
  description = "The ID of the created CP Code."
  value       = akamai_cp_code.this.id
}

output "cpcode_name" {
  description = "The name of the created CP Code."
  value       = akamai_cp_code.this.name
}