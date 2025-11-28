<!-- BEGIN_TF_DOCS -->

# Onboarding: Application Security Configuration for Bot Manager

The use case for this module is to quickly create a new Application Security Configuration for Bot Manager
serving a set of hostnames following Akamai Professional Services Best Practices.

Read on to find out which resources are provisioned as part of this
process, and how to customize!

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 botman_type  = <string>
  	 config_id  = <string>
  	 remove_botman_cookies  = <bool>
  	 security_policy_id  = <string>
  	 third_party_proxy  = <bool>
  
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
  	 enable_active_detections  = <bool> | default: false
  	 enable_browser_validation  = <bool> | default: false
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
| [akamai_botman_akamai_bot_category_action.tfdemo_academic_or_research_bots_0c508e1d-73a4-4366-9e48-3c4a080f1c5d](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_artificial_intelligence_ai_bots_352fca87-71ee-4b8d-ae15-d36772556072](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_business_intelligence_bots_8a70d29c-a491-4583-9768-7deea2f379c1](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_ecommerce_search_engine_bots_47bcfb70-f3f5-458b-8f7c-1773b14bc6a4](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_enterprise_data_aggregator_bots_50395ad2-2673-41a4-b317-9b70742fd40f](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_financial_account_aggregator_bots_c6692e03-d3a8-49b0-9566-5003eeaddbc1](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_financial_services_bots_53598904-21f5-46b1-8b51-1b991beef73b](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_job_search_engine_bots_2f169206-f32c-48f7-b281-d534cf1ceeb3](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_media_or_entertainment_search_bots_dff258d5-b1ad-4bbb-b1d1-cf8e700e5bba](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_news_aggregator_bots_ade03247-6519-4591-8458-9b7347004b63](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_online_advertising_bots_36b27e0c-76fc-44a4-b913-c598c5af8bba](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_rss_feed_reader_bots_b58c9929-9fd0-45f7-86f4-1d6259285c3c](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_seo_analytics_or_marketing_bots_f7558c03-9033-46ce-bbda-10eeda62a5d4](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_site_monitoring_and_web_development_bots_07782c03-8d21-4491-9078-b83514e6508f](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_social_media_or_blog_bots_7035af8d-148c-429a-89da-de41e68c72d8](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_web_archiver_bots_831ef84a-c2bb-4b0d-b90d-bcd16793b830](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_akamai_bot_category_action.tfdemo_web_search_engine_bots_4e14219f-6568-4c9d-9bd8-b29ca2afc422](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_akamai_bot_category_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_aggressive_web_crawlers_5bc041ad-c840-4202-9c2e-d7fc873dbeaf](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_browser_impersonator_a3b92f75-fa5d-436e-b066-426fc2919968](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_client_disabled_javascript_noscript_triggered_c5623efa-f326-41d1-9601-a2d201bedf63](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_cookie_integrity_failed_4f1fd3ea-7072-4cd0-8d12-24f275e6c75d](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_declared_bots_keyword_match_074df68e-fb28-432a-ac6d-7cfb958425f1](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_development_frameworks_da005ad3-8bbb-43c8-a783-d97d1fb71ad2](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_headless_browsersautomation_tools_b88cba13-4d11-46fe-a7e0-b47e78892dc4](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_http_libraries_578dad32-024b-48b4-930c-db81831686f4](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_impersonators_of_known_bots_fda1ffb9-ef46-4570-929c-7449c0c750f8](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_javascript_fingerprint_anomaly_393cba3d-656f-48f1-abe4-8dd5028c6871](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_javascript_fingerprint_not_received_c7f70f75-e3e2-4181-8ef8-30afb6576147](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_open_source_crawlersscraping_platforms_601192ae-f5e2-4a29-8f75-a0bcd3584c2b](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_session_validation_1bb748e2-b3ad-41db-85fa-c69e62be59dc](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_web_scraper_reputation_9712ab32-83bb-43ab-a46d-4c2a5a42e7e2](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_detection_action.tfdemo_web_services_libraries_872ed6c2-514c-4055-9c44-9782b1c783bf](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_detection_action) | resource |
| [akamai_botman_bot_management_settings.bot_manager_bms](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_management_settings) | resource |
| [akamai_botman_bot_management_settings.bot_manager_bvm](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/botman_bot_management_settings) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_botman_type"></a> [botman\_type](#input\_botman\_type) | Chose based on the available entitlement: BVM (Bot Visibility and Management) or BMS (Bot Management Standard) | `string` | n/a | yes |
| <a name="input_config_id"></a> [config\_id](#input\_config\_id) | Akamai security configuration ID | `string` | n/a | yes |
| <a name="input_remove_botman_cookies"></a> [remove\_botman\_cookies](#input\_remove\_botman\_cookies) | Remove Bot Manager cookies before sending request to origin | `bool` | n/a | yes |
| <a name="input_security_policy_id"></a> [security\_policy\_id](#input\_security\_policy\_id) | Security policy ID | `string` | n/a | yes |
| <a name="input_third_party_proxy"></a> [third\_party\_proxy](#input\_third\_party\_proxy) | If you use a third-party proxy service between two Akamai Edge servers for things like A/B testing, content translation, or content adaption engines, turn this on to improve detection accuracy | `bool` | n/a | yes |
| <a name="input_add_akamai_bot_header"></a> [add\_akamai\_bot\_header](#input\_add\_akamai\_bot\_header) | Adds a header named Akamai-Bot to bot request forwarded to the origin. The header contains details like: bot type, Botnet ID, action, detection method, and bot score details, if applicable | `bool` | `false` | no |
| <a name="input_bot_academic_or_research"></a> [bot\_academic\_or\_research](#input\_bot\_academic\_or\_research) | Action for Akamai Bot Category: Academic or Research Bots | `string` | `"alert"` | no |
| <a name="input_bot_aggressive_web_crawlers"></a> [bot\_aggressive\_web\_crawlers](#input\_bot\_aggressive\_web\_crawlers) | Action for Bot Transparent Detections: Aggressive Web Crawlers | `string` | `"alert"` | no |
| <a name="input_bot_artificial_intelligence_ai"></a> [bot\_artificial\_intelligence\_ai](#input\_bot\_artificial\_intelligence\_ai) | Action for Akamai Bot Category: Artificial Intelligence (AI) Bots | `string` | `"alert"` | no |
| <a name="input_bot_browser_impersonator"></a> [bot\_browser\_impersonator](#input\_bot\_browser\_impersonator) | Action for Bot Transparent Detections: Browser Impersonator | `string` | `"alert"` | no |
| <a name="input_bot_business_intelligence"></a> [bot\_business\_intelligence](#input\_bot\_business\_intelligence) | Action for Akamai Bot Category: Business Intelligence Bots | `string` | `"alert"` | no |
| <a name="input_bot_client_disabled_javascript_noscript_triggered"></a> [bot\_client\_disabled\_javascript\_noscript\_triggered](#input\_bot\_client\_disabled\_javascript\_noscript\_triggered) | Bot Active Detections Actions: Client Disabled JavaScript (Noscript Triggered) | `string` | `"alert"` | no |
| <a name="input_bot_cookie_integrity_failed"></a> [bot\_cookie\_integrity\_failed](#input\_bot\_cookie\_integrity\_failed) | Bot Active Detections Actions: Cookie Integrity Failed | `string` | `"alert"` | no |
| <a name="input_bot_declared_bots_keyword_match"></a> [bot\_declared\_bots\_keyword\_match](#input\_bot\_declared\_bots\_keyword\_match) | Action for Bot Transparent Detections: Declared Bots (Keyword Match) | `string` | `"alert"` | no |
| <a name="input_bot_development_frameworks"></a> [bot\_development\_frameworks](#input\_bot\_development\_frameworks) | Action for Bot Transparent Detections: Development Frameworks | `string` | `"alert"` | no |
| <a name="input_bot_ecommerce_search_engine"></a> [bot\_ecommerce\_search\_engine](#input\_bot\_ecommerce\_search\_engine) | Action for Akamai Bot Category: E-Commerce Search Engine Bots | `string` | `"alert"` | no |
| <a name="input_bot_enterprise_data_aggregator"></a> [bot\_enterprise\_data\_aggregator](#input\_bot\_enterprise\_data\_aggregator) | Action for Akamai Bot Category: Enterprise Data Aggregator Bots | `string` | `"alert"` | no |
| <a name="input_bot_financial_account_aggregator"></a> [bot\_financial\_account\_aggregator](#input\_bot\_financial\_account\_aggregator) | Action for Akamai Bot Category: Financial Account Aggregator Bots | `string` | `"alert"` | no |
| <a name="input_bot_financial_services"></a> [bot\_financial\_services](#input\_bot\_financial\_services) | Action for Akamai Bot Category: Financial Services Bots | `string` | `"alert"` | no |
| <a name="input_bot_headless_browsersautomation_tools"></a> [bot\_headless\_browsersautomation\_tools](#input\_bot\_headless\_browsersautomation\_tools) | Action for Bot Transparent Detections: Headless Browsers/Automation Tools | `string` | `"alert"` | no |
| <a name="input_bot_http_libraries"></a> [bot\_http\_libraries](#input\_bot\_http\_libraries) | Action for Bot Transparent Detections: HTTP Libraries | `string` | `"alert"` | no |
| <a name="input_bot_impersonators_of_known_bots"></a> [bot\_impersonators\_of\_known\_bots](#input\_bot\_impersonators\_of\_known\_bots) | Action for Bot Transparent Detections: Impersonators of Known Bots | `string` | `"alert"` | no |
| <a name="input_bot_javascript_fingerprint_anomaly"></a> [bot\_javascript\_fingerprint\_anomaly](#input\_bot\_javascript\_fingerprint\_anomaly) | Bot Active Detections Actions: JavaScript Fingerprint Anomaly | `string` | `"alert"` | no |
| <a name="input_bot_javascript_fingerprint_not_received"></a> [bot\_javascript\_fingerprint\_not\_received](#input\_bot\_javascript\_fingerprint\_not\_received) | Bot Active Detections Actions: JavaScript Fingerprint Not Received | `string` | `"alert"` | no |
| <a name="input_bot_job_search_engine"></a> [bot\_job\_search\_engine](#input\_bot\_job\_search\_engine) | Action for Akamai Bot Category: Job Search Engine Bots | `string` | `"alert"` | no |
| <a name="input_bot_media_or_entertainment_search"></a> [bot\_media\_or\_entertainment\_search](#input\_bot\_media\_or\_entertainment\_search) | Action for Akamai Bot Category: Media or Entertainment Search Bots | `string` | `"alert"` | no |
| <a name="input_bot_news_aggregator"></a> [bot\_news\_aggregator](#input\_bot\_news\_aggregator) | Action for Akamai Bot Category: News Aggregator Bots | `string` | `"alert"` | no |
| <a name="input_bot_online_advertising"></a> [bot\_online\_advertising](#input\_bot\_online\_advertising) | Action for Akamai Bot Category: Online Advertising Bots | `string` | `"alert"` | no |
| <a name="input_bot_open_source_crawlersscraping_platforms"></a> [bot\_open\_source\_crawlersscraping\_platforms](#input\_bot\_open\_source\_crawlersscraping\_platforms) | Action for Bot Transparent Detections: Open Source Crawlers/Scraping Platforms | `string` | `"alert"` | no |
| <a name="input_bot_rss_feed_reader"></a> [bot\_rss\_feed\_reader](#input\_bot\_rss\_feed\_reader) | Action for Akamai Bot Category: RSS Feed Reader Bots | `string` | `"alert"` | no |
| <a name="input_bot_seo_analytics_or_marketing"></a> [bot\_seo\_analytics\_or\_marketing](#input\_bot\_seo\_analytics\_or\_marketing) | Action for Akamai Bot Category: SEO, Analytics or Marketing Bots | `string` | `"alert"` | no |
| <a name="input_bot_session_validation"></a> [bot\_session\_validation](#input\_bot\_session\_validation) | Bot Active Detections Actions: Session Validation | `string` | `"alert"` | no |
| <a name="input_bot_site_monitoring_and_web_development"></a> [bot\_site\_monitoring\_and\_web\_development](#input\_bot\_site\_monitoring\_and\_web\_development) | Action for Akamai Bot Category: Site Monitoring and Web Development Bots | `string` | `"alert"` | no |
| <a name="input_bot_social_media_or_blog"></a> [bot\_social\_media\_or\_blog](#input\_bot\_social\_media\_or\_blog) | Action for Akamai Bot Category: Social Media or Blog Bots | `string` | `"alert"` | no |
| <a name="input_bot_web_archiver"></a> [bot\_web\_archiver](#input\_bot\_web\_archiver) | Action for Akamai Bot Category: Web Archiver Bots | `string` | `"alert"` | no |
| <a name="input_bot_web_scraper_reputation"></a> [bot\_web\_scraper\_reputation](#input\_bot\_web\_scraper\_reputation) | Action for Bot Transparent Detections: Web Scraper Reputation | `string` | `"alert"` | no |
| <a name="input_bot_web_search_engine"></a> [bot\_web\_search\_engine](#input\_bot\_web\_search\_engine) | Action for Akamai Bot Category: Web Search Engine Bots | `string` | `"alert"` | no |
| <a name="input_bot_web_services_libraries"></a> [bot\_web\_services\_libraries](#input\_bot\_web\_services\_libraries) | Action for Bot Transparent Detections: Web Services Libraries | `string` | `"alert"` | no |
| <a name="input_enable_active_detections"></a> [enable\_active\_detections](#input\_enable\_active\_detections) | These methods interact with the requesting client using a combination of JavaScript and cookies to try to confirm that the request comes from a human using a real web browser | `bool` | `false` | no |
| <a name="input_enable_browser_validation"></a> [enable\_browser\_validation](#input\_enable\_browser\_validation) | Confirm that requests come from a browser. Enable use browser validation detection anywhere you expect browsers to visit the URL | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->