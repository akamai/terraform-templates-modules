<!-- BEGIN_TF_DOCS -->

# Module: edns (Akamai Edge DNS)

This Terraform module provisions and manages Akamai Edge DNS zones.
It supports both PRIMARY and SECONDARY zones and provides a unified,
opinionated interface for managing DNS infrastructure in a safe and
predictable way.

--------------------------------------------------------------------
## Supported Zone Types

### PRIMARY
- Authoritative DNS zone hosted on Akamai
- DNS records are fully managed by Terraform
- Supports a wide range of DNS record types (A, AAAA, CNAME, MX, etc.)
- Optional SOA management

### SECONDARY
- Slave DNS zone
- Zone transfers are performed from external master servers
- Requires `masters` (IP addresses)
- Optional TSIG authentication
- DNS records are NOT managed by this module

The `zone_type` variable is case-insensitive and internally normalized
to lowercase for consistency.

--------------------------------------------------------------------
## High-level Behavior

- A single `akamai_dns_zone` resource is always created
- All DNS record resources are conditionally created ONLY when
  `zone_type = primary`
- For `secondary` zones, record-related logic is skipped entirely
- This guarantees that PRIMARY and SECONDARY behaviors never overlap

--------------------------------------------------------------------
## DNS Record Management (PRIMARY only)

The module supports the following DNS record types:

Standard:
- A
- AAAA
- CNAME
- TXT
- NS
- PTR
- LOC
- SPF

Service / Routing:
- MX
- SRV
- CAA
- NAPTR
- HTTPS
- SVCB

Informational:
- RP
- HINFO
- CERT

DNSSEC-related:
- DS
- DNSKEY
- SSHFP

Akamai-specific:
- AKAMAICDN

Each record type is defined via a list variable in `terraform.tfvars`.
Empty lists result in no resources being created.
Duplicate record names are explicitly validated and rejected.

--------------------------------------------------------------------
## SOA Handling

- SOA management is OPTIONAL
- If `soa = null`, the SOA record is not managed by Terraform
- If `soa` is provided, the SOA record is explicitly created/updated

After zone creation, the module:
- Waits for propagation (PRIMARY only)
- Reads the SOA record from the apex
- Exposes both raw and parsed SOA data via outputs

This allows:
- Verification of SOA values
- Easy troubleshooting
- Safe coexistence with externally managed SOA records

--------------------------------------------------------------------
## Nameservers (NS) and Authorities

The module retrieves the authoritative nameservers assigned by Akamai
to the provided contract using `akamai_authorities_set`.

Behavior:
- Akamai-assigned NS are always fetched
- Hostnames are normalized (no trailing dots)
- IPv4 addresses are resolved safely (A records only)

This information can be used to:
- Delegate the zone from a parent DNS
- Populate SECONDARY `masters`
- Configure firewalls / ACLs

NXDOMAIN-safe logic is used to avoid Terraform failures.

--------------------------------------------------------------------
## Outputs

The module exposes:
- Zone metadata (name, type)
- SOA (raw and parsed, PRIMARY only)
- Akamai authoritative nameservers
- Nameserver-to-IP mappings
- Helper snippets that can be copied directly into tfvars

These outputs are designed to support automation, debugging,
and cross-team handoffs.

--------------------------------------------------------------------
## Design Principles

- Clear separation of PRIMARY vs SECONDARY logic
- Defensive defaults (empty maps, conditional resources)
- Idempotent behavior
- No hidden side effects
- Safe to use across multiple environments and states

--------------------------------------------------------------------
## Notes

