<!-- BEGIN_TF_DOCS -->

# Onboarding: Application Security Configuration for Client Reputation

The use case for this module is to quickly create a new Application Security Configuration for Client Reputation
serving a set of hostnames following Akamai Professional Services Best Practices.

Read on to find out which resources are provisioned as part of this
process, and how to customize!

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 client_lists_reputationbypass  = <list(string)>
  	 config_id  = <string>
  	 security_policy_id  = <string>
  
	 # Optional variables
  	 rep_dos_attackers_high  = <string> | default: "alert"
  	 rep_dos_attackers_high_shared  = <string> | default: "alert"
  	 rep_dos_attackers_low  = <string> | default: "alert"
  	 rep_dos_attackers_low_shared  = <string> | default: "alert"
  	 rep_scanning_tools_high  = <string> | default: "alert"
  	 rep_scanning_tools_high_shared  = <string> | default: "alert"
  	 rep_scanning_tools_low  = <string> | default: "alert"
  	 rep_scanning_tools_low_shared  = <string> | default: "alert"
  	 rep_web_attackers_high  = <string> | default: "alert"
  	 rep_web_attackers_high_shared  = <string> | default: "alert"
  	 rep_web_attackers_low  = <string> | default: "alert"
  	 rep_web_attackers_low_shared  = <string> | default: "alert"
  	 rep_web_scrapers_high  = <string> | default: "alert"
  	 rep_web_scrapers_high_shared  = <string> | default: "alert"
  	 rep_web_scrapers_low  = <string> | default: "alert"
  	 rep_web_scrapers_low_shared  = <string> | default: "alert"
}
 ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 9.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.13 |

## Resources

| Name | Type |
|------|------|
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
| [akamai_appsec_reputation_profile_action.dos_attackers_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.dos_attackers_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.dos_attackers_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.dos_attackers_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.scanning_tools_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.scanning_tools_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.scanning_tools_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.scanning_tools_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_attackers_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_attackers_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_attackers_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_attackers_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_scrapers_high_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_scrapers_high_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_scrapers_low_threat](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_profile_action.web_scrapers_low_threat_shared](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_profile_action) | resource |
| [akamai_appsec_reputation_protection.tfdemo](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_protection) | resource |
| [time_sleep.wait_cr](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_lists_reputationbypass"></a> [client\_lists\_reputationbypass](#input\_client\_lists\_reputationbypass) | ID(s) for the Reputation Bypass Client List | `list(string)` | n/a | yes |
| <a name="input_config_id"></a> [config\_id](#input\_config\_id) | Akamai security configuration ID | `string` | n/a | yes |
| <a name="input_security_policy_id"></a> [security\_policy\_id](#input\_security\_policy\_id) | Security policy ID | `string` | n/a | yes |
| <a name="input_rep_dos_attackers_high"></a> [rep\_dos\_attackers\_high](#input\_rep\_dos\_attackers\_high) | Action for Reputation Profile: DoS Attackers (High Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_dos_attackers_high_shared"></a> [rep\_dos\_attackers\_high\_shared](#input\_rep\_dos\_attackers\_high\_shared) | Action for Reputation Profile: DoS Attackers (High Threat) SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_dos_attackers_low"></a> [rep\_dos\_attackers\_low](#input\_rep\_dos\_attackers\_low) | Action for Reputation Profile: DoS Attackers (Low Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_dos_attackers_low_shared"></a> [rep\_dos\_attackers\_low\_shared](#input\_rep\_dos\_attackers\_low\_shared) | Action for Reputation Profile: DoS Attackers (Low Threat) SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_scanning_tools_high"></a> [rep\_scanning\_tools\_high](#input\_rep\_scanning\_tools\_high) | Action for Reputation Profile: Scanning Tools (High Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_scanning_tools_high_shared"></a> [rep\_scanning\_tools\_high\_shared](#input\_rep\_scanning\_tools\_high\_shared) | Action for Reputation Profile: Scanning Tools (High Threat) SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_scanning_tools_low"></a> [rep\_scanning\_tools\_low](#input\_rep\_scanning\_tools\_low) | Action for Reputation Profile: Scanning Tools (Low Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_scanning_tools_low_shared"></a> [rep\_scanning\_tools\_low\_shared](#input\_rep\_scanning\_tools\_low\_shared) | Action for Reputation Profile: Scanning Tools (Low Threat) SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_attackers_high"></a> [rep\_web\_attackers\_high](#input\_rep\_web\_attackers\_high) | Action for Reputation Profile:  Web Attackers (High Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_attackers_high_shared"></a> [rep\_web\_attackers\_high\_shared](#input\_rep\_web\_attackers\_high\_shared) | Action for Reputation Profile:  Web Attackers (High Threat) SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_attackers_low"></a> [rep\_web\_attackers\_low](#input\_rep\_web\_attackers\_low) | Action for Reputation Profile: Web Attackers (Low Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_attackers_low_shared"></a> [rep\_web\_attackers\_low\_shared](#input\_rep\_web\_attackers\_low\_shared) | Action for Reputation Profile: Web Attackers (Low Threat) SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_scrapers_high"></a> [rep\_web\_scrapers\_high](#input\_rep\_web\_scrapers\_high) | Action for Reputation Profile: Web Scrapers (High Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_scrapers_high_shared"></a> [rep\_web\_scrapers\_high\_shared](#input\_rep\_web\_scrapers\_high\_shared) | Action for Reputation Profile: Web Scrapers (High Threat) SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_scrapers_low"></a> [rep\_web\_scrapers\_low](#input\_rep\_web\_scrapers\_low) | Action for Reputation Profile: Web Scrapers (Low Threat) NON-SHARED IPs | `string` | `"alert"` | no |
| <a name="input_rep_web_scrapers_low_shared"></a> [rep\_web\_scrapers\_low\_shared](#input\_rep\_web\_scrapers\_low\_shared) | Action for Reputation Profile: Web Scrapers (Low Threat) SHARED IPs | `string` | `"alert"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->