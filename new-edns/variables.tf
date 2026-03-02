#### ----------------------------------------------------------------------------
## EdgeGrid
#### ----------------------------------------------------------------------------
# tflint-ignore: terraform_unused_declarations
variable "edgerc_path" {
  description = <<EOD
    Path to the .edgerc file.
  EOD
  type        = string
  default     = null
}
# tflint-ignore: terraform_unused_declarations
variable "edgerc_section" {
  description = <<EOD
    Section in the .edgerc file.

    For professional services, it is recommended to create a new section for
    each account managed.
  EOD
  type        = string
}
#### ----------------------------------------------------------------------------
## Scope / Provider auth
#### ----------------------------------------------------------------------------

variable "contract_id" {
  description = "Contract ID for property/config creation"
  type        = string
}

variable "group_id" {
  description = "Group ID for property/config creation."
  type        = string
}
variable "zone_name" {
  type = string
}
#### ----------------------------------------------------------------------------
## EdgeDNS SECONDARY Zone
#### ----------------------------------------------------------------------------
variable "zone_type" {
  description = "Zone type: primary or secondary (case-insensitive)"
  type        = string

  validation {
    condition     = contains(["primary", "secondary"], lower(var.zone_type))
    error_message = "zone_type must be one of: primary or secondary (case-insensitive)."
  }
}

variable "masters" {
  description = "Masters for secondary zone (used only when zone_type == \"secondary\")"
  type        = list(string)
  default     = []
}

variable "tsig_key" {
  description = "Optional TSIG key for secondary transfers"
  type = object({
    name      = string
    algorithm = string
    secret    = string
  })
  default = null
}
#### ----------------------------------------------------------------------------
## Optional SOA management
#### ----------------------------------------------------------------------------
variable "soa" {
  description = "If null, SOA is not managed."
  type = object({
    email        = string
    name_server  = string
    ttl          = number
    refresh      = number
    retry        = number
    expiry       = number
    nxdomain_ttl = number
  })
  default  = null
  nullable = true
}

#### ----------------------------------------------------------------------------
## EdgeDNS Records (default = [])
#### ----------------------------------------------------------------------------
variable "a_records" {
  description = "A records"
  type = list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.a_records) == length(distinct([for r in var.a_records : r.name]))
    error_message = "Duplicate record names detected in a_records."
  }
}

variable "aaaa_records" {
  description = "AAAA records"
  type = list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.aaaa_records) == length(distinct([for r in var.aaaa_records : r.name]))
    error_message = "Duplicate record names detected in aaaa_records."
  }
}

variable "cname_records" {
  description = "CNAME records"
  type = list(object({
    name   = string
    target = list(string) # zwykle jeden FQDN
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.cname_records) == length(distinct([for r in var.cname_records : r.name]))
    error_message = "Duplicate record names detected in cname_records."
  }
}

variable "txt_records" {
  description = "TXT records"
  type = list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.txt_records) == length(distinct([for r in var.txt_records : r.name]))
    error_message = "Duplicate record names detected in txt_records."
  }
}

variable "ns_records" {
  description = "NS records (delegacje subdomen lub override apex)"
  type = list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.ns_records) == length(distinct([for r in var.ns_records : r.name]))
    error_message = "Duplicate record names detected in ns_records."
  }
}

variable "ptr_records" {
  description = "PTR records"
  type = list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.ptr_records) == length(distinct([for r in var.ptr_records : r.name]))
    error_message = "Duplicate record names detected in ptr_records."
  }
}

variable "loc_records" {
  description = "LOC records (geolocation)"
  type = list(object({
    name   = string
    target = list(string) # ex. '52 13 12.000 N 21 00 30.000 E 12.00m 10.00m 2.00m 2.00m'
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.loc_records) == length(distinct([for r in var.loc_records : r.name]))
    error_message = "Duplicate record names detected in loc_records."
  }
}

variable "spf_records" {
  description = "SPF records (deprecated RFC; użycie jak TXT)"
  type = list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.spf_records) == length(distinct([for r in var.spf_records : r.name]))
    error_message = "Duplicate record names detected in spf_records."
  }
}

variable "rp_records" {
  description = "RP records (Responsible Person)"
  type = list(object({
    name    = string
    mailbox = string
    txt     = string
    ttl     = number
  }))
  default = []
  validation {
    condition     = length(var.rp_records) == length(distinct([for r in var.rp_records : r.name]))
    error_message = "Duplicate record names detected in rp_records."
  }
}

variable "hinfo_records" {
  description = "HINFO records (Host info)"
  type = list(object({
    name     = string
    hardware = string
    software = string
    ttl      = number
  }))
  default = []
  validation {
    condition     = length(var.hinfo_records) == length(distinct([for r in var.hinfo_records : r.name]))
    error_message = "Duplicate record names detected in hinfo_records."
  }
}

variable "cert_records" {
  description = "CERT records"
  type = list(object({
    name          = string
    ttl           = number
    type_value    = optional(number)
    type_mnemonic = optional(string)
    keytag        = number
    algorithm     = number
    certificate   = string
  }))
  default = []
  validation {
    condition     = length(var.cert_records) == length(distinct([for r in var.cert_records : r.name]))
    error_message = "Duplicate record names detected in cert_records."
  }
}

#### ----------------------------------------------------------------------------
## MX / SRV / CAA / NAPTR / HTTPS / SVCB
#### ----------------------------------------------------------------------------
variable "mx_records" {
  description = "MX records"
  type = list(object({
    name               = string
    target             = list(string)
    ttl                = number
    priority           = optional(number)
    priority_increment = optional(number)
  }))
  default = []
  validation {
    condition     = length(var.mx_records) == length(distinct([for r in var.mx_records : r.name]))
    error_message = "Duplicate record names detected in mx_records."
  }
}

