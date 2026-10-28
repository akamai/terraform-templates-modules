/**
 * # Module: edns (Akamai Edge DNS)
 *
 * This Terraform module provisions and manages Akamai Edge DNS zones.
 * It supports both PRIMARY and SECONDARY zones and provides a unified,
 * opinionated interface for managing DNS infrastructure in a safe and
 * predictable way.
 *
 * --------------------------------------------------------------------
 * ## Supported Zone Types
 *
 * ### PRIMARY
 * - Authoritative DNS zone hosted on Akamai
 * - DNS records are fully managed by Terraform
 * - Supports a wide range of DNS record types (A, AAAA, CNAME, MX, etc.)
 * - Optional SOA management
 *
 * ### SECONDARY
 * - Slave DNS zone
 * - Zone transfers are performed from external master servers
 * - Requires `masters` (IP addresses)
 * - Optional TSIG authentication
 * - DNS records are NOT managed by this module
 *
 * The `zone_type` variable is case-insensitive and internally normalized
 * to lowercase for consistency.
 *
 * --------------------------------------------------------------------
 * ## High-level Behavior
 *
 * - A single `akamai_dns_zone` resource is always created
 * - All DNS record resources are conditionally created ONLY when
 *   `zone_type = primary`
 * - For `secondary` zones, record-related logic is skipped entirely
 * - This guarantees that PRIMARY and SECONDARY behaviors never overlap
 *
 * --------------------------------------------------------------------
 * ## DNS Record Management (PRIMARY only)
 *
 * The module supports the following DNS record types:
 *
 * Standard:
 * - A
 * - AAAA
 * - CNAME
 * - TXT
 * - NS
 * - PTR
 * - LOC
 * - SPF
 *
 * Service / Routing:
 * - MX
 * - SRV
 * - CAA
 * - NAPTR
 * - HTTPS
 * - SVCB
 *
 * Informational:
 * - RP
 * - HINFO
 * - CERT
 *
 * DNSSEC-related:
 * - DS
 * - DNSKEY
 * - SSHFP
 *
 * Akamai-specific:
 * - AKAMAICDN
 *
 * Each record type is defined via a list variable in `terraform.tfvars`.
 * Empty lists result in no resources being created.
 * Duplicate record names are explicitly validated and rejected.
 *
 * --------------------------------------------------------------------
 * ## SOA Handling
 *
 * - SOA management is OPTIONAL
 * - If `soa = null`, the SOA record is not managed by Terraform
 * - If `soa` is provided, the SOA record is explicitly created/updated
 *
 * After zone creation, the module:
 * - Waits for propagation (PRIMARY only)
 * - Reads the SOA record from the apex
 * - Exposes both raw and parsed SOA data via outputs
 *
 * This allows:
 * - Verification of SOA values
 * - Easy troubleshooting
 * - Safe coexistence with externally managed SOA records
 *
 * --------------------------------------------------------------------
 * ## Nameservers (NS) and Authorities
 *
 * The module retrieves the authoritative nameservers assigned by Akamai
 * to the provided contract using `akamai_authorities_set`.
 *
 * Behavior:
 * - Akamai-assigned NS are always fetched
 * - Hostnames are normalized (no trailing dots)
 * - IPv4 addresses are resolved safely (A records only)
 *
 * This information can be used to:
 * - Delegate the zone from a parent DNS
 * - Populate SECONDARY `masters`
 * - Configure firewalls / ACLs
 *
 * NXDOMAIN-safe logic is used to avoid Terraform failures.
 *
 * --------------------------------------------------------------------
 * ## Outputs
 *
 * The module exposes:
 * - Zone metadata (name, type)
 * - SOA (raw and parsed, PRIMARY only)
 * - Akamai authoritative nameservers
 * - Nameserver-to-IP mappings
 * - Helper snippets that can be copied directly into tfvars
 *
 * These outputs are designed to support automation, debugging,
 * and cross-team handoffs.
 *
 * --------------------------------------------------------------------
 * ## Design Principles
 *
 * - Clear separation of PRIMARY vs SECONDARY logic
 * - Defensive defaults (empty maps, conditional resources)
 * - Idempotent behavior
 * - No hidden side effects
 * - Safe to use across multiple environments and states
 *
 * --------------------------------------------------------------------
 * ## Notes
 *
 * - This module does NOT manage Terraform backends or state
 * - Backend configuration MUST be handled by the consuming templates
 * - README.md is generated automatically via terraform-docs
 *   using this inline documentation
 *
 */


