<!-- BEGIN_TF_DOCS -->

# Activation: Application Security Configuration

The use case for this module is to activate a new Application Security Configuration version
independently of the modules in use, and following Akamai Professional Services Best Practices.

Read on to find out which resources are provisioned as part of this
process, and how to customize!

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 activation_notes  = <string>
  	 config_id  = <number>
  	 config_name  = <string>
  	 notification_emails  = <list(string)>
  
	 # Optional variables
  	 activate_to_production  = <bool> | default: false
  	 activate_to_staging  = <bool> | default: false
  	 activation_to_production_exists  = <bool> | default: false
  	 activation_to_staging_exists  = <bool> | default: false
  	 dummy_temp_var  = <string> | default: "test"
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
| [akamai_appsec_activations.production](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_activations) | resource |
| [akamai_appsec_activations.staging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_activations) | resource |
| [akamai_appsec_configuration.config](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/appsec_configuration) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activation_notes"></a> [activation\_notes](#input\_activation\_notes) | Notes for the activation | `string` | n/a | yes |
| <a name="input_config_id"></a> [config\_id](#input\_config\_id) | Security configuration ID | `number` | n/a | yes |
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | Security configuration name | `string` | n/a | yes |
| <a name="input_notification_emails"></a> [notification\_emails](#input\_notification\_emails) | List or emails for notifications | `list(string)` | n/a | yes |
| <a name="input_activate_to_production"></a> [activate\_to\_production](#input\_activate\_to\_production) | Set to true to directly activate on the production network. | `bool` | `false` | no |
| <a name="input_activate_to_staging"></a> [activate\_to\_staging](#input\_activate\_to\_staging) | Set to true to directly activate on the staging network. | `bool` | `false` | no |
| <a name="input_activation_to_production_exists"></a> [activation\_to\_production\_exists](#input\_activation\_to\_production\_exists) | Do not modify. Flag used together with the logic in the activation resources for the initial activation to production. | `bool` | `false` | no |
| <a name="input_activation_to_staging_exists"></a> [activation\_to\_staging\_exists](#input\_activation\_to\_staging\_exists) | Do not modify. Flag used together with the logic in the activation resources for the initial activation to staging. | `bool` | `false` | no |
| <a name="input_dummy_temp_var"></a> [dummy\_temp\_var](#input\_dummy\_temp\_var) | n/a | `string` | `"test"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->