<!-- BEGIN_TF_DOCS -->

# Onboarding: new-property for ION Premier

The use case for this module is to quickly create a new configuration
serving a set of hostnames.

Read on to find out which resources are provisioned as part of this
process, and how to customize!

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 additional_origins  = <map(object({
    origin_name    = string
    hostname_match = list(string)
    path_match     = list(string)
  }))>
  	 contract_id  = <string>
  	 default_origin  = <string>
  	 etls  = <bool>
  	 group_id  = <string>
  	 hostnames  = <list(string)>
  	 name  = <string>
  	 notification_emails  = <list(string)>
  
	 # Optional variables
  	 activate_to_production  = <bool> | default: false
  	 activate_to_staging  = <bool> | default: false
  	 activation_notes  = <string> | default: "activated with terraform"
  	 activation_to_production_exists  = <bool> | default: false
  	 activation_to_staging_exists  = <bool> | default: false
  	 certificate_id  = <number> | default: null
  	 cpcode_name  = <string> | default: null
  	 customer_email  = <string> | default: null
  	 dummy_test  = <string> | default: "dummy_test"
  	 ehn_domain  = <string> | default: null
  	 enable_mPulse  = <bool> | default: true
  	 ip_behavior  = <string> | default: "IPV6_COMPLIANCE"
  	 noncompliance_reason  = <list(string)> | default: []
  	 other_noncompliance_reason  = <string> | default: null
  	 peer_reviewed_by  = <string> | default: null
  	 product_id  = <string> | default: "Site_Accel"
  	 secure_by_default  = <bool> | default: true
  	 sure_route_test_object  = <string> | default: "/akamai/testobject.html"
  	 td_region  = <string> | default: "CH2"
  	 ticket_id  = <string> | default: null
  	 unit_tested  = <bool> | default: null
  	 version_notes  = <string> | default: "Initial Config"
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
| [akamai_edge_hostname.edge_hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname) | resource |
| [akamai_property.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property) | resource |
| [akamai_property_activation.production](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property_activation) | resource |
| [akamai_property_activation.staging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property_activation) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rules"></a> [rules](#module\_rules) | ./rules | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_origins"></a> [additional\_origins](#input\_additional\_origins) | Additional origins for the property. For now the match is only by hostname. | <pre>map(object({<br/>    origin_name    = string<br/>    hostname_match = list(string)<br/>    path_match     = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Contract ID for property/config creation | `string` | n/a | yes |
| <a name="input_default_origin"></a> [default\_origin](#input\_default\_origin) | Default origin server for all properties | `string` | n/a | yes |
| <a name="input_etls"></a> [etls](#input\_etls) | Boolean to switch between Enhanced and Standard TLS modes | `bool` | n/a | yes |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | Group ID for property/config creation. | `string` | n/a | yes |
| <a name="input_hostnames"></a> [hostnames](#input\_hostnames) | List of hostnames. | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Property name. | `string` | n/a | yes |
| <a name="input_notification_emails"></a> [notification\_emails](#input\_notification\_emails) | List or emails for notifications | `list(string)` | n/a | yes |
| <a name="input_activate_to_production"></a> [activate\_to\_production](#input\_activate\_to\_production) | Set to true to directly activate on the production network. | `bool` | `false` | no |
| <a name="input_activate_to_staging"></a> [activate\_to\_staging](#input\_activate\_to\_staging) | Set to true to directly activate on the staging network. | `bool` | `false` | no |
| <a name="input_activation_notes"></a> [activation\_notes](#input\_activation\_notes) | Activation notes. Leave default value until DXE-2373 is resolved, unless you know what you are doing. | `string` | `"activated with terraform"` | no |
| <a name="input_activation_to_production_exists"></a> [activation\_to\_production\_exists](#input\_activation\_to\_production\_exists) | Do not modify. Flag used together with the logic in the activation resources for the initial activation to production. | `bool` | `false` | no |
| <a name="input_activation_to_staging_exists"></a> [activation\_to\_staging\_exists](#input\_activation\_to\_staging\_exists) | Do not modify. Flag used together with the logic in the activation resources for the initial activation to staging. | `bool` | `false` | no |
| <a name="input_certificate_id"></a> [certificate\_id](#input\_certificate\_id) | Certificate enrollment id. Only applicable if enhanced\_tls is true, and secure\_by\_default<br/>is false.<br/><br/>Can be retrieved using AkamaiPowershell or the Akamai CPS CLI. | `number` | `null` | no |
| <a name="input_cpcode_name"></a> [cpcode\_name](#input\_cpcode\_name) | Default CP Code name. Will be the property name (var.name) if null. | `string` | `null` | no |
| <a name="input_customer_email"></a> [customer\_email](#input\_customer\_email) | Email address of the customer that acknowledged, tested and accepted the change | `string` | `null` | no |
| <a name="input_dummy_test"></a> [dummy\_test](#input\_dummy\_test) | n/a | `string` | `"dummy_test"` | no |
| <a name="input_ehn_domain"></a> [ehn\_domain](#input\_ehn\_domain) | EdgeHostname domain, e.g. edgesuite.net or edgekey.net. Will default to one or<br/>the other, based on the value of etls variable. | `string` | `null` | no |
| <a name="input_enable_mPulse"></a> [enable\_mPulse](#input\_enable\_mPulse) | Boolean tod ecide whether to inject the mpulse behavior | `bool` | `true` | no |
| <a name="input_ip_behavior"></a> [ip\_behavior](#input\_ip\_behavior) | EdgeHostname IP behaviour. | `string` | `"IPV6_COMPLIANCE"` | no |
| <a name="input_noncompliance_reason"></a> [noncompliance\_reason](#input\_noncompliance\_reason) | Allowed values for noncompliance\_reason are "NO\_PRODUCTION\_TRAFFIC", "EMERGENCY", "NONE". (OR null for the customer, as None will require the complaince block) | `list(string)` | `[]` | no |
| <a name="input_other_noncompliance_reason"></a> [other\_noncompliance\_reason](#input\_other\_noncompliance\_reason) | Describes the reason why the activation must occur immediately, out of compliance with the standard procedure | `string` | `null` | no |
| <a name="input_peer_reviewed_by"></a> [peer\_reviewed\_by](#input\_peer\_reviewed\_by) | Email address of the peer who performed the review | `string` | `null` | no |
| <a name="input_product_id"></a> [product\_id](#input\_product\_id) | Property Manager product. [ION - Fresca] | `string` | `"Site_Accel"` | no |
| <a name="input_secure_by_default"></a> [secure\_by\_default](#input\_secure\_by\_default) | Secure by default. Set to true to use the DEFAULT certificate provisioning type.<br/><br/>This is the easiest for automation, because Akamai takes care of provisioning the certificate<br/>using a Let's Encrypt DV SAN in a fully managed way.<br/><br/>If the customer requires an OV SAN, or Secure by Default is inapplicable for whatever<br/>other reason, set this to false. | `bool` | `true` | no |
| <a name="input_sure_route_test_object"></a> [sure\_route\_test\_object](#input\_sure\_route\_test\_object) | Test object path for SureRoute | `string` | `"/akamai/testobject.html"` | no |
| <a name="input_td_region"></a> [td\_region](#input\_td\_region) | Region (map) for Tiered Distribution behaviour. Only applies if network is Standard TLS.<br/>Options are: CH2, CHAPAC, CHEU2, CHEUS2, CHWUS2, CHCUS2, CHAUS | `string` | `"CH2"` | no |
| <a name="input_ticket_id"></a> [ticket\_id](#input\_ticket\_id) | Identifies the ticket that describes the need for the activation | `string` | `null` | no |
| <a name="input_unit_tested"></a> [unit\_tested](#input\_unit\_tested) | Whether the metadata to activate has been fully tested | `bool` | `null` | no |
| <a name="input_version_notes"></a> [version\_notes](#input\_version\_notes) | Property version notes. | `string` | `"Initial Config"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert_status"></a> [cert\_status](#output\_cert\_status) | The status of the certificate, which may include any challenge required to generate it (DNS CNAME or other type) |
| <a name="output_cpcode_id"></a> [cpcode\_id](#output\_cpcode\_id) | The CP Code's unique identifier. |
| <a name="output_property_id"></a> [property\_id](#output\_property\_id) | The property's unique identifier. |
| <a name="output_rules_errors"></a> [rules\_errors](#output\_rules\_errors) | The contents of errors field returned by the API. |
<!-- END_TF_DOCS -->