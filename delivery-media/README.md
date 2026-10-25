<!-- BEGIN_TF_DOCS -->

# AMD delivery module

Creates a CP code, an edge hostname per hostname (one of 4 selectable
cert/TLS modes), renders the AMD rule tree via the ./rules submodule,
creates the property, and (optionally) activates it to staging/production.

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 activation_contacts  = <list(string)>
  	 contract_id  = <string>
  	 default_origin  = <string>
  	 group_id  = <string>
  	 hostnames  = <list(string)>
  	 name  = <string>
  
	 # Optional variables
  	 activate_to_production  = <bool> | default: false
  	 activate_to_staging  = <bool> | default: false
  	 activation_notes  = <string> | default: "Activated via Terraform"
  	 activation_to_production_exists  = <bool> | default: false
  	 activation_to_staging_exists  = <bool> | default: false
  	 additional_origins  = <map(object({
    origin_name         = string
    forward_host_header = string
    hostname_match      = list(string)
    path_match          = list(string)
  }))> | default: {}
  	 cache_key_query_params_behavior  = <string> | default: "IGNORE_ALL"
  	 certificate_id  = <number> | default: null
  	 client_country  = <string> | default: "UNKNOWN"
  	 content_catalog_size  = <string> | default: "UNKNOWN"
  	 content_popularity_distribution  = <string> | default: "UNKNOWN"
  	 content_type  = <string> | default: "HD"
  	 cpcode_name  = <string> | default: null
  	 customer_email  = <string> | default: null
  	 dash_media_encryption  = <bool> | default: false
  	 debug_key  = <string> | default: null
  	 edge_hostname_type  = <string> | default: "AKAMAIZED_HOSTNAME"
  	 enable_dash  = <bool> | default: true
  	 enable_debug  = <bool> | default: false
  	 enable_dynamic_throughput_optimization  = <bool> | default: true
  	 enable_hds  = <bool> | default: true
  	 enable_hls  = <bool> | default: true
  	 enable_http3  = <bool> | default: true
  	 enable_segmented_content_protection  = <bool> | default: false
  	 enable_smooth  = <bool> | default: true
  	 etls  = <bool> | default: true
  	 forward_host_header  = <string> | default: "REQUEST_HOST_HEADER"
  	 hls_media_encryption  = <bool> | default: false
  	 http2_enabled  = <bool> | default: true
  	 ip_behavior  = <string> | default: "IPV4"
  	 min_tls_version  = <string> | default: "DYNAMIC"
  	 noncompliance_reason  = <list(string)> | default: []
  	 origin_authentication_method  = <string> | default: "AUTOMATIC"
  	 origin_country  = <string> | default: "UNKNOWN"
  	 other_noncompliance_reason  = <string> | default: null
  	 peer_reviewed_by  = <string> | default: null
  	 product_id  = <string> | default: "prd_Adaptive_Media_Delivery"
  	 segment_duration_dash  = <string> | default: "SEGMENT_DURATION_6S"
  	 segment_duration_hds  = <string> | default: "SEGMENT_DURATION_6S"
  	 segment_duration_hls  = <string> | default: "SEGMENT_DURATION_10S"
  	 segment_duration_smooth  = <string> | default: "SEGMENT_DURATION_2S"
  	 segmented_media_optimization_behavior  = <string> | default: "ON_DEMAND"
  	 ticket_id  = <string> | default: null
  	 unit_tested  = <bool> | default: null
  	 verification_mode  = <string> | default: "PLATFORM_SETTINGS"
  	 version_notes  = <string> | default: "Initial Config"
}
 ```

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 10.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Resources

| Name | Type |
| ---- | ---- |
| [akamai_cp_code.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/cp_code) | resource |
| [akamai_edge_hostname.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname) | resource |
| [akamai_property.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property) | resource |
| [akamai_property_activation.production](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property_activation) | resource |
| [akamai_property_activation.staging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property_activation) | resource |
| [random_id.debug_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_rules"></a> [rules](#module\_rules) | ./rules | n/a |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_activation_contacts"></a> [activation\_contacts](#input\_activation\_contacts) | Email addresses notified on activation. | `list(string)` | n/a | yes |
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Akamai contract ID (e.g. ctr\_1-AB123). | `string` | n/a | yes |
| <a name="input_default_origin"></a> [default\_origin](#input\_default\_origin) | Origin hostname from where AMD fetches content. | `string` | n/a | yes |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | Akamai group ID (e.g. grp\_12345). | `string` | n/a | yes |
| <a name="input_hostnames"></a> [hostnames](#input\_hostnames) | List of hostnames, e.g. ["www.example.com", "media.example.com"].<br/>For SBD with etls=true, Akamai provisions the edgekey.net hostname<br/>automatically. For SBD with etls=false, EDGESUITE, and EDGEKEY, each<br/>entry is your own domain and its edge hostname is created as needed. For<br/>AKAMAIZED\_HOSTNAME, each entry is just a label (e.g. "abm-template-test")<br/>-- the .akamaized.net suffix is appended automatically and used as both<br/>cname\_from and cname\_to. | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Property name. | `string` | n/a | yes |
| <a name="input_activate_to_production"></a> [activate\_to\_production](#input\_activate\_to\_production) | Whether to activate the property to the production network. | `bool` | `false` | no |
| <a name="input_activate_to_staging"></a> [activate\_to\_staging](#input\_activate\_to\_staging) | Whether to activate the property to the staging network. | `bool` | `false` | no |
| <a name="input_activation_notes"></a> [activation\_notes](#input\_activation\_notes) | Notes attached to each activation. | `string` | `"Activated via Terraform"` | no |
| <a name="input_activation_to_production_exists"></a> [activation\_to\_production\_exists](#input\_activation\_to\_production\_exists) | Do not modify. Preserves the existing production activation when activate\_to\_production is false. | `bool` | `false` | no |
| <a name="input_activation_to_staging_exists"></a> [activation\_to\_staging\_exists](#input\_activation\_to\_staging\_exists) | Do not modify. Preserves the existing staging activation when activate\_to\_staging is false. | `bool` | `false` | no |
| <a name="input_additional_origins"></a> [additional\_origins](#input\_additional\_origins) | Optional additional origins selected by hostname and/or path criteria. | <pre>map(object({<br/>    origin_name         = string<br/>    forward_host_header = string<br/>    hostname_match      = list(string)<br/>    path_match          = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_cache_key_query_params_behavior"></a> [cache\_key\_query\_params\_behavior](#input\_cache\_key\_query\_params\_behavior) | How query parameters are handled in the cache key. | `string` | `"IGNORE_ALL"` | no |
| <a name="input_certificate_id"></a> [certificate\_id](#input\_certificate\_id) | CPS certificate enrollment ID. Required only when edge\_hostname\_type is EDGEKEY. | `number` | `null` | no |
| <a name="input_client_country"></a> [client\_country](#input\_client\_country) | Client country, or UNKNOWN when not applicable. | `string` | `"UNKNOWN"` | no |
| <a name="input_content_catalog_size"></a> [content\_catalog\_size](#input\_content\_catalog\_size) | Approximate size of the media catalog. | `string` | `"UNKNOWN"` | no |
| <a name="input_content_popularity_distribution"></a> [content\_popularity\_distribution](#input\_content\_popularity\_distribution) | Expected popularity distribution of content requests. | `string` | `"UNKNOWN"` | no |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | Primary content resolution, such as HD, SD, or 4K. | `string` | `"HD"` | no |
| <a name="input_cpcode_name"></a> [cpcode\_name](#input\_cpcode\_name) | Name for the CP code created for this property. Defaults to the property name if not set. | `string` | `null` | no |
| <a name="input_customer_email"></a> [customer\_email](#input\_customer\_email) | Customer contact email used when noncompliance\_reason is ["NONE"]. | `string` | `null` | no |
| <a name="input_dash_media_encryption"></a> [dash\_media\_encryption](#input\_dash\_media\_encryption) | Enable DASH media encryption when segmented content protection is enabled. | `bool` | `false` | no |
| <a name="input_debug_key"></a> [debug\_key](#input\_debug\_key) | Optional enhanced-debug key. If omitted while debug is enabled, Terraform generates a stable key. | `string` | `null` | no |
| <a name="input_edge_hostname_type"></a> [edge\_hostname\_type](#input\_edge\_hostname\_type) | Edge hostname mode: SBD (Secure By Default, no cert needed), EDGESUITE (aka Freeflow, <hostname>.edgesuite.net), EDGEKEY (aka ESSL, <hostname>.edgekey.net), or AKAMAIZED\_HOSTNAME (<label>.akamaized.net, hostname and edge hostname are identical). | `string` | `"AKAMAIZED_HOSTNAME"` | no |
| <a name="input_enable_dash"></a> [enable\_dash](#input\_enable\_dash) | Whether DASH is a delivery format. | `bool` | `true` | no |
| <a name="input_enable_debug"></a> [enable\_debug](#input\_enable\_debug) | Enable the enhanced\_debug behavior. Off by default; set to true in tfvars to enable. | `bool` | `false` | no |
| <a name="input_enable_dynamic_throughput_optimization"></a> [enable\_dynamic\_throughput\_optimization](#input\_enable\_dynamic\_throughput\_optimization) | Enable dynamic throughput optimization. | `bool` | `true` | no |
| <a name="input_enable_hds"></a> [enable\_hds](#input\_enable\_hds) | Whether HDS is a delivery format. | `bool` | `true` | no |
| <a name="input_enable_hls"></a> [enable\_hls](#input\_enable\_hls) | Whether HLS is a delivery format. | `bool` | `true` | no |
| <a name="input_enable_http3"></a> [enable\_http3](#input\_enable\_http3) | Enable HTTP/3 (QUIC). | `bool` | `true` | no |
| <a name="input_enable_segmented_content_protection"></a> [enable\_segmented\_content\_protection](#input\_enable\_segmented\_content\_protection) | Enable segmented content protection and media encryption. | `bool` | `false` | no |
| <a name="input_enable_smooth"></a> [enable\_smooth](#input\_enable\_smooth) | Whether Smooth Streaming is a delivery format. | `bool` | `true` | no |
| <a name="input_etls"></a> [etls](#input\_etls) | Security profile selector: SBD uses edgekey.net when true or edgesuite.net when false; EDGEKEY and AKAMAIZED\_HOSTNAME require true; EDGESUITE requires false. | `bool` | `true` | no |
| <a name="input_forward_host_header"></a> [forward\_host\_header](#input\_forward\_host\_header) | Host header forwarded to the origin. | `string` | `"REQUEST_HOST_HEADER"` | no |
| <a name="input_hls_media_encryption"></a> [hls\_media\_encryption](#input\_hls\_media\_encryption) | Enable HLS media encryption when segmented content protection is enabled. | `bool` | `false` | no |
| <a name="input_http2_enabled"></a> [http2\_enabled](#input\_http2\_enabled) | Enable HTTP/2 between edge and origin. | `bool` | `true` | no |
| <a name="input_ip_behavior"></a> [ip\_behavior](#input\_ip\_behavior) | IP version behavior for the edge hostname: IPV4 or IPV6\_COMPLIANCE. | `string` | `"IPV4"` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | Minimum TLS version for origin connections. | `string` | `"DYNAMIC"` | no |
| <a name="input_noncompliance_reason"></a> [noncompliance\_reason](#input\_noncompliance\_reason) | Compliance record marker for production activation. Allowed values: NONE, OTHER, NO\_PRODUCTION\_TRAFFIC, EMERGENCY. | `list(string)` | `[]` | no |
| <a name="input_origin_authentication_method"></a> [origin\_authentication\_method](#input\_origin\_authentication\_method) | Authentication method used to reach the origin. | `string` | `"AUTOMATIC"` | no |
| <a name="input_origin_country"></a> [origin\_country](#input\_origin\_country) | Country of the origin, or UNKNOWN when not applicable. | `string` | `"UNKNOWN"` | no |
| <a name="input_other_noncompliance_reason"></a> [other\_noncompliance\_reason](#input\_other\_noncompliance\_reason) | Free-text explanation used when noncompliance\_reason is ["OTHER"]. | `string` | `null` | no |
| <a name="input_peer_reviewed_by"></a> [peer\_reviewed\_by](#input\_peer\_reviewed\_by) | Peer reviewer identity used when noncompliance\_reason is ["NONE"]. | `string` | `null` | no |
| <a name="input_product_id"></a> [product\_id](#input\_product\_id) | Akamai product ID for this property. | `string` | `"prd_Adaptive_Media_Delivery"` | no |
| <a name="input_segment_duration_dash"></a> [segment\_duration\_dash](#input\_segment\_duration\_dash) | Segment duration for DASH content. | `string` | `"SEGMENT_DURATION_6S"` | no |
| <a name="input_segment_duration_hds"></a> [segment\_duration\_hds](#input\_segment\_duration\_hds) | Segment duration for HDS content. | `string` | `"SEGMENT_DURATION_6S"` | no |
| <a name="input_segment_duration_hls"></a> [segment\_duration\_hls](#input\_segment\_duration\_hls) | Segment duration for HLS content. | `string` | `"SEGMENT_DURATION_10S"` | no |
| <a name="input_segment_duration_smooth"></a> [segment\_duration\_smooth](#input\_segment\_duration\_smooth) | Segment duration for Smooth Streaming content. | `string` | `"SEGMENT_DURATION_2S"` | no |
| <a name="input_segmented_media_optimization_behavior"></a> [segmented\_media\_optimization\_behavior](#input\_segmented\_media\_optimization\_behavior) | Segmented media optimization mode: ON\_DEMAND or LIVE. | `string` | `"ON_DEMAND"` | no |
| <a name="input_ticket_id"></a> [ticket\_id](#input\_ticket\_id) | Change/ticket ID for production activation. | `string` | `null` | no |
| <a name="input_unit_tested"></a> [unit\_tested](#input\_unit\_tested) | Whether the change has been unit tested. Used when noncompliance\_reason is ["NONE"]. | `bool` | `null` | no |
| <a name="input_verification_mode"></a> [verification\_mode](#input\_verification\_mode) | Origin certificate verification mode. | `string` | `"PLATFORM_SETTINGS"` | no |
| <a name="input_version_notes"></a> [version\_notes](#input\_version\_notes) | Property version notes. | `string` | `"Initial Config"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cert_status"></a> [cert\_status](#output\_cert\_status) | Hostname-to-edge-hostname mapping with certificate provisioning type, for reference. |
| <a name="output_cpcode_id"></a> [cpcode\_id](#output\_cpcode\_id) | ID of the created CP code. |
| <a name="output_property_id"></a> [property\_id](#output\_property\_id) | ID of the created property. |
| <a name="output_rule_errors"></a> [rule\_errors](#output\_rule\_errors) | Validation errors returned by Property Manager for the rendered rule tree, if any. |
<!-- END_TF_DOCS -->