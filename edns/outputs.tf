## ----------------------------------
# Basic zone info
## ----------------------------------
output "zone_name" {
  description = "DNS zone name"
  value       = var.zone_name
}

output "zone_type" {
  description = "DNS zone type (PRIMARY or SECONDARY)"
  value       = upper(var.zone_type)
}

## ----------------------------------
# SOA (PRIMARY only)
## ----------------------------------
output "zone_soa_raw" {
  description = "Raw SOA RDATA string from the apex (PRIMARY only)"
  value       = try(local.zone_soa_raw, null)
}

output "zone_soa_parsed" {
  description = "Parsed SOA fields (PRIMARY only)"
  value       = try(local.zone_soa_parsed, {})
}

## ----------------------------------
# Nameservers (FQDNs)
## ----------------------------------
output "akamai_authorities_only" {
  description = "Authoritative nameservers assigned by Akamai (FQDNs)"
  value       = try(data.akamai_authorities_set.my_authorities_set.authorities, [])
}

output "authorities_plus_custom_ns" {
  description = "Union of Akamai authoritative NS and custom NS targets (FQDNs)"
  value = distinct(
    concat(
      try(data.akamai_authorities_set.my_authorities_set.authorities, []),
      try(flatten([for r in var.ns_records : r.target]), [])
    )
  )
}

## ----------------------------------
# Nameserver IPs (SAFE)
## ----------------------------------
output "authorities_plus_custom_ns_ips" {
  description = "Map: NS hostname => IPv4 list or NO_IP"
  value = {
    for ns in distinct(
      concat(
        try(data.akamai_authorities_set.my_authorities_set.authorities, []),
        try(flatten([for r in var.ns_records : r.target]), [])
      )
    ) :
    trimsuffix(ns, ".") =>
    lookup(
      local.akamai_ns_to_ips_map,
      trimsuffix(ns, "."),
      ["NO_IP"]
    )
  }
}

## ----------------------------------
# SECONDARY-specific
## ----------------------------------
output "zone_transfer_masters" {
  description = "Configured master server IPs for SECONDARY zones"
  value       = akamai_dns_zone.dns_zone.masters
}

## ----------------------------------
# Helper snippets (copy/paste friendly)
## ----------------------------------
output "secondary_masters_tfvars_snippet" {
  description = "Ready-to-paste tfvars snippet for SECONDARY masters"
  value = format(
    "masters = [%s]",
    join(
      ", ",
      [
        for ip in distinct(flatten(values(local.akamai_ns_to_ips_map))) :
        format("\"%s\"", ip)
      ]
    )
  )
}

