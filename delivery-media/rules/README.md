<!-- BEGIN_TF_DOCS -->

# AMD rules submodule

Renders the default rule tree for an Adaptive Media Delivery property:
origin config, CP code, AMD-specific behaviors (segmented media
optimization, content characteristics, throughput optimization, HTTP/3,
optional debug), plus the default CORS policy child rule.

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 cpcode_id  = <number>
  	 cpcode_name  = <string>
  	 default_origin  = <string>
  
	 # Optional variables
  	 additional_origins  = <map(object({
    origin_name         = string
    forward_host_header = string
    hostname_match      = list(string)
    path_match          = list(string)
  }))> | default: {}
  	 cache_key_query_params_behavior  = <string> | default: "IGNORE_ALL"
  	 client_country  = <string> | default: "UNKNOWN"
  	 content_catalog_size  = <string> | default: "UNKNOWN"
  	 content_popularity_distribution  = <string> | default: "UNKNOWN"
  	 content_type  = <string> | default: "HD"
  	 dash_media_encryption  = <bool> | default: false
  	 debug_key  = <string> | default: null
  	 enable_dash  = <bool> | default: true
  	 enable_debug  = <bool> | default: false
  	 enable_dynamic_throughput_optimization  = <bool> | default: true
  	 enable_hds  = <bool> | default: true
  	 enable_hls  = <bool> | default: true
  	 enable_http3  = <bool> | default: true
  	 enable_segmented_content_protection  = <bool> | default: false
  	 enable_smooth  = <bool> | default: true
  	 etls  = <bool> | default: false
  	 forward_host_header  = <string> | default: "REQUEST_HOST_HEADER"
  	 hls_media_encryption  = <bool> | default: false
  	 http2_enabled  = <bool> | default: true
  	 min_tls_version  = <string> | default: "DYNAMIC"
  	 origin_authentication_method  = <string> | default: "AUTOMATIC"
  	 origin_country  = <string> | default: "UNKNOWN"
  	 segment_duration_dash  = <string> | default: "SEGMENT_DURATION_6S"
  	 segment_duration_hds  = <string> | default: "SEGMENT_DURATION_6S"
  	 segment_duration_hls  = <string> | default: "SEGMENT_DURATION_10S"
  	 segment_duration_smooth  = <string> | default: "SEGMENT_DURATION_2S"
  	 segmented_media_optimization_behavior  = <string> | default: "ON_DEMAND"
  	 verification_mode  = <string> | default: "PLATFORM_SETTINGS"
}
 ```

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 10.1 |

## Resources

| Name | Type |
| ---- | ---- |
| [akamai_property_rules_builder.rule_additional_origin](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_additional_origins](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_cors_policy](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_default](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cpcode_id"></a> [cpcode\_id](#input\_cpcode\_id) | Numeric ID of the CP code created by the parent module, used for reporting/billing. | `number` | n/a | yes |
| <a name="input_cpcode_name"></a> [cpcode\_name](#input\_cpcode\_name) | Name of the CP code created by the parent module. | `string` | n/a | yes |
| <a name="input_default_origin"></a> [default\_origin](#input\_default\_origin) | Origin hostname from where AMD will fetch the content. | `string` | n/a | yes |
| <a name="input_additional_origins"></a> [additional\_origins](#input\_additional\_origins) | Optional additional origins selected by hostname and/or path criteria. | <pre>map(object({<br/>    origin_name         = string<br/>    forward_host_header = string<br/>    hostname_match      = list(string)<br/>    path_match          = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_cache_key_query_params_behavior"></a> [cache\_key\_query\_params\_behavior](#input\_cache\_key\_query\_params\_behavior) | How query parameters are treated in the cache key. | `string` | `"IGNORE_ALL"` | no |
| <a name="input_client_country"></a> [client\_country](#input\_client\_country) | Country used for client\_characteristics. UNKNOWN if not applicable. | `string` | `"UNKNOWN"` | no |
| <a name="input_content_catalog_size"></a> [content\_catalog\_size](#input\_content\_catalog\_size) | Approximate size of the media catalog served by this property. | `string` | `"UNKNOWN"` | no |
| <a name="input_content_popularity_distribution"></a> [content\_popularity\_distribution](#input\_content\_popularity\_distribution) | Expected popularity distribution of content requests. | `string` | `"UNKNOWN"` | no |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | Primary content resolution/type served (e.g. HD, SD, 4K). | `string` | `"HD"` | no |
| <a name="input_dash_media_encryption"></a> [dash\_media\_encryption](#input\_dash\_media\_encryption) | Enable DASH media encryption. Only applies when enable\_segmented\_content\_protection is true. | `bool` | `false` | no |
| <a name="input_debug_key"></a> [debug\_key](#input\_debug\_key) | Debug key for enhanced\_debug. Required only when enable\_debug is true. Treat as sensitive -- pass via TF\_VAR\_debug\_key or a secrets-managed tfvars file, never commit it. | `string` | `null` | no |
| <a name="input_enable_dash"></a> [enable\_dash](#input\_enable\_dash) | Whether DASH is a delivery format for this property. | `bool` | `true` | no |
| <a name="input_enable_debug"></a> [enable\_debug](#input\_enable\_debug) | Enable the enhanced\_debug behavior. Off by default -- avoid baking a live debug key into every property. | `bool` | `false` | no |
| <a name="input_enable_dynamic_throughput_optimization"></a> [enable\_dynamic\_throughput\_optimization](#input\_enable\_dynamic\_throughput\_optimization) | Enable dynamic throughput optimization for adaptive bitrate delivery. | `bool` | `true` | no |
| <a name="input_enable_hds"></a> [enable\_hds](#input\_enable\_hds) | Whether HDS is a delivery format for this property. | `bool` | `true` | no |
| <a name="input_enable_hls"></a> [enable\_hls](#input\_enable\_hls) | Whether HLS is a delivery format for this property. | `bool` | `true` | no |
| <a name="input_enable_http3"></a> [enable\_http3](#input\_enable\_http3) | Enable HTTP/3 (QUIC) support. | `bool` | `true` | no |
| <a name="input_enable_segmented_content_protection"></a> [enable\_segmented\_content\_protection](#input\_enable\_segmented\_content\_protection) | Master toggle for segmented content protection (token auth, media encryption). | `bool` | `false` | no |
| <a name="input_enable_smooth"></a> [enable\_smooth](#input\_enable\_smooth) | Whether Smooth Streaming is a delivery format for this property. | `bool` | `true` | no |
| <a name="input_etls"></a> [etls](#input\_etls) | Whether the property uses Enhanced TLS (is\_secure on the default rule). | `bool` | `false` | no |
| <a name="input_forward_host_header"></a> [forward\_host\_header](#input\_forward\_host\_header) | Value forwarded as the Host header to origin. Use REQUEST\_HOST\_HEADER, ORIGIN\_HOSTNAME, or a custom hostname. | `string` | `"REQUEST_HOST_HEADER"` | no |
| <a name="input_hls_media_encryption"></a> [hls\_media\_encryption](#input\_hls\_media\_encryption) | Enable HLS media encryption. Only applies when enable\_segmented\_content\_protection is true. | `bool` | `false` | no |
| <a name="input_http2_enabled"></a> [http2\_enabled](#input\_http2\_enabled) | Enable HTTP/2 between edge and origin. | `bool` | `true` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | Minimum TLS version for edge-to-origin connections. | `string` | `"DYNAMIC"` | no |
| <a name="input_origin_authentication_method"></a> [origin\_authentication\_method](#input\_origin\_authentication\_method) | Authentication method used to reach the origin. | `string` | `"AUTOMATIC"` | no |
| <a name="input_origin_country"></a> [origin\_country](#input\_origin\_country) | Country of the origin, used for origin\_characteristics. UNKNOWN if not applicable. | `string` | `"UNKNOWN"` | no |
| <a name="input_segment_duration_dash"></a> [segment\_duration\_dash](#input\_segment\_duration\_dash) | Segment duration for DASH content. | `string` | `"SEGMENT_DURATION_6S"` | no |
| <a name="input_segment_duration_hds"></a> [segment\_duration\_hds](#input\_segment\_duration\_hds) | Segment duration for HDS content. | `string` | `"SEGMENT_DURATION_6S"` | no |
| <a name="input_segment_duration_hls"></a> [segment\_duration\_hls](#input\_segment\_duration\_hls) | Segment duration for HLS content. | `string` | `"SEGMENT_DURATION_10S"` | no |
| <a name="input_segment_duration_smooth"></a> [segment\_duration\_smooth](#input\_segment\_duration\_smooth) | Segment duration for Smooth Streaming content. | `string` | `"SEGMENT_DURATION_2S"` | no |
| <a name="input_segmented_media_optimization_behavior"></a> [segmented\_media\_optimization\_behavior](#input\_segmented\_media\_optimization\_behavior) | Segmented media optimization mode: ON\_DEMAND or LIVE. | `string` | `"ON_DEMAND"` | no |
| <a name="input_verification_mode"></a> [verification\_mode](#input\_verification\_mode) | Origin certificate verification mode. | `string` | `"PLATFORM_SETTINGS"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_rule_format"></a> [rule\_format](#output\_rule\_format) | Rule format string produced by the default rule builder, passed through to akamai\_property. |
| <a name="output_rules"></a> [rules](#output\_rules) | Rendered JSON rule tree, passed through to akamai\_property. |
<!-- END_TF_DOCS -->