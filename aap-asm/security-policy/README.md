<!-- BEGIN_TF_DOCS -->

# Security Policy (Per-Policy)

Creates a single security policy within an existing Akamai Application Security
configuration, including all protection settings, WAF rules, DoS protections,
client reputation actions, and bot manager actions.

This module is designed to be called with `for_each` to create multiple
policies per security configuration.

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 config_id  = <number>
  	 hostnames  = <list(string)>
  	 match_target_sequence  = <number>
  	 policy_name  = <string>
  	 policy_prefix  = <string>
  	 rate_policy_origin_error_id  = <number>
  	 rate_policy_page_view_requests_id  = <number>
  	 rate_policy_post_page_requests_id  = <number>
  
	 # Optional variables
  	 add_akamai_bot_header  = <bool> | default: false
  	 bot_academic_or_research  = <string> | default: "alert"
  	 bot_aggressive_web_crawlers  = <string> | default: "alert"
  	 bot_artificial_intelligence_ai  = <string> | default: "alert"
  	 bot_browser_impersonator  = <string> | default: "alert"
  	 bot_business_intelligence  = <string> | default: "alert"
  	 bot_client_disabled_javascript_noscript_triggered  = <string> | default: "alert"
  	 bot_cookie_integrity_failed  = <string> | default: "alert"
  	 bot_declared_bots_keyword_match  = <string> | default: "alert"
  	 bot_development_frameworks  = <string> | default: "alert"
  	 bot_ecommerce_search_engine  = <string> | default: "alert"
  	 bot_enterprise_data_aggregator  = <string> | default: "alert"
  	 bot_financial_account_aggregator  = <string> | default: "alert"
  	 bot_financial_services  = <string> | default: "alert"
  	 bot_headless_browsersautomation_tools  = <string> | default: "alert"
  	 bot_http_libraries  = <string> | default: "alert"
  	 bot_impersonators_of_known_bots  = <string> | default: "alert"
  	 bot_javascript_fingerprint_anomaly  = <string> | default: "alert"
  	 bot_javascript_fingerprint_not_received  = <string> | default: "alert"
  	 bot_job_search_engine  = <string> | default: "alert"
  	 bot_media_or_entertainment_search  = <string> | default: "alert"
  	 bot_news_aggregator  = <string> | default: "alert"
  	 bot_online_advertising  = <string> | default: "alert"
  	 bot_open_source_crawlersscraping_platforms  = <string> | default: "alert"
  	 bot_rss_feed_reader  = <string> | default: "alert"
  	 bot_seo_analytics_or_marketing  = <string> | default: "alert"
  	 bot_session_validation  = <string> | default: "alert"
  	 bot_site_monitoring_and_web_development  = <string> | default: "alert"
  	 bot_social_media_or_blog  = <string> | default: "alert"
  	 bot_web_archiver  = <string> | default: "alert"
  	 bot_web_scraper_reputation  = <string> | default: "alert"
  	 bot_web_search_engine  = <string> | default: "alert"
  	 bot_web_services_libraries  = <string> | default: "alert"
  	 botman_type  = <string> | default: "bvm"
  	 bypass_network_lists  = <list(object({
    id   = string
    name = string
  }))> | default: []
  	 client_lists_exception_ipblock  = <list(string)> | default: []
  	 client_lists_geoblock  = <list(string)> | default: []
  	 client_lists_ipblock  = <list(string)> | default: []
  	 dos_origin_error_action  = <string> | default: "alert"
  	 dos_page_view_requests_action  = <string> | default: "alert"
  	 dos_post_page_requests_action  = <string> | default: "alert"
  	 enable_active_detections  = <bool> | default: false
  	 enable_botman  = <bool> | default: false
  	 enable_browser_validation  = <bool> | default: false
  	 enable_client_reputation  = <bool> | default: false
  	 enable_ip_geo  = <bool> | default: true
  	 enable_malware  = <bool> | default: false
  	 enable_rate  = <bool> | default: true
  	 enable_request_constraints  = <bool> | default: false
  	 enable_slow_post  = <bool> | default: true
  	 enable_waf  = <bool> | default: true
  	 penalty_box_action  = <string> | default: "alert"
  	 remove_botman_cookies  = <bool> | default: true
  	 rep_dos_attackers_high  = <string> | default: "alert"
  	 rep_dos_attackers_high_shared  = <string> | default: "alert"
  	 rep_dos_attackers_low  = <string> | default: "none"
  	 rep_dos_attackers_low_shared  = <string> | default: "none"
  	 rep_scanning_tools_high  = <string> | default: "alert"
  	 rep_scanning_tools_high_shared  = <string> | default: "alert"
  	 rep_scanning_tools_low  = <string> | default: "none"
  	 rep_scanning_tools_low_shared  = <string> | default: "none"
  	 rep_web_attackers_high  = <string> | default: "alert"
  	 rep_web_attackers_high_shared  = <string> | default: "alert"
  	 rep_web_attackers_low  = <string> | default: "none"
  	 rep_web_attackers_low_shared  = <string> | default: "none"
  	 rep_web_scrapers_high  = <string> | default: "alert"
  	 rep_web_scrapers_high_shared  = <string> | default: "alert"
  	 rep_web_scrapers_low  = <string> | default: "none"
  	 rep_web_scrapers_low_shared  = <string> | default: "none"
  	 reputation_profile_ids  = <map(number)> | default: {}
  	 slow_post_action  = <string> | default: "alert"
  	 third_party_proxy  = <bool> | default: false
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
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.13 |

