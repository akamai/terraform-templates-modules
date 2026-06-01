<!-- BEGIN_TF_DOCS -->

# Module: DataStream 2 (DS-managed / Decoupled)

This module provisions a DataStream 2 (DS2) configuration using the decoupled
workflow introduced in Milestone-1. It allows log collection without requiring
any DataStream behavior in the Property Manager.

## CP Code Modes

**Create mode** (default): Omit `cpcode_id`. The module creates a new CP Code
named after `cpcode_name` (or `name` if not set) under the given `product_id`.

**Bring-your-own mode**: Set `cpcode_id` to an existing CP Code ID. The module
skips CP Code creation entirely. `cpcode_name` and `product_id` are ignored.

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 contract_id  = <string>
  	 edgerc_section  = <string>
  	 group_id  = <string>
  	 name  = <string>
  	 property_ids  = <list(string)>
  
	 # Optional variables
  	 activate_stream  = <bool> | default: true
  	 azure_connector  = <object({
    display_name   = string
    account_name   = string
    container_name = string
    access_key     = string
    path           = string
  })> | default: null
  	 cpcode_id  = <number> | default: null
  	 cpcode_name  = <string> | default: null
  	 datadog_connector  = <object({
    display_name = string
    endpoint     = string
    auth_token   = string
    service      = optional(string)
    source       = optional(string)
    tags         = optional(string)
  })> | default: null
  	 dataset_fields_ids  = <list(number)> | default: [
  1000,
  1002,
  1015,
  1037,
  1100
]
  	 edgerc_path  = <string> | default: "~/.edgerc"
  	 enable_midgress  = <bool> | default: false
  	 log_format  = <string> | default: "JSON"
  	 product_id  = <string> | default: "SPM"
  	 s3_connector  = <object({
    display_name      = string
    bucket            = string
    region            = string
    access_key        = string
    secret_access_key = string
    path              = string
  })> | default: null
  	 splunk_connector  = <object({
    display_name          = string
    endpoint              = string
    event_collector_token = string
  })> | default: null
}
 ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 9.0 |

## Resources

| Name | Type |
|------|------|
| [akamai_cp_code.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/cp_code) | resource |
| [akamai_datastream.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/datastream) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Contract ID for property/config creation. | `string` | n/a | yes |
| <a name="input_edgerc_section"></a> [edgerc\_section](#input\_edgerc\_section) | Section in the .edgerc file.<br/><br/>    For professional services, it is recommended to create a new section for<br/>    each account managed. | `string` | n/a | yes |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | Group ID for property/config creation. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the DataStream 2 configuration and CP Code. | `string` | n/a | yes |
| <a name="input_property_ids"></a> [property\_ids](#input\_property\_ids) | List of Akamai Property IDs to monitor (Decoupled architecture). | `list(string)` | n/a | yes |
| <a name="input_activate_stream"></a> [activate\_stream](#input\_activate\_stream) | Whether to activate the stream upon creation. | `bool` | `true` | no |
| <a name="input_azure_connector"></a> [azure\_connector](#input\_azure\_connector) | Configuration for Azure Storage destination. | <pre>object({<br/>    display_name   = string<br/>    account_name   = string<br/>    container_name = string<br/>    access_key     = string<br/>    path           = string<br/>  })</pre> | `null` | no |
| <a name="input_cpcode_id"></a> [cpcode\_id](#input\_cpcode\_id) | ID of an existing CP Code to use for this stream.<br/><br/>    When set, the module skips CP Code creation entirely and the<br/>    `cpcode_name` and `product_id` variables are ignored.<br/><br/>    When null (default), the module creates a new CP Code using<br/>    `cpcode_name` (or `name`) and `product_id`. | `number` | `null` | no |
| <a name="input_cpcode_name"></a> [cpcode\_name](#input\_cpcode\_name) | Optional custom name for the CP Code. If null, 'name' is used. | `string` | `null` | no |
| <a name="input_datadog_connector"></a> [datadog\_connector](#input\_datadog\_connector) | Configuration for Datadog destination.<br/><br/>    NOTE: Akamai DataStream only supports Datadog v1 endpoints, not v2.<br/>    Akamai validates the API key with a live POST before creating the stream.<br/>    Correct endpoint format (include https:// scheme):<br/>      EU: https://http-intake.logs.datadoghq.eu/v1/input<br/>      US: https://http-intake.logs.datadoghq.com/v1/input | <pre>object({<br/>    display_name = string<br/>    endpoint     = string<br/>    auth_token   = string<br/>    service      = optional(string)<br/>    source       = optional(string)<br/>    tags         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_dataset_fields_ids"></a> [dataset\_fields\_ids](#input\_dataset\_fields\_ids) | List of dataset fields IDs to log. | `list(number)` | <pre>[<br/>  1000,<br/>  1002,<br/>  1015,<br/>  1037,<br/>  1100<br/>]</pre> | no |
| <a name="input_edgerc_path"></a> [edgerc\_path](#input\_edgerc\_path) | Path to the .edgerc file. | `string` | `"~/.edgerc"` | no |
| <a name="input_enable_midgress"></a> [enable\_midgress](#input\_enable\_midgress) | Enable midgress traffic collection (sets collect\_midgress on the stream). Requires dataset field 2084 to log midgress hits. | `bool` | `false` | no |
| <a name="input_log_format"></a> [log\_format](#input\_log\_format) | Format of the logs. Must be JSON or STRUCTURED. When STRUCTURED, a field\_delimiter is used. | `string` | `"JSON"` | no |
| <a name="input_product_id"></a> [product\_id](#input\_product\_id) | Product ID (e.g., SPM for Ion). Only used when cpcode\_id is null and a new CP Code is created. | `string` | `"SPM"` | no |
| <a name="input_s3_connector"></a> [s3\_connector](#input\_s3\_connector) | Configuration for AWS S3 destination. | <pre>object({<br/>    display_name      = string<br/>    bucket            = string<br/>    region            = string<br/>    access_key        = string<br/>    secret_access_key = string<br/>    path              = string<br/>  })</pre> | `null` | no |
| <a name="input_splunk_connector"></a> [splunk\_connector](#input\_splunk\_connector) | Configuration for Splunk destination. NOTE: Akamai DataStream only accepts the Splunk HEC raw endpoint — the URL must end with /services/collector/raw. | <pre>object({<br/>    display_name          = string<br/>    endpoint              = string<br/>    event_collector_token = string<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpcode_id"></a> [cpcode\_id](#output\_cpcode\_id) | The CP Code ID (created by this module or passed in via cpcode\_id). |
| <a name="output_cpcode_name"></a> [cpcode\_name](#output\_cpcode\_name) | The name of the CP Code. Null when an existing cpcode\_id was provided. |
| <a name="output_stream_id"></a> [stream\_id](#output\_stream\_id) | The ID of the created DataStream. |
| <a name="output_stream_name"></a> [stream\_name](#output\_stream\_name) | The name of the created DataStream. |
<!-- END_TF_DOCS -->