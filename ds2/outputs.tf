output "stream_id" {
  description = "The ID of the created DataStream."
  value       = akamai_datastream.this.id
}

output "stream_name" {
  description = "The name of the created DataStream."
  value       = akamai_datastream.this.stream_name
}