## Resources

| Name | Type |
|------|------|
| [akamai_appsec_api_constraints_protection.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_api_constraints_protection) | resource |
| [akamai_appsec_attack_group.CMD](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.LFI](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.PLATFORM](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.POLICY](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.PROTOCOL](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.RFI](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.SQL](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.WAT](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_attack_group.XSS](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_attack_group) | resource |
| [akamai_appsec_ip_geo.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_ip_geo) | resource |
| [akamai_appsec_ip_geo_protection.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_ip_geo_protection) | resource |
| [akamai_appsec_malware_protection.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_malware_protection) | resource |
| [akamai_appsec_match_target.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_match_target) | resource |
| [akamai_appsec_penalty_box.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_penalty_box) | resource |
| [akamai_appsec_rate_policy_action.origin_error](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy_action) | resource |
| [akamai_appsec_rate_policy_action.page_view_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy_action) | resource |
| [akamai_appsec_rate_policy_action.post_page_requests](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_policy_action) | resource |
| [akamai_appsec_rate_protection.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_rate_protection) | resource |
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
| [akamai_appsec_reputation_protection.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_reputation_protection) | resource |
| [akamai_appsec_security_policy.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_security_policy) | resource |
| [akamai_appsec_slow_post.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_slow_post) | resource |
| [akamai_appsec_slowpost_protection.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_slowpost_protection) | resource |
| [akamai_appsec_waf_mode.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_waf_mode) | resource |
| [akamai_appsec_waf_protection.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/appsec_waf_protection) | resource |
| [akamai_botman_akamai_bot_category_action.academic_or_research](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.artificial_intelligence_ai](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.business_intelligence](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.ecommerce_search_engine](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.enterprise_data_aggregator](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.financial_account_aggregator](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.financial_services](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.job_search_engine](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.media_or_entertainment_search](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.news_aggregator](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.online_advertising](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.rss_feed_reader](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.seo_analytics_or_marketing](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.site_monitoring_and_web_development](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.social_media_or_blog](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.web_archiver](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.web_search_engine](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_bot_detection_action.aggressive_web_crawlers](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.browser_impersonator](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.client_disabled_javascript_noscript_triggered](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.cookie_integrity_failed](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.declared_bots_keyword_match](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.development_frameworks](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.headless_browsersautomation_tools](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.http_libraries](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.impersonators_of_known_bots](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.javascript_fingerprint_anomaly](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.javascript_fingerprint_not_received](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.open_source_crawlersscraping_platforms](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.session_validation](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.web_scraper_reputation](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.web_services_libraries](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_management_settings.bot_manager_bms](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_management_settings) | resource |
| [akamai_botman_bot_management_settings.bot_manager_bvm](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_management_settings) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_id"></a> [config\_id](#input\_config\_id) | Akamai security configuration ID | `number` | n/a | yes |
| <a name="input_hostnames"></a> [hostnames](#input\_hostnames) | List of hostnames this policy protects | `list(string)` | n/a | yes |
| <a name="input_match_target_sequence"></a> [match\_target\_sequence](#input\_match\_target\_sequence) | Sequence number for the match target (must be unique per policy) | `number` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name for the security policy | `string` | n/a | yes |
| <a name="input_policy_prefix"></a> [policy\_prefix](#input\_policy\_prefix) | Four-character alphanumeric prefix for the security policy | `string` | n/a | yes |
| <a name="input_rate_policy_origin_error_id"></a> [rate\_policy\_origin\_error\_id](#input\_rate\_policy\_origin\_error\_id) | Rate policy ID for origin error | `number` | n/a | yes |
| <a name="input_rate_policy_page_view_requests_id"></a> [rate\_policy\_page\_view\_requests\_id](#input\_rate\_policy\_page\_view\_requests\_id) | Rate policy ID for page view requests | `number` | n/a | yes |
| <a name="input_rate_policy_post_page_requests_id"></a> [rate\_policy\_post\_page\_requests\_id](#input\_rate\_policy\_post\_page\_requests\_id) | Rate policy ID for POST page requests | `number` | n/a | yes |
| <a name="input_add_akamai_bot_header"></a> [add\_akamai\_bot\_header](#input\_add\_akamai\_bot\_header) | Adds a header named Akamai-Bot to bot requests forwarded to the origin (BMS only) | `bool` | `false` | no |
| <a name="input_bot_academic_or_research"></a> [bot\_academic\_or\_research](#input\_bot\_academic\_or\_research) | Action for Akamai bot category: Academic or Research Bots | `string` | `"alert"` | no |
| <a name="input_bot_aggressive_web_crawlers"></a> [bot\_aggressive\_web\_crawlers](#input\_bot\_aggressive\_web\_crawlers) | Action for bot transparent detection: Aggressive Web Crawlers | `string` | `"alert"` | no |
| <a name="input_bot_artificial_intelligence_ai"></a> [bot\_artificial\_intelligence\_ai](#input\_bot\_artificial\_intelligence\_ai) | Action for Akamai bot category: Artificial Intelligence (AI) Bots | `string` | `"alert"` | no |
| <a name="input_bot_browser_impersonator"></a> [bot\_browser\_impersonator](#input\_bot\_browser\_impersonator) | Action for bot transparent detection: Browser Impersonator | `string` | `"alert"` | no |
| <a name="input_bot_business_intelligence"></a> [bot\_business\_intelligence](#input\_bot\_business\_intelligence) | Action for Akamai bot category: Business Intelligence Bots | `string` | `"alert"` | no |
| <a name="input_bot_client_disabled_javascript_noscript_triggered"></a> [bot\_client\_disabled\_javascript\_noscript\_triggered](#input\_bot\_client\_disabled\_javascript\_noscript\_triggered) | Bot active detection action: Client Disabled JavaScript (Noscript Triggered) | `string` | `"alert"` | no |
| <a name="input_bot_cookie_integrity_failed"></a> [bot\_cookie\_integrity\_failed](#input\_bot\_cookie\_integrity\_failed) | Bot active detection action: Cookie Integrity Failed | `string` | `"alert"` | no |
| <a name="input_bot_declared_bots_keyword_match"></a> [bot\_declared\_bots\_keyword\_match](#input\_bot\_declared\_bots\_keyword\_match) | Action for bot transparent detection: Declared Bots (Keyword Match) | `string` | `"alert"` | no |
| <a name="input_bot_development_frameworks"></a> [bot\_development\_frameworks](#input\_bot\_development\_frameworks) | Action for bot transparent detection: Development Frameworks | `string` | `"alert"` | no |
| <a name="input_bot_ecommerce_search_engine"></a> [bot\_ecommerce\_search\_engine](#input\_bot\_ecommerce\_search\_engine) | Action for Akamai bot category: E-Commerce Search Engine Bots | `string` | `"alert"` | no |
| <a name="input_bot_enterprise_data_aggregator"></a> [bot\_enterprise\_data\_aggregator](#input\_bot\_enterprise\_data\_aggregator) | Action for Akamai bot category: Enterprise Data Aggregator Bots | `string` | `"alert"` | no |
| <a name="input_bot_financial_account_aggregator"></a> [bot\_financial\_account\_aggregator](#input\_bot\_financial\_account\_aggregator) | Action for Akamai bot category: Financial Account Aggregator Bots | `string` | `"alert"` | no |
| <a name="input_bot_financial_services"></a> [bot\_financial\_services](#input\_bot\_financial\_services) | Action for Akamai bot category: Financial Services Bots | `string` | `"alert"` | no |
| <a name="input_bot_headless_browsersautomation_tools"></a> [bot\_headless\_browsersautomation\_tools](#input\_bot\_headless\_browsersautomation\_tools) | Action for bot transparent detection: Headless Browsers/Automation Tools | `string` | `"alert"` | no |
| <a name="input_bot_http_libraries"></a> [bot\_http\_libraries](#input\_bot\_http\_libraries) | Action for bot transparent detection: HTTP Libraries | `string` | `"alert"` | no |
| <a name="input_bot_impersonators_of_known_bots"></a> [bot\_impersonators\_of\_known\_bots](#input\_bot\_impersonators\_of\_known\_bots) | Action for bot transparent detection: Impersonators of Known Bots | `string` | `"alert"` | no |
| <a name="input_bot_javascript_fingerprint_anomaly"></a> [bot\_javascript\_fingerprint\_anomaly](#input\_bot\_javascript\_fingerprint\_anomaly) | Bot active detection action: JavaScript Fingerprint Anomaly | `string` | `"alert"` | no |
| <a name="input_bot_javascript_fingerprint_not_received"></a> [bot\_javascript\_fingerprint\_not\_received](#input\_bot\_javascript\_fingerprint\_not\_received) | Bot active detection action: JavaScript Fingerprint Not Received | `string` | `"alert"` | no |
| <a name="input_bot_job_search_engine"></a> [bot\_job\_search\_engine](#input\_bot\_job\_search\_engine) | Action for Akamai bot category: Job Search Engine Bots | `string` | `"alert"` | no |
| <a name="input_bot_media_or_entertainment_search"></a> [bot\_media\_or\_entertainment\_search](#input\_bot\_media\_or\_entertainment\_search) | Action for Akamai bot category: Media or Entertainment Search Bots | `string` | `"alert"` | no |
| <a name="input_bot_news_aggregator"></a> [bot\_news\_aggregator](#input\_bot\_news\_aggregator) | Action for Akamai bot category: News Aggregator Bots | `string` | `"alert"` | no |
| <a name="input_bot_online_advertising"></a> [bot\_online\_advertising](#input\_bot\_online\_advertising) | Action for Akamai bot category: Online Advertising Bots | `string` | `"alert"` | no |
| <a name="input_bot_open_source_crawlersscraping_platforms"></a> [bot\_open\_source\_crawlersscraping\_platforms](#input\_bot\_open\_source\_crawlersscraping\_platforms) | Action for bot transparent detection: Open Source Crawlers/Scraping Platforms | `string` | `"alert"` | no |
| <a name="input_bot_rss_feed_reader"></a> [bot\_rss\_feed\_reader](#input\_bot\_rss\_feed\_reader) | Action for Akamai bot category: RSS Feed Reader Bots | `string` | `"alert"` | no |
| <a name="input_bot_seo_analytics_or_marketing"></a> [bot\_seo\_analytics\_or\_marketing](#input\_bot\_seo\_analytics\_or\_marketing) | Action for Akamai bot category: SEO, Analytics or Marketing Bots | `string` | `"alert"` | no |
| <a name="input_bot_session_validation"></a> [bot\_session\_validation](#input\_bot\_session\_validation) | Bot active detection action: Session Validation | `string` | `"alert"` | no |
| <a name="input_bot_site_monitoring_and_web_development"></a> [bot\_site\_monitoring\_and\_web\_development](#input\_bot\_site\_monitoring\_and\_web\_development) | Action for Akamai bot category: Site Monitoring and Web Development Bots | `string` | `"alert"` | no |
| <a name="input_bot_social_media_or_blog"></a> [bot\_social\_media\_or\_blog](#input\_bot\_social\_media\_or\_blog) | Action for Akamai bot category: Social Media or Blog Bots | `string` | `"alert"` | no |
| <a name="input_bot_web_archiver"></a> [bot\_web\_archiver](#input\_bot\_web\_archiver) | Action for Akamai bot category: Web Archiver Bots | `string` | `"alert"` | no |
| <a name="input_bot_web_scraper_reputation"></a> [bot\_web\_scraper\_reputation](#input\_bot\_web\_scraper\_reputation) | Action for bot transparent detection: Web Scraper Reputation | `string` | `"alert"` | no |
| <a name="input_bot_web_search_engine"></a> [bot\_web\_search\_engine](#input\_bot\_web\_search\_engine) | Action for Akamai bot category: Web Search Engine Bots | `string` | `"alert"` | no |
| <a name="input_bot_web_services_libraries"></a> [bot\_web\_services\_libraries](#input\_bot\_web\_services\_libraries) | Action for bot transparent detection: Web Services Libraries | `string` | `"alert"` | no |
| <a name="input_botman_type"></a> [botman\_type](#input\_botman\_type) | Bot manager entitlement type: bvm (Bot Visibility and Management) or bms (Bot Management Standard) | `string` | `"bvm"` | no |
| <a name="input_bypass_network_lists"></a> [bypass\_network\_lists](#input\_bypass\_network\_lists) | List of bypass network list objects for the match target | <pre>list(object({<br/>    id   = string<br/>    name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_client_lists_exception_ipblock"></a> [client\_lists\_exception\_ipblock](#input\_client\_lists\_exception\_ipblock) | List of IP network list IDs to exempt from blocking | `list(string)` | `[]` | no |
| <a name="input_client_lists_geoblock"></a> [client\_lists\_geoblock](#input\_client\_lists\_geoblock) | List of geo network list IDs to block | `list(string)` | `[]` | no |
| <a name="input_client_lists_ipblock"></a> [client\_lists\_ipblock](#input\_client\_lists\_ipblock) | List of IP network list IDs to block | `list(string)` | `[]` | no |
| <a name="input_dos_origin_error_action"></a> [dos\_origin\_error\_action](#input\_dos\_origin\_error\_action) | DoS action for origin error rate policy | `string` | `"alert"` | no |
| <a name="input_dos_page_view_requests_action"></a> [dos\_page\_view\_requests\_action](#input\_dos\_page\_view\_requests\_action) | DoS action for page view requests rate policy | `string` | `"alert"` | no |
| <a name="input_dos_post_page_requests_action"></a> [dos\_post\_page\_requests\_action](#input\_dos\_post\_page\_requests\_action) | DoS action for POST page requests rate policy | `string` | `"alert"` | no |
| <a name="input_enable_active_detections"></a> [enable\_active\_detections](#input\_enable\_active\_detections) | Enable active detection methods that interact with the requesting client (BMS only) | `bool` | `false` | no |
| <a name="input_enable_botman"></a> [enable\_botman](#input\_enable\_botman) | Enable bot manager protection | `bool` | `false` | no |
| <a name="input_enable_browser_validation"></a> [enable\_browser\_validation](#input\_enable\_browser\_validation) | Confirm that requests come from a browser (BMS only) | `bool` | `false` | no |
| <a name="input_enable_client_reputation"></a> [enable\_client\_reputation](#input\_enable\_client\_reputation) | Enable client reputation protection | `bool` | `false` | no |
| <a name="input_enable_ip_geo"></a> [enable\_ip\_geo](#input\_enable\_ip\_geo) | Enable IP/Geo firewall protection | `bool` | `true` | no |
| <a name="input_enable_malware"></a> [enable\_malware](#input\_enable\_malware) | Enable malware protection | `bool` | `false` | no |
| <a name="input_enable_rate"></a> [enable\_rate](#input\_enable\_rate) | Enable rate control protection | `bool` | `true` | no |
| <a name="input_enable_request_constraints"></a> [enable\_request\_constraints](#input\_enable\_request\_constraints) | Enable API request constraints protection | `bool` | `false` | no |
| <a name="input_enable_slow_post"></a> [enable\_slow\_post](#input\_enable\_slow\_post) | Enable slow POST protection | `bool` | `true` | no |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | Enable WAF protection | `bool` | `true` | no |
| <a name="input_penalty_box_action"></a> [penalty\_box\_action](#input\_penalty\_box\_action) | Penalty box action (deny or alert) | `string` | `"alert"` | no |
| <a name="input_remove_botman_cookies"></a> [remove\_botman\_cookies](#input\_remove\_botman\_cookies) | Remove Bot Manager cookies before sending request to origin | `bool` | `true` | no |
| <a name="input_rep_dos_attackers_high"></a> [rep\_dos\_attackers\_high](#input\_rep\_dos\_attackers\_high) | Action for DoS attackers high threat reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_dos_attackers_high_shared"></a> [rep\_dos\_attackers\_high\_shared](#input\_rep\_dos\_attackers\_high\_shared) | Action for DoS attackers high threat shared reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_dos_attackers_low"></a> [rep\_dos\_attackers\_low](#input\_rep\_dos\_attackers\_low) | Action for DoS attackers low threat reputation profile | `string` | `"none"` | no |
| <a name="input_rep_dos_attackers_low_shared"></a> [rep\_dos\_attackers\_low\_shared](#input\_rep\_dos\_attackers\_low\_shared) | Action for DoS attackers low threat shared reputation profile | `string` | `"none"` | no |
| <a name="input_rep_scanning_tools_high"></a> [rep\_scanning\_tools\_high](#input\_rep\_scanning\_tools\_high) | Action for scanning tools high threat reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_scanning_tools_high_shared"></a> [rep\_scanning\_tools\_high\_shared](#input\_rep\_scanning\_tools\_high\_shared) | Action for scanning tools high threat shared reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_scanning_tools_low"></a> [rep\_scanning\_tools\_low](#input\_rep\_scanning\_tools\_low) | Action for scanning tools low threat reputation profile | `string` | `"none"` | no |
| <a name="input_rep_scanning_tools_low_shared"></a> [rep\_scanning\_tools\_low\_shared](#input\_rep\_scanning\_tools\_low\_shared) | Action for scanning tools low threat shared reputation profile | `string` | `"none"` | no |
| <a name="input_rep_web_attackers_high"></a> [rep\_web\_attackers\_high](#input\_rep\_web\_attackers\_high) | Action for web attackers high threat reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_web_attackers_high_shared"></a> [rep\_web\_attackers\_high\_shared](#input\_rep\_web\_attackers\_high\_shared) | Action for web attackers high threat shared reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_web_attackers_low"></a> [rep\_web\_attackers\_low](#input\_rep\_web\_attackers\_low) | Action for web attackers low threat reputation profile | `string` | `"none"` | no |
| <a name="input_rep_web_attackers_low_shared"></a> [rep\_web\_attackers\_low\_shared](#input\_rep\_web\_attackers\_low\_shared) | Action for web attackers low threat shared reputation profile | `string` | `"none"` | no |
| <a name="input_rep_web_scrapers_high"></a> [rep\_web\_scrapers\_high](#input\_rep\_web\_scrapers\_high) | Action for web scrapers high threat reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_web_scrapers_high_shared"></a> [rep\_web\_scrapers\_high\_shared](#input\_rep\_web\_scrapers\_high\_shared) | Action for web scrapers high threat shared reputation profile | `string` | `"alert"` | no |
| <a name="input_rep_web_scrapers_low"></a> [rep\_web\_scrapers\_low](#input\_rep\_web\_scrapers\_low) | Action for web scrapers low threat reputation profile | `string` | `"none"` | no |
| <a name="input_rep_web_scrapers_low_shared"></a> [rep\_web\_scrapers\_low\_shared](#input\_rep\_web\_scrapers\_low\_shared) | Action for web scrapers low threat shared reputation profile | `string` | `"none"` | no |
| <a name="input_reputation_profile_ids"></a> [reputation\_profile\_ids](#input\_reputation\_profile\_ids) | Map of reputation profile IDs from the security-config module | `map(number)` | `{}` | no |
| <a name="input_slow_post_action"></a> [slow\_post\_action](#input\_slow\_post\_action) | Slow POST protection action | `string` | `"alert"` | no |
| <a name="input_third_party_proxy"></a> [third\_party\_proxy](#input\_third\_party\_proxy) | Enable if using a third-party proxy service between Akamai Edge servers | `bool` | `false` | no |
| <a name="input_waf_cmd_action"></a> [waf\_cmd\_action](#input\_waf\_cmd\_action) | WAF action for CMD injection attack group | `string` | `"alert"` | no |
| <a name="input_waf_lfi_action"></a> [waf\_lfi\_action](#input\_waf\_lfi\_action) | WAF action for LFI (Local File Inclusion) attack group | `string` | `"alert"` | no |
| <a name="input_waf_platform_action"></a> [waf\_platform\_action](#input\_waf\_platform\_action) | WAF action for PLATFORM attack group | `string` | `"alert"` | no |
| <a name="input_waf_policy_action"></a> [waf\_policy\_action](#input\_waf\_policy\_action) | WAF action for POLICY attack group | `string` | `"alert"` | no |
| <a name="input_waf_protocol_action"></a> [waf\_protocol\_action](#input\_waf\_protocol\_action) | WAF action for PROTOCOL attack group | `string` | `"alert"` | no |
| <a name="input_waf_rfi_action"></a> [waf\_rfi\_action](#input\_waf\_rfi\_action) | WAF action for RFI (Remote File Inclusion) attack group | `string` | `"alert"` | no |
| <a name="input_waf_sql_action"></a> [waf\_sql\_action](#input\_waf\_sql\_action) | WAF action for SQL injection attack group | `string` | `"alert"` | no |
| <a name="input_waf_wat_action"></a> [waf\_wat\_action](#input\_waf\_wat\_action) | WAF action for WAT (Web Attack Tool) attack group | `string` | `"alert"` | no |
| <a name="input_waf_xss_action"></a> [waf\_xss\_action](#input\_waf\_xss\_action) | WAF action for XSS attack group | `string` | `"alert"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_policy_id"></a> [security\_policy\_id](#output\_security\_policy\_id) | The ID of the created security policy |
<!-- END_TF_DOCS -->