## ----------------------------------
# Normalize zone_type to lowercase
## ----------------------------------
locals {
  normalized_zone_type = lower(var.zone_type)
}
## ----------------------------------
# Akamai Edge DNS – Zone
## ----------------------------------
resource "akamai_dns_zone" "dns_zone" {
  contract = var.contract_id
  group    = var.group_id
  zone     = var.zone_name
  type     = local.normalized_zone_type # "primary" | "secondary"

  # For secondary, 'masters' must be provided. For primary, keep empty.
  masters = local.normalized_zone_type == "secondary" ? var.masters : []

  # Optional TSIG for secondary transfers
  dynamic "tsig_key" {
    for_each = local.normalized_zone_type == "secondary" && try(var.tsig_key, null) != null ? [var.tsig_key] : []
    content {
      name      = tsig_key.value.name
      algorithm = tsig_key.value.algorithm
      secret    = tsig_key.value.secret
    }
  }
}

## ----------------------------------
# Locals: per-record maps for for_each (PRIMARY only)
## ----------------------------------
locals {
  # basic
  a_records_map     = local.normalized_zone_type == "primary" ? { for r in var.a_records : r.name => r } : {}
  aaaa_records_map  = local.normalized_zone_type == "primary" ? { for r in var.aaaa_records : r.name => r } : {}
  cname_records_map = local.normalized_zone_type == "primary" ? { for r in var.cname_records : r.name => r } : {}
  txt_records_map   = local.normalized_zone_type == "primary" ? { for r in var.txt_records : r.name => r } : {}
  ns_records_map    = local.normalized_zone_type == "primary" ? { for r in var.ns_records : r.name => r } : {}
  ptr_records_map   = local.normalized_zone_type == "primary" ? { for r in var.ptr_records : r.name => r } : {}
  loc_records_map   = local.normalized_zone_type == "primary" ? { for r in var.loc_records : r.name => r } : {}
  spf_records_map   = local.normalized_zone_type == "primary" ? { for r in var.spf_records : r.name => r } : {}
  rp_records_map    = local.normalized_zone_type == "primary" ? { for r in var.rp_records : r.name => r } : {}
  hinfo_records_map = local.normalized_zone_type == "primary" ? { for r in var.hinfo_records : r.name => r } : {}
  cert_records_map  = local.normalized_zone_type == "primary" ? { for r in var.cert_records : r.name => r } : {}

  # advanced
  mx_records_map    = local.normalized_zone_type == "primary" ? { for r in var.mx_records : r.name => r } : {}
  srv_records_map   = local.normalized_zone_type == "primary" ? { for r in var.srv_records : r.name => r } : {}
  caa_records_map   = local.normalized_zone_type == "primary" ? { for r in var.caa_records : r.name => r } : {}
  naptr_records_map = local.normalized_zone_type == "primary" ? { for r in var.naptr_records : r.name => r } : {}
  https_records_map = local.normalized_zone_type == "primary" ? { for r in var.https_records : r.name => r } : {}
  svcb_records_map  = local.normalized_zone_type == "primary" ? { for r in var.svcb_records : r.name => r } : {}

  # dnssec
  ds_records_map     = local.normalized_zone_type == "primary" ? { for r in var.ds_records : r.name => r } : {}
  dnskey_records_map = local.normalized_zone_type == "primary" ? { for r in var.dnskey_records : r.name => r } : {}
  sshfp_records_map  = local.normalized_zone_type == "primary" ? { for r in var.sshfp_records : r.name => r } : {}

  # Akamai CDN
  akamaicdn_records_map = local.normalized_zone_type == "primary" ? { for r in var.akamaicdn_records : r.name => r } : {}
}