variable "srv_records" {
  description = "SRV records"
  type = list(object({
    name     = string
    target   = list(string)
    ttl      = number
    priority = optional(number)
    weight   = optional(number)
    port     = optional(number)
  }))
  default = []
  validation {
    condition     = length(var.srv_records) == length(distinct([for r in var.srv_records : r.name]))
    error_message = "Duplicate record names detected in srv_records."
  }
}

variable "caa_records" {
  description = "CAA records"
  type = list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))
  default = []
  validation {
    condition     = length(var.caa_records) == length(distinct([for r in var.caa_records : r.name]))
    error_message = "Duplicate record names detected in caa_records."
  }
}

variable "naptr_records" {
  description = "NAPTR records"
  type = list(object({
    name        = string
    ttl         = number
    order       = number
    preference  = number
    flagsnaptr  = string
    service     = string
    regexp      = string
    replacement = string
  }))
  default = []
  validation {
    condition     = length(var.naptr_records) == length(distinct([for r in var.naptr_records : r.name]))
    error_message = "Duplicate record names detected in naptr_records."
  }
}

variable "https_records" {
  description = "HTTPS records (Service Binding)"
  type = list(object({
    name     = string
    ttl      = number
    priority = number
    target   = string                 # .
    params   = optional(list(string)) # ex. ['alpn="h2,h3"', 'ipv4hint="203.0.113.10"']
  }))
  default = []
  validation {
    condition     = length(var.https_records) == length(distinct([for r in var.https_records : r.name]))
    error_message = "Duplicate record names detected in https_records."
  }
}

variable "svcb_records" {
  description = "SVCB records (Service Binding)"
  type = list(object({
    name     = string
    ttl      = number
    priority = number
    target   = string
    params   = optional(list(string))
  }))
  default = []
  validation {
    condition     = length(var.svcb_records) == length(distinct([for r in var.svcb_records : r.name]))
    error_message = "Duplicate record names detected in svcb_records."
  }
}

#### ----------------------------------------------------------------------------
## DNSSEC-related
#### ----------------------------------------------------------------------------
variable "ds_records" {
  description = "DS records (DNSSEC)"
  type = list(object({
    name        = string
    ttl         = number
    keytag      = number
    algorithm   = number
    digest_type = number
    digest      = string
  }))
  default = []
  validation {
    condition     = length(var.ds_records) == length(distinct([for r in var.ds_records : r.name]))
    error_message = "Duplicate record names detected in ds_records."
  }
}

variable "dnskey_records" {
  description = "DNSKEY records (DNSSEC)"
  type = list(object({
    name      = string
    ttl       = number
    flags     = number
    protocol  = number
    algorithm = number
    key       = string #base64 public key
  }))
  default = []
  validation {
    condition     = length(var.dnskey_records) == length(distinct([for r in var.dnskey_records : r.name]))
    error_message = "Duplicate record names detected in dnskey_records."
  }
}

variable "sshfp_records" {
  description = "SSHFP records"
  type = list(object({
    name             = string
    ttl              = number
    algorithm        = number
    fingerprint_type = number
    fingerprint      = string
  }))
  default = []
  validation {
    condition     = length(var.sshfp_records) == length(distinct([for r in var.sshfp_records : r.name]))
    error_message = "Duplicate record names detected in sshfp_records."
  }
}
# tflint-ignore: terraform_unused_declarations
variable "tlsa_records" {
  description = "TLSA records (DANE)"
  type = list(object({
    name        = string
    ttl         = number
    usage       = number
    selector    = number
    match_type  = number
    certificate = string
  }))
  default = []
  validation {
    condition     = length(var.tlsa_records) == length(distinct([for r in var.tlsa_records : r.name]))
    error_message = "Duplicate record names detected in tlsa_records."
  }
}

#### ----------------------------------------------------------------------------
## Akamai-specific (optional)
#### ----------------------------------------------------------------------------
variable "akamaicdn_records" {
  description = "AKAMAICDN (apex mapping)"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
  validation {
    condition     = length(var.akamaicdn_records) == length(distinct([for r in var.akamaicdn_records : r.name]))
    error_message = "Duplicate record names detected in akamaicdn_records."
  }
}
# tflint-ignore: terraform_unused_declarations
variable "akamaitlc_records" {
  description = "AKAMAITLC (proprietary; zwykle read-only w TF)"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
  validation {
    condition     = length(var.akamaitlc_records) == length(distinct([for r in var.akamaitlc_records : r.name]))
    error_message = "Duplicate record names detected in akamaitlc_records."
  }
}

#### ----------------------------------------------------------------------------
## other optional DNSSEC types (leave [] if not used)
#### ----------------------------------------------------------------------------
# tflint-ignore: terraform_unused_declarations
variable "cdnskey_records" {
  description = "CDNSKEY records"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
}
# tflint-ignore: terraform_unused_declarations
variable "cds_records" {
  description = "CDS records"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
}
# tflint-ignore: terraform_unused_declarations
variable "rrsig_records" {
  description = "RRSIG records"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
}
# tflint-ignore: terraform_unused_declarations
variable "nsec_records" {
  description = "NSEC records"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
}
# tflint-ignore: terraform_unused_declarations
variable "nsec3_records" {
  description = "NSEC3 records"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
}
# tflint-ignore: terraform_unused_declarations
variable "nsec3param_records" {
  description = "NSEC3PARAM records"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
}
# tflint-ignore: terraform_unused_declarations
variable "zonemd_records" {
  description = "ZONEMD records"
  type = list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))
  default = []
}