- This module does NOT manage Terraform backends or state
- Backend configuration MUST be handled by the consuming templates
- README.md is generated automatically via terraform-docs
  using this inline documentation

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 contract_id  = <string>
  	 edgerc_section  = <string>
  	 group_id  = <string>
  	 zone_name  = <string>
  	 zone_type  = <string>
  
	 # Optional variables
  	 a_records  = <list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))> | default: []
  	 aaaa_records  = <list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))> | default: []
  	 akamaicdn_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 akamaitlc_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 caa_records  = <list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))> | default: []
  	 cdnskey_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 cds_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 cert_records  = <list(object({
    name          = string
    ttl           = number
    type_value    = optional(number)
    type_mnemonic = optional(string)
    keytag        = number
    algorithm     = number
    certificate   = string
  }))> | default: []
  	 cname_records  = <list(object({
    name   = string
    target = list(string) # zwykle jeden FQDN
    ttl    = number
  }))> | default: []
  	 dnskey_records  = <list(object({
    name      = string
    ttl       = number
    flags     = number
    protocol  = number
    algorithm = number
    key       = string #base64 public key
  }))> | default: []
  	 ds_records  = <list(object({
    name        = string
    ttl         = number
    keytag      = number
    algorithm   = number
    digest_type = number
    digest      = string
  }))> | default: []
  	 edgerc_path  = <string> | default: null
  	 hinfo_records  = <list(object({
    name     = string
    hardware = string
    software = string
    ttl      = number
  }))> | default: []
  	 https_records  = <list(object({
    name     = string
    ttl      = number
    priority = number
    target   = string                 # .
    params   = optional(list(string)) # ex. ['alpn="h2,h3"', 'ipv4hint="203.0.113.10"']
  }))> | default: []
  	 loc_records  = <list(object({
    name   = string
    target = list(string) # ex. '52 13 12.000 N 21 00 30.000 E 12.00m 10.00m 2.00m 2.00m'
    ttl    = number
  }))> | default: []
  	 masters  = <list(string)> | default: []
  	 mx_records  = <list(object({
    name               = string
    target             = list(string)
    ttl                = number
    priority           = optional(number)
    priority_increment = optional(number)
  }))> | default: []
  	 naptr_records  = <list(object({
    name        = string
    ttl         = number
    order       = number
    preference  = number
    flagsnaptr  = string
    service     = string
    regexp      = string
    replacement = string
  }))> | default: []
  	 ns_records  = <list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))> | default: []
  	 nsec3_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 nsec3param_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 nsec_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 ptr_records  = <list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))> | default: []
  	 rp_records  = <list(object({
    name    = string
    mailbox = string
    txt     = string
    ttl     = number
  }))> | default: []
  	 rrsig_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
  	 soa  = <object({
    email        = string
    name_server  = string
    ttl          = number
    refresh      = number
    retry        = number
    expiry       = number
    nxdomain_ttl = number
  })> | default: null
  	 spf_records  = <list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))> | default: []
  	 srv_records  = <list(object({
    name     = string
    target   = list(string)
    ttl      = number
    priority = optional(number)
    weight   = optional(number)
    port     = optional(number)
  }))> | default: []
  	 sshfp_records  = <list(object({
    name             = string
    ttl              = number
    algorithm        = number
    fingerprint_type = number
    fingerprint      = string
  }))> | default: []
  	 svcb_records  = <list(object({
    name     = string
    ttl      = number
    priority = number
    target   = string
    params   = optional(list(string))
  }))> | default: []
  	 tlsa_records  = <list(object({
    name        = string
    ttl         = number
    usage       = number
    selector    = number
    match_type  = number
    certificate = string
  }))> | default: []
  	 tsig_key  = <object({
    name      = string
    algorithm = string
    secret    = string
  })> | default: null
  	 txt_records  = <list(object({
    name   = string
    target = list(string)
    ttl    = number
  }))> | default: []
  	 zonemd_records  = <list(object({
    name   = string
    ttl    = number
    target = list(string)
  }))> | default: []
}
 ```

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 9.2 |
| <a name="requirement_dns"></a> [dns](#requirement\_dns) | ~> 3.4 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.13 |

## Resources

| Name | Type |
| ---- | ---- |
| [akamai_dns_record.a_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.aaaa_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.akamaicdn_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.apex_soa](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.caa_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.cert_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.cname_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.dnskey_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.ds_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.hinfo_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.https_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.loc_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.mx_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.naptr_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.ns_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.ptr_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.rp_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.spf_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.srv_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.sshfp_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.svcb_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_record.txt_records](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_record) | resource |
| [akamai_dns_zone.dns_zone](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/dns_zone) | resource |
| [time_sleep.wait_for_zone](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [akamai_authorities_set.my_authorities_set](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/authorities_set) | data source |
| [akamai_dns_record_set.zone_soa](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/dns_record_set) | data source |
| [dns_a_record_set.akamai_ns_a](https://registry.terraform.io/providers/hashicorp/dns/latest/docs/data-sources/a_record_set) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Contract ID for property/config creation | `string` | n/a | yes |
| <a name="input_edgerc_section"></a> [edgerc\_section](#input\_edgerc\_section) | Section in the .edgerc file.<br/><br/>    For professional services, it is recommended to create a new section for<br/>    each account managed. | `string` | n/a | yes |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | Group ID for property/config creation. | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | n/a | `string` | n/a | yes |
| <a name="input_zone_type"></a> [zone\_type](#input\_zone\_type) | Zone type: primary or secondary (case-insensitive) | `string` | n/a | yes |
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | A records | <pre>list(object({<br/>    name   = string<br/>    target = list(string)<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records) | AAAA records | <pre>list(object({<br/>    name   = string<br/>    target = list(string)<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_akamaicdn_records"></a> [akamaicdn\_records](#input\_akamaicdn\_records) | AKAMAICDN (apex mapping) | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_akamaitlc_records"></a> [akamaitlc\_records](#input\_akamaitlc\_records) | AKAMAITLC (proprietary; zwykle read-only w TF) | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_caa_records"></a> [caa\_records](#input\_caa\_records) | CAA records | <pre>list(object({<br/>    name   = string<br/>    target = list(string)<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_cdnskey_records"></a> [cdnskey\_records](#input\_cdnskey\_records) | CDNSKEY records | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_cds_records"></a> [cds\_records](#input\_cds\_records) | CDS records | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_cert_records"></a> [cert\_records](#input\_cert\_records) | CERT records | <pre>list(object({<br/>    name          = string<br/>    ttl           = number<br/>    type_value    = optional(number)<br/>    type_mnemonic = optional(string)<br/>    keytag        = number<br/>    algorithm     = number<br/>    certificate   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | CNAME records | <pre>list(object({<br/>    name   = string<br/>    target = list(string) # zwykle jeden FQDN<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_dnskey_records"></a> [dnskey\_records](#input\_dnskey\_records) | DNSKEY records (DNSSEC) | <pre>list(object({<br/>    name      = string<br/>    ttl       = number<br/>    flags     = number<br/>    protocol  = number<br/>    algorithm = number<br/>    key       = string #base64 public key<br/>  }))</pre> | `[]` | no |
| <a name="input_ds_records"></a> [ds\_records](#input\_ds\_records) | DS records (DNSSEC) | <pre>list(object({<br/>    name        = string<br/>    ttl         = number<br/>    keytag      = number<br/>    algorithm   = number<br/>    digest_type = number<br/>    digest      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_edgerc_path"></a> [edgerc\_path](#input\_edgerc\_path) | Path to the .edgerc file. | `string` | `null` | no |
| <a name="input_hinfo_records"></a> [hinfo\_records](#input\_hinfo\_records) | HINFO records (Host info) | <pre>list(object({<br/>    name     = string<br/>    hardware = string<br/>    software = string<br/>    ttl      = number<br/>  }))</pre> | `[]` | no |
| <a name="input_https_records"></a> [https\_records](#input\_https\_records) | HTTPS records (Service Binding) | <pre>list(object({<br/>    name     = string<br/>    ttl      = number<br/>    priority = number<br/>    target   = string                 # .<br/>    params   = optional(list(string)) # ex. ['alpn="h2,h3"', 'ipv4hint="203.0.113.10"']<br/>  }))</pre> | `[]` | no |
| <a name="input_loc_records"></a> [loc\_records](#input\_loc\_records) | LOC records (geolocation) | <pre>list(object({<br/>    name   = string<br/>    target = list(string) # ex. '52 13 12.000 N 21 00 30.000 E 12.00m 10.00m 2.00m 2.00m'<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_masters"></a> [masters](#input\_masters) | Masters for secondary zone (used only when zone\_type == "secondary") | `list(string)` | `[]` | no |
| <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records) | MX records | <pre>list(object({<br/>    name               = string<br/>    target             = list(string)<br/>    ttl                = number<br/>    priority           = optional(number)<br/>    priority_increment = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_naptr_records"></a> [naptr\_records](#input\_naptr\_records) | NAPTR records | <pre>list(object({<br/>    name        = string<br/>    ttl         = number<br/>    order       = number<br/>    preference  = number<br/>    flagsnaptr  = string<br/>    service     = string<br/>    regexp      = string<br/>    replacement = string<br/>  }))</pre> | `[]` | no |
| <a name="input_ns_records"></a> [ns\_records](#input\_ns\_records) | NS records (delegacje subdomen lub override apex) | <pre>list(object({<br/>    name   = string<br/>    target = list(string)<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_nsec3_records"></a> [nsec3\_records](#input\_nsec3\_records) | NSEC3 records | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_nsec3param_records"></a> [nsec3param\_records](#input\_nsec3param\_records) | NSEC3PARAM records | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_nsec_records"></a> [nsec\_records](#input\_nsec\_records) | NSEC records | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records) | PTR records | <pre>list(object({<br/>    name   = string<br/>    target = list(string)<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_rp_records"></a> [rp\_records](#input\_rp\_records) | RP records (Responsible Person) | <pre>list(object({<br/>    name    = string<br/>    mailbox = string<br/>    txt     = string<br/>    ttl     = number<br/>  }))</pre> | `[]` | no |
| <a name="input_rrsig_records"></a> [rrsig\_records](#input\_rrsig\_records) | RRSIG records | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_soa"></a> [soa](#input\_soa) | If null, SOA is not managed. | <pre>object({<br/>    email        = string<br/>    name_server  = string<br/>    ttl          = number<br/>    refresh      = number<br/>    retry        = number<br/>    expiry       = number<br/>    nxdomain_ttl = number<br/>  })</pre> | `null` | no |
| <a name="input_spf_records"></a> [spf\_records](#input\_spf\_records) | SPF records (deprecated RFC; użycie jak TXT) | <pre>list(object({<br/>    name   = string<br/>    target = list(string)<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records) | SRV records | <pre>list(object({<br/>    name     = string<br/>    target   = list(string)<br/>    ttl      = number<br/>    priority = optional(number)<br/>    weight   = optional(number)<br/>    port     = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_sshfp_records"></a> [sshfp\_records](#input\_sshfp\_records) | SSHFP records | <pre>list(object({<br/>    name             = string<br/>    ttl              = number<br/>    algorithm        = number<br/>    fingerprint_type = number<br/>    fingerprint      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_svcb_records"></a> [svcb\_records](#input\_svcb\_records) | SVCB records (Service Binding) | <pre>list(object({<br/>    name     = string<br/>    ttl      = number<br/>    priority = number<br/>    target   = string<br/>    params   = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_tlsa_records"></a> [tlsa\_records](#input\_tlsa\_records) | TLSA records (DANE) | <pre>list(object({<br/>    name        = string<br/>    ttl         = number<br/>    usage       = number<br/>    selector    = number<br/>    match_type  = number<br/>    certificate = string<br/>  }))</pre> | `[]` | no |
| <a name="input_tsig_key"></a> [tsig\_key](#input\_tsig\_key) | Optional TSIG key for secondary transfers | <pre>object({<br/>    name      = string<br/>    algorithm = string<br/>    secret    = string<br/>  })</pre> | `null` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | TXT records | <pre>list(object({<br/>    name   = string<br/>    target = list(string)<br/>    ttl    = number<br/>  }))</pre> | `[]` | no |
| <a name="input_zonemd_records"></a> [zonemd\_records](#input\_zonemd\_records) | ZONEMD records | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    target = list(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_akamai_authorities_only"></a> [akamai\_authorities\_only](#output\_akamai\_authorities\_only) | Authoritative nameservers assigned by Akamai (FQDNs) |
| <a name="output_authorities_plus_custom_ns"></a> [authorities\_plus\_custom\_ns](#output\_authorities\_plus\_custom\_ns) | Union of Akamai authoritative NS and custom NS targets (FQDNs) |
| <a name="output_authorities_plus_custom_ns_ips"></a> [authorities\_plus\_custom\_ns\_ips](#output\_authorities\_plus\_custom\_ns\_ips) | Map: NS hostname => IPv4 list or NO\_IP |
| <a name="output_secondary_masters_tfvars_snippet"></a> [secondary\_masters\_tfvars\_snippet](#output\_secondary\_masters\_tfvars\_snippet) | Ready-to-paste tfvars snippet for SECONDARY masters |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | DNS zone name |
| <a name="output_zone_soa_parsed"></a> [zone\_soa\_parsed](#output\_zone\_soa\_parsed) | Parsed SOA fields (PRIMARY only) |
| <a name="output_zone_soa_raw"></a> [zone\_soa\_raw](#output\_zone\_soa\_raw) | Raw SOA RDATA string from the apex (PRIMARY only) |
| <a name="output_zone_transfer_masters"></a> [zone\_transfer\_masters](#output\_zone\_transfer\_masters) | Configured master server IPs for SECONDARY zones |
| <a name="output_zone_type"></a> [zone\_type](#output\_zone\_type) | DNS zone type (PRIMARY or SECONDARY) |
<!-- END_TF_DOCS -->