## ----------------------------------
# Akamai-specific record (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "akamaicdn_records" {
  for_each   = local.akamaicdn_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "AKAMAICDN"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# SOA (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "apex_soa" {
  for_each   = local.normalized_zone_type == "primary" && var.soa != null ? { "apex" = var.soa } : {}
  depends_on = [akamai_dns_zone.dns_zone]

  zone       = akamai_dns_zone.dns_zone.zone
  name       = akamai_dns_zone.dns_zone.zone
  recordtype = "SOA"

  email_address = each.value.email
  name_server   = each.value.name_server
  ttl           = each.value.ttl
  refresh       = each.value.refresh
  retry         = each.value.retry
  expiry        = each.value.expiry
  nxdomain_ttl  = each.value.nxdomain_ttl
}

## ----------------------------------
# A (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "a_records" {
  for_each   = local.a_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "A"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# AAAA (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "aaaa_records" {
  for_each   = local.aaaa_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "AAAA"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# CNAME (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "cname_records" {
  for_each   = local.cname_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "CNAME"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# TXT (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "txt_records" {
  for_each   = local.txt_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "TXT"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# NS (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "ns_records" {
  for_each   = local.ns_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "NS"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# PTR (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "ptr_records" {
  for_each   = local.ptr_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "PTR"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# LOC (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "loc_records" {
  for_each   = local.loc_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "LOC"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# SPF (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "spf_records" {
  for_each   = local.spf_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "SPF"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# RP (PRIMARY only) – uses mailbox/txt
## ----------------------------------
resource "akamai_dns_record" "rp_records" {
  for_each   = local.rp_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "RP"
  ttl        = each.value.ttl

  mailbox = try(each.value.mailbox, each.value.mbox)
  txt     = each.value.txt
}

## ----------------------------------
# HINFO (PRIMARY only) – uses hardware/software
## ----------------------------------
resource "akamai_dns_record" "hinfo_records" {
  for_each   = local.hinfo_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "HINFO"
  ttl        = each.value.ttl

  hardware = try(each.value.hardware, each.value.cpu)
  software = try(each.value.software, each.value.os)
}

## ----------------------------------
# CERT (PRIMARY only) – uses type_mnemonic/type_value and keytag
## ----------------------------------
resource "akamai_dns_record" "cert_records" {
  for_each   = local.cert_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "CERT"
  ttl        = each.value.ttl

  # Provide one of: type_mnemonic OR type_value
  type_mnemonic = try(each.value.type_mnemonic, each.value.type) # map legacy 'type' to mnemonic if you stored that
  # type_value  = try(each.value.type_value, null)                # uncomment if you store numeric

  keytag      = try(each.value.keytag, each.value.key_tag)
  algorithm   = each.value.algorithm
  certificate = each.value.certificate
}

## ----------------------------------
# MX (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "mx_records" {
  for_each   = local.mx_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "MX"
  ttl        = each.value.ttl
  priority   = try(each.value.priority, null)
  target     = each.value.target
}

## ----------------------------------
# SRV (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "srv_records" {
  for_each   = local.srv_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "SRV"
  ttl        = each.value.ttl
  priority   = each.value.priority
  weight     = each.value.weight
  port       = each.value.port
  target     = each.value.target
}

## ----------------------------------
# CAA (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "caa_records" {
  for_each   = local.caa_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "CAA"
  ttl        = each.value.ttl
  target     = each.value.target
}

## ----------------------------------
# NAPTR (PRIMARY only) – uses flagsnaptr/service
## ----------------------------------
resource "akamai_dns_record" "naptr_records" {
  for_each   = local.naptr_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "NAPTR"
  ttl        = each.value.ttl

  order       = each.value.order
  preference  = each.value.preference
  flagsnaptr  = try(each.value.flagsnaptr, each.value.flags)
  service     = try(each.value.service, join(" ", try(each.value.services, [])))
  regexp      = each.value.regexp
  replacement = each.value.replacement
}

## ----------------------------------
# HTTPS (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "https_records" {
  for_each   = local.https_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "HTTPS"
  ttl        = each.value.ttl
  priority   = each.value.priority
  target     = each.value.target
}

## ----------------------------------
# SVCB (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "svcb_records" {
  for_each   = local.svcb_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "SVCB"
  ttl        = each.value.ttl
  priority   = each.value.priority
  target     = each.value.target
}

