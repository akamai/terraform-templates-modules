<!-- BEGIN_TF_DOCS -->



# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 additional_origins  = <map(object({
    origin_name         = string
    forward_host_header = string
    hostname_match      = list(string)
    path_match          = list(string)
  }))>
  	 default_origin  = <string>
  	 etls  = <bool>
  
	 # Optional variables
  	 cpcode_id  = <number> | default: null
  	 cpcode_name  = <string> | default: null
  	 default_cpcode  = <bool> | default: false
  	 enable_mPulse  = <bool> | default: true
  	 forward_host_header  = <string> | default: "REQUEST_HOST_HEADER"
  	 product_id  = <string> | default: "Site_Accel"
  	 sure_route_test_object  = <string> | default: "/akamai/testobject.html"
  	 td_region  = <string> | default: "CH2"
}
 ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 10.1 |

## Resources

| Name | Type |
|------|------|
| [akamai_property_rules_builder.rule_accelerate_delivery](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_adaptive_acceleration](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_additional_origin](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_additional_origins](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_allowed_methods](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_augment_insights](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_bots](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_compressible_objects](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_css_and_java_script](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_default](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_delete](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_files](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_fonts](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_geolocation](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_graph_ql](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_hsts](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_html_pages](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_images](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_increase_availability](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_log_delivery](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_m_pulse_rum](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_minimize_payload](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_obfuscate_backend_info](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_obfuscate_debug_info](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_offload_origin](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_options](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_origin_connectivity](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_origin_health](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_other_static_objects](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_patch](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_post](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_post_responses](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_prefetchable_objects](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_prefetching](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_prefetching_objects](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_protocol_optimizations](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_put](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_redirects](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_script_management](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_simulate_failover](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_site_failover](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_strengthen_security](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_traffic_reporting](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |
| [akamai_property_rules_builder.rule_uncacheable_objects](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_builder) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_origins"></a> [additional\_origins](#input\_additional\_origins) | Additional origins for the property. For now the match is only by hostname. The field forward\_host\_header allows specifying a custom host header for each additional origin.Possible fixed values are ORIGIN\_HOSTNAME or REQUEST\_HOST\_HEADER. But the user can also select any host header they would like to use as a custom value. | <pre>map(object({<br/>    origin_name         = string<br/>    forward_host_header = string<br/>    hostname_match      = list(string)<br/>    path_match          = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_default_origin"></a> [default\_origin](#input\_default\_origin) | Default origin server for all properties | `string` | n/a | yes |
| <a name="input_etls"></a> [etls](#input\_etls) | Boolean to switch between Enhanced and Standard TLS modes | `bool` | n/a | yes |
| <a name="input_cpcode_id"></a> [cpcode\_id](#input\_cpcode\_id) | Default CP Code id. | `number` | `null` | no |
| <a name="input_cpcode_name"></a> [cpcode\_name](#input\_cpcode\_name) | Default CP Code name. Will be the property name (var.name) if null. | `string` | `null` | no |
| <a name="input_default_cpcode"></a> [default\_cpcode](#input\_default\_cpcode) | Boolean to enable the default CP Code for all properties. If false, the CP Code must be specified in the property definition. | `bool` | `false` | no |
| <a name="input_enable_mPulse"></a> [enable\_mPulse](#input\_enable\_mPulse) | Boolean tod ecide whether to inject the mpulse behavior | `bool` | `true` | no |
| <a name="input_forward_host_header"></a> [forward\_host\_header](#input\_forward\_host\_header) | Host header to be forwarded to the origin server. Possible fixed values are ORIGIN\_HOSTNAME or REQUEST\_HOST\_HEADER. But the user can also select any host header they would like to use as a custom value. | `string` | `"REQUEST_HOST_HEADER"` | no |
| <a name="input_product_id"></a> [product\_id](#input\_product\_id) | Property Manager product. [ION => Fresca, ION Premier => SPM, DSA => Site\_Accel] | `string` | `"Site_Accel"` | no |
| <a name="input_sure_route_test_object"></a> [sure\_route\_test\_object](#input\_sure\_route\_test\_object) | Test object path for SureRoute | `string` | `"/akamai/testobject.html"` | no |
| <a name="input_td_region"></a> [td\_region](#input\_td\_region) | Region (map) for Tiered Distribution behaviour. Only applies if network is Standard TLS.<br/>Options are: CH2, CHAPAC, CHEU2, CHEUS2, CHWUS2, CHCUS2, CHAUS | `string` | `"CH2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rule_format"></a> [rule\_format](#output\_rule\_format) | n/a |
| <a name="output_rules"></a> [rules](#output\_rules) | n/a |
<!-- END_TF_DOCS -->