<!-- BEGIN_TF_DOCS -->



# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 domain_validation_entries  = <list(object({
    domain_name       = string
    validation_scope  = string
    validation_method = string
  }))>
  	 edgerc_path  = <string>
  	 edgerc_section  = <string>
  	 enable_validation  = <bool>
  
	 # Optional variables
  	 domain_search_entries  = <list(object({
    domain_name      = string
    validation_scope = string
  }))> | default: []
}
 ```

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | >= 9.2.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [akamai_property_domainownership_domains.domains](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property_domainownership_domains) | resource |
| [akamai_property_domainownership_validation.validation](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property_domainownership_validation) | resource |
| [akamai_property_domainownership_search_domains.search](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_domainownership_search_domains) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_domain_validation_entries"></a> [domain\_validation\_entries](#input\_domain\_validation\_entries) | A list of objects with hostnames, domains, or wildcards to DOM validate | <pre>list(object({<br/>    domain_name       = string<br/>    validation_scope  = string<br/>    validation_method = string<br/>  }))</pre> | n/a | yes |
| <a name="input_edgerc_path"></a> [edgerc\_path](#input\_edgerc\_path) | Path to the .edgerc file | `string` | n/a | yes |
| <a name="input_edgerc_section"></a> [edgerc\_section](#input\_edgerc\_section) | Section in the .edgerc file | `string` | n/a | yes |
| <a name="input_enable_validation"></a> [enable\_validation](#input\_enable\_validation) | Set to true to enable domain validation | `bool` | n/a | yes |
| <a name="input_domain_search_entries"></a> [domain\_search\_entries](#input\_domain\_search\_entries) | List of domains to search validation status for | <pre>list(object({<br/>    domain_name      = string<br/>    validation_scope = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cname_validation_challenges"></a> [cname\_validation\_challenges](#output\_cname\_validation\_challenges) | Map of CNAME records for domain validation challenges (key: domain\_name) |
| <a name="output_domain_search_results"></a> [domain\_search\_results](#output\_domain\_search\_results) | n/a |
| <a name="output_txt_validation_challenges"></a> [txt\_validation\_challenges](#output\_txt\_validation\_challenges) | Map of TXT records for domain validation challenges (key: domain\_name) |
<!-- END_TF_DOCS -->