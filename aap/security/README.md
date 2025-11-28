<!-- BEGIN_TF_DOCS -->

# Onboarding: Application Security Configuration

The use case for this module is to quickly create a new Application Security configuration
serving a set of hostnames following Akamai Professional Services Best Practices.

Read on to find out which resources are provisioned as part of this
process, and how to customize!

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 config_name  = <string>
  	 contract_id  = <string>
  	 description  = <string>
  	 dos_origin_error_action  = <string>
  	 dos_page_view_requests_action  = <string>
  	 dos_post_page_requests_action  = <string>
  	 enable_ip_geo  = <bool>
  	 enable_malware  = <bool>
  	 enable_rate  = <bool>
  	 enable_slow_post  = <bool>
  	 enable_waf  = <bool>
  	 group_name  = <string>
  	 hostnames  = <list(string)>
  	 slow_post_action  = <string>
  	 version_notes  = <string>
  
	 # Optional variables
  	 client_lists_exception_ipblock  = <list(string)> | default: []
  	 client_lists_geoblock  = <list(string)> | default: []
  	 client_lists_ipblock  = <list(string)> | default: []
  	 client_lists_pragmabypass  = <list(string)> | default: []
  	 client_lists_rcbypass  = <list(string)> | default: []
  	 client_lists_securitybypass  = <list(string)> | default: []
  	 inspection_size  = <number> | default: 32
  	 penalty_box_action  = <string> | default: "alert"
  	 waf_cmd_action  = <string> | default: "alert"
  	 waf_lfi_action  = <string> | default: "alert"
  	 waf_platform_action  = <string> | default: "alert"
  	 waf_policy_action  = <string> | default: "alert"
  	 waf_protocol_action  = <string> | default: "alert"
  	 waf_rfi_action  = <string> | default: "alert"
  	 waf_sql_action  = <string> | default: "alert"
  	 waf_wat_action  = <string> | default: "alert"
  	 waf_xss_action  = <string> | default: "alert"
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
| [akamai_appsec_advanced_settings_logging.logging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_logging) | resource |
| [akamai_appsec_advanced_settings_pragma_header.pragma_header](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_pragma_header) | resource |
| [akamai_appsec_advanced_settings_request_body.config_settings](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_advanced_settings_request_body) | resource |
| [akamai_appsec_attack_group.tfdemo_CMD](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_LFI](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_PLATFORM](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_POLICY](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_PROTOCOL](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_RFI](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_SQL](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_WAT](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.tfdemo_XSS](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_bypass_network_lists.bypass](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_bypass_network_lists) | resource |
| [akamai_appsec_configuration.config](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_configuration) | resource |
| [akamai_appsec_ip_geo.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_ip_geo) | resource |
| [akamai_appsec_ip_geo_protection.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_ip_geo_protection) | resource |
| [akamai_appsec_malware_protection.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_malware_protection) | resource |
| [akamai_appsec_penalty_box.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_penalty_box) | resource |
| [akamai_appsec_rate_policy.origin_error](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy) | resource |
| [akamai_appsec_rate_policy.page_view_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy) | resource |
| [akamai_appsec_rate_policy.post_page_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy) | resource |
| [akamai_appsec_rate_policy_action.tfdemo_origin_error](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy_action) | resource |
| [akamai_appsec_rate_policy_action.tfdemo_page_view_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy_action) | resource |
| [akamai_appsec_rate_policy_action.tfdemo_post_page_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy_action) | resource |
| [akamai_appsec_rate_protection.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_protection) | resource |
| [akamai_appsec_slow_post.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_slow_post) | resource |
| [akamai_appsec_slowpost_protection.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_slowpost_protection) | resource |
| [akamai_appsec_version_notes.version_notes](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_version_notes) | resource |
| [akamai_appsec_waf_mode.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_waf_mode) | resource |
| [akamai_appsec_waf_protection.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_waf_protection) | resource |
| [random_string.secret_header](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait1](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait2](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [akamai_appsec_rate_policies.rate](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/appsec_rate_policies) | data source |
| [akamai_appsec_security_policy.policy](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/appsec_security_policy) | data source |
| [akamai_group.group](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/group) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | Security configuration name | `string` | n/a | yes |
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Akamai Contract ID | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Security configuration description | `string` | n/a | yes |
| <a name="input_dos_origin_error_action"></a> [dos\_origin\_error\_action](#input\_dos\_origin\_error\_action) | Action for the Origin Error | `string` | n/a | yes |
| <a name="input_dos_page_view_requests_action"></a> [dos\_page\_view\_requests\_action](#input\_dos\_page\_view\_requests\_action) | Action for the Page View Requests | `string` | n/a | yes |
| <a name="input_dos_post_page_requests_action"></a> [dos\_post\_page\_requests\_action](#input\_dos\_post\_page\_requests\_action) | Action for the POST Page Requests | `string` | n/a | yes |
| <a name="input_enable_ip_geo"></a> [enable\_ip\_geo](#input\_enable\_ip\_geo) | Enable IP/Geo Firewall Protection | `bool` | n/a | yes |
| <a name="input_enable_malware"></a> [enable\_malware](#input\_enable\_malware) | Enable Malware Protection | `bool` | n/a | yes |
| <a name="input_enable_rate"></a> [enable\_rate](#input\_enable\_rate) | Enable Rate Protection | `bool` | n/a | yes |
| <a name="input_enable_slow_post"></a> [enable\_slow\_post](#input\_enable\_slow\_post) | Enable Slow POST Protection | `bool` | n/a | yes |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | Enable Web Application Firewall Protection | `bool` | n/a | yes |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Akamai Group Name | `string` | n/a | yes |
| <a name="input_hostnames"></a> [hostnames](#input\_hostnames) | Hostnames to protect by the security config | `list(string)` | n/a | yes |
| <a name="input_slow_post_action"></a> [slow\_post\_action](#input\_slow\_post\_action) | Action for the slow POST Protection | `string` | n/a | yes |
| <a name="input_version_notes"></a> [version\_notes](#input\_version\_notes) | Notes for the configuration version | `string` | n/a | yes |
| <a name="input_client_lists_exception_ipblock"></a> [client\_lists\_exception\_ipblock](#input\_client\_lists\_exception\_ipblock) | ID(s) for the IP Block Exceptions Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_geoblock"></a> [client\_lists\_geoblock](#input\_client\_lists\_geoblock) | ID(s) for the Geo Block Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_ipblock"></a> [client\_lists\_ipblock](#input\_client\_lists\_ipblock) | ID(s) for the IP Block Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_pragmabypass"></a> [client\_lists\_pragmabypass](#input\_client\_lists\_pragmabypass) | ID(s) for the Pragma Bypass Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_rcbypass"></a> [client\_lists\_rcbypass](#input\_client\_lists\_rcbypass) | ID(s) for the Rate Control Bypass Client List | `list(string)` | `[]` | no |
| <a name="input_client_lists_securitybypass"></a> [client\_lists\_securitybypass](#input\_client\_lists\_securitybypass) | ID(s) for the Security Bypass Client List | `list(string)` | `[]` | no |
| <a name="input_inspection_size"></a> [inspection\_size](#input\_inspection\_size) | Request body inspection limit | `number` | `32` | no |
| <a name="input_penalty_box_action"></a> [penalty\_box\_action](#input\_penalty\_box\_action) | Action for WAF Penalty Box | `string` | `"alert"` | no |
| <a name="input_waf_cmd_action"></a> [waf\_cmd\_action](#input\_waf\_cmd\_action) | Action for WAF attack group: Command Injection | `string` | `"alert"` | no |
| <a name="input_waf_lfi_action"></a> [waf\_lfi\_action](#input\_waf\_lfi\_action) | Action for WAF attack group: Local File Inclusion | `string` | `"alert"` | no |
| <a name="input_waf_platform_action"></a> [waf\_platform\_action](#input\_waf\_platform\_action) | Action for WAF attack group: Web Platform Attack | `string` | `"alert"` | no |
| <a name="input_waf_policy_action"></a> [waf\_policy\_action](#input\_waf\_policy\_action) | Action for WAF attack group: Web Policy Violation | `string` | `"alert"` | no |
| <a name="input_waf_protocol_action"></a> [waf\_protocol\_action](#input\_waf\_protocol\_action) | Action for WAF attack group: Web Protocol Attack | `string` | `"alert"` | no |
| <a name="input_waf_rfi_action"></a> [waf\_rfi\_action](#input\_waf\_rfi\_action) | Action for WAF attack group: Remote File Inclusion | `string` | `"alert"` | no |
| <a name="input_waf_sql_action"></a> [waf\_sql\_action](#input\_waf\_sql\_action) | Action for WAF attack group: SQL Injection | `string` | `"alert"` | no |
| <a name="input_waf_wat_action"></a> [waf\_wat\_action](#input\_waf\_wat\_action) | Action for WAF attack group: Web Attack Tool | `string` | `"alert"` | no |
| <a name="input_waf_xss_action"></a> [waf\_xss\_action](#input\_waf\_xss\_action) | Action for WAF attack group: Cross Site Scripting | `string` | `"alert"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_id"></a> [config\_id](#output\_config\_id) | Security Configuration ID |
| <a name="output_rate"></a> [rate](#output\_rate) | Rate Policy IDs |
| <a name="output_security_policy_id"></a> [security\_policy\_id](#output\_security\_policy\_id) | Security Policy ID |
<!-- END_TF_DOCS -->