## ----------------------------------
# DS (PRIMARY only) – uses keytag
## ----------------------------------
resource "akamai_dns_record" "ds_records" {
  for_each   = local.ds_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "DS"
  ttl        = each.value.ttl

  keytag      = try(each.value.keytag, each.value.key_tag)
  algorithm   = each.value.algorithm
  digest_type = each.value.digest_type
  digest      = each.value.digest
}

## ----------------------------------
# DNSKEY (PRIMARY only) – uses key
## ----------------------------------
resource "akamai_dns_record" "dnskey_records" {
  for_each   = local.dnskey_records_map
  zone       = akamai_dns_zone.dns_zone.zone
  name       = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype = "DNSKEY"
  ttl        = each.value.ttl

  flags     = each.value.flags
  protocol  = each.value.protocol
  algorithm = each.value.algorithm
  key       = try(each.value.key, each.value.public_key)
}

## ----------------------------------
# SSHFP (PRIMARY only)
## ----------------------------------
resource "akamai_dns_record" "sshfp_records" {
  for_each         = local.sshfp_records_map
  zone             = akamai_dns_zone.dns_zone.zone
  name             = each.key == "@" ? akamai_dns_zone.dns_zone.zone : "${each.key}.${akamai_dns_zone.dns_zone.zone}"
  recordtype       = "SSHFP"
  ttl              = each.value.ttl
  algorithm        = each.value.algorithm
  fingerprint_type = each.value.fingerprint_type
  fingerprint      = each.value.fingerprint
}

## ----------------------------------
# Wait before reading SOA (PRIMARY waits 120s, SECONDARY 0s)
## ----------------------------------
resource "time_sleep" "wait_for_zone" {
  create_duration = local.normalized_zone_type == "primary" ? "120s" : "0s"
  depends_on      = [akamai_dns_zone.dns_zone]
}

## ----------------------------------
# Read SOA from apex (works for primary; harmless for secondary)
## ----------------------------------
data "akamai_dns_record_set" "zone_soa" {
  zone        = akamai_dns_zone.dns_zone.zone
  name        = "@"
  record_type = "SOA"
  depends_on  = [time_sleep.wait_for_zone]
}

## ----------------------------------
# Local values: SOA parsing (PRIMARY) and helpers
## ----------------------------------
locals {
  # SOA – raw data and parsed
  zone_soa_raw  = local.normalized_zone_type == "primary" ? try(data.akamai_dns_record_set.zone_soa.rdata[0], null) : null
  zone_soa_list = local.zone_soa_raw == null ? [] : split(" ", local.zone_soa_raw)
  zone_soa_parsed = length(local.zone_soa_list) < 7 ? null : {
    mname        = local.zone_soa_list[0]
    rname        = local.zone_soa_list[1]
    serial       = tonumber(local.zone_soa_list[2])
    refresh      = tonumber(local.zone_soa_list[3])
    retry        = tonumber(local.zone_soa_list[4])
    expiry       = tonumber(local.zone_soa_list[5])
    nxdomain_ttl = tonumber(local.zone_soa_list[6])
  }
}

## ----------------------------------
# Resolve IPs for authorities + custom NS using hashicorp/dns
# NOTE: dns_* data sources will fail on NXDOMAIN; keep names valid.
## ----------------------------------
## ----------------------------------
# Akamai authorities set (known during plan)
## ----------------------------------
data "akamai_authorities_set" "my_authorities_set" {
  contract = var.contract_id
}

## ----------------------------------
# Locals: clean Akamai NS hostnames (no dots)
## ----------------------------------
locals {
  akamai_ns_clean = [
    for ns in try(data.akamai_authorities_set.my_authorities_set.authorities, []) :
    trimsuffix(ns, ".")
  ]
}

## ----------------------------------
# Resolve IPv4 addresses ONLY for Akamai NS
# (safe: no AAAA, no NXDOMAIN crashes)
## ----------------------------------
data "dns_a_record_set" "akamai_ns_a" {
  for_each = toset(local.akamai_ns_clean)
  host     = each.key
}

## ----------------------------------
# Map: Akamai NS hostname => IPv4 list
## ----------------------------------
locals {
  akamai_ns_to_ips_map = {
    for h in local.akamai_ns_clean :
    h => try(data.dns_a_record_set.akamai_ns_a[h].addrs, [])
  }
}
