<!-- BEGIN_TF_DOCS -->



# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 activation_notes  = <string>
  	 config_id  = <string>
  	 config_name  = <string>
  	 notification_emails  = <list(string)>
  
	 # Optional variables
  	 activate_to_production  = <bool> | default: false
  	 activate_to_staging  = <bool> | default: false
  	 activation_to_production_exists  = <bool> | default: false
  	 activation_to_staging_exists  = <bool> | default: false
}
 ```

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | >= 9.2.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [akamai_appsec_activations.production](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_activations) | resource |
| [akamai_appsec_activations.staging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_activations) | resource |
| [akamai_appsec_configuration.config](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/appsec_configuration) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_activation_notes"></a> [activation\_notes](#input\_activation\_notes) | Notes included with the activation request (e.g., version or change summary). | `string` | n/a | yes |
| <a name="input_config_id"></a> [config\_id](#input\_config\_id) | Unique ID of the existing AppSec security configuration. | `string` | n/a | yes |
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | Name of the AppSec security configuration. | `string` | n/a | yes |
| <a name="input_notification_emails"></a> [notification\_emails](#input\_notification\_emails) | List of email addresses to receive activation notifications. | `list(string)` | n/a | yes |
| <a name="input_activate_to_production"></a> [activate\_to\_production](#input\_activate\_to\_production) | Set to true to activate the configuration to the PRODUCTION network. | `bool` | `false` | no |
| <a name="input_activate_to_staging"></a> [activate\_to\_staging](#input\_activate\_to\_staging) | Set to true to activate the configuration to the STAGING network. | `bool` | `false` | no |
| <a name="input_activation_to_production_exists"></a> [activation\_to\_production\_exists](#input\_activation\_to\_production\_exists) | Internal flag indicating whether a production activation already exists. Used by activation logic; do not manually modify. | `bool` | `false` | no |
| <a name="input_activation_to_staging_exists"></a> [activation\_to\_staging\_exists](#input\_activation\_to\_staging\_exists) | Internal flag indicating whether a staging activation already exists. Used by activation logic; do not manually modify. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->