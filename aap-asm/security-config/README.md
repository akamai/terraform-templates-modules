<!-- BEGIN_TF_DOCS -->

# Security Configuration (Config-Level)

Creates and manages the Akamai Application Security configuration,
advanced settings, rate policies, and reputation profiles.
This module is called once per deployment. Individual security policies
are created by the companion `security-policy` module using `for_each`.

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 config_name  = <string>
  	 contract_id  = <string>
  	 description  = <string>
  	 group_name  = <string>
  	 hostnames  = <list(string)>
  	 version_notes  = <string>
  
	 # Optional variables
  	 client_lists_pragmabypass  = <list(string)> | default: []
  	 client_lists_rcbypass  = <list(string)> | default: []
  	 client_lists_reputationbypass  = <list(string)> | default: []
  	 client_lists_securitybypass  = <list(string)> | default: []
  	 enable_client_reputation  = <bool> | default: false
  	 inspection_size  = <number> | default: 32
}
 ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 9.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.13 |

## Resources

| Name | Type |
|------|------|
| [akamai_appsec_advanced_settings_attack_payload_logging.attack_payload_logging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_attack_payload_logging) | resource |
| [akamai_appsec_advanced_settings_evasive_path_match.evasive_path_match](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_evasive_path_match) | resource |
| [akamai_appsec_advanced_settings_logging.logging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_logging) | resource |
| [akamai_appsec_advanced_settings_pii_learning.pii_learning](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_pii_learning) | resource |
| [akamai_appsec_advanced_settings_pragma_header.pragma_header](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_pragma_header) | resource |
| [akamai_appsec_advanced_settings_prefetch.prefetch](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_prefetch) | resource |
| [akamai_appsec_advanced_settings_request_body.config_settings](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_request_body) | resource |
| [akamai_appsec_configuration.config](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_configuration) | resource |
| [akamai_appsec_rate_policy.origin_error](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy) | resource |
| [akamai_appsec_rate_policy.page_view_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy) | resource |
| [akamai_appsec_rate_policy.post_page_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy) | resource |
| [akamai_appsec_reputation_profile.dos_attackers_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.dos_attackers_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.dos_attackers_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.dos_attackers_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.scanning_tools_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.scanning_tools_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.scanning_tools_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.scanning_tools_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_attackers_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_attackers_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_attackers_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_attackers_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_scrapers_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_scrapers_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_scrapers_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_reputation_profile.web_scrapers_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile) | resource |
| [akamai_appsec_version_notes.version_notes](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_version_notes) | resource |
| [random_string.secret_header](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait1](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait2](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_cr](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [akamai_clientlist_lists.all](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/clientlist_lists) | data source |
| [akamai_group.group](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/group) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | Security configuration name | `string` | n/a | yes |
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Akamai Contract ID | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Security configuration description | `string` | n/a | yes |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Akamai Group Name | `string` | n/a | yes |
| <a name="input_hostnames"></a> [hostnames](#input\_hostnames) | All hostnames to protect by the security config | `list(string)` | n/a | yes |
| <a name="input_version_notes"></a> [version\_notes](#input\_version\_notes) | Notes for the configuration version | `string` | n/a | yes |
| <a name="input_client_lists_pragmabypass"></a> [client\_lists\_pragmabypass](#input\_client\_lists\_pragmabypass) | ID(s) for the Pragma Bypass Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_rcbypass"></a> [client\_lists\_rcbypass](#input\_client\_lists\_rcbypass) | ID(s) for the Rate Control Bypass Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_reputationbypass"></a> [client\_lists\_reputationbypass](#input\_client\_lists\_reputationbypass) | ID(s) for the Reputation Bypass Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_securitybypass"></a> [client\_lists\_securitybypass](#input\_client\_lists\_securitybypass) | ID(s) for the Security Bypass Client List | `list(string)` | `[]` | no |
| <a name="input_enable_client_reputation"></a> [enable\_client\_reputation](#input\_enable\_client\_reputation) | Enable Client Reputation profiles at config level | `bool` | `false` | no |
| <a name="input_inspection_size"></a> [inspection\_size](#input\_inspection\_size) | Request body inspection limit | `number` | `32` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bypass_network_lists"></a> [bypass\_network\_lists](#output\_bypass\_network\_lists) | Bypass network lists with ID and name |
| <a name="output_config_id"></a> [config\_id](#output\_config\_id) | Security Configuration ID |
| <a name="output_rate_policy_origin_error_id"></a> [rate\_policy\_origin\_error\_id](#output\_rate\_policy\_origin\_error\_id) | Rate Policy ID for Origin Error |
| <a name="output_rate_policy_page_view_requests_id"></a> [rate\_policy\_page\_view\_requests\_id](#output\_rate\_policy\_page\_view\_requests\_id) | Rate Policy ID for Page View Requests |
| <a name="output_rate_policy_post_page_requests_id"></a> [rate\_policy\_post\_page\_requests\_id](#output\_rate\_policy\_post\_page\_requests\_id) | Rate Policy ID for POST Page Requests |
| <a name="output_reputation_profile_ids"></a> [reputation\_profile\_ids](#output\_reputation\_profile\_ids) | Map of reputation profile IDs |
<!-- END_TF_DOCS -->