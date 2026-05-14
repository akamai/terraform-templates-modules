/**
 * # Onboarding: App & API Protector (AAP)
 *
 * Supports the creation of multiple environments (e.g. dev, qa, prod) if required by the customer.
 * Also supports creating the initial configuration for BVM (Bot Visibility and Management) or BMS (Bot Management Standard)
 *
 * ## Authentication
 *
 * Please refer to [Terraform Overview](https://techdocs.akamai.com/terraform/docs/overview) and [Terraform Alternative authentication](https://techdocs.akamai.com/terraform/docs/gs-authentication) for more details on how to authenticate to Akamai when using Terraform.
 * 
 * ## Usage
 * 
 * 1. Clone the repository, using following command:
 * 
 * ```bash
 * > git clone <git url>
 * > cd terraform-templates/new-aap-configuration/
 * ```
 * 
 * 2. Inside the `./environments` folder is where you create/delete the subdirectories and files to support more environments if needed. Refer to the examples inside the `./environments` folder. If you only need a single environment just leave a single directory (you can name it "prod"). The environment name must also be used as prefix in the `tfvars` filename. In our example for "prod" the `tfvars` file will be `prod.tfvars`. Remove the .dist extension from the `tfvars` filenames you plan to reuse and specify the required values for the different parameters.
 *
 *    You'll find additional instructions inside the example `tfvars` files.
 *
 * 3. Run the deployment script `../deploy.ps1`. This script is written in PowerShell and acts as an orchestrator for Terraform. It allows to perform individual save and activation actions, it handles the multi-environment directory and files to avoid overwriting the state file. A debug/log mode can also be enabled.
 *
 *     A common flow is as follows (with "prod" as the environment):
 *     1. Save the changes only (no activations) using the AAP template/product:
 *     ```bash
 *     pwsh deploy.ps1 aap -Env prod -Save -Notes "Some user user notes"
 *     ```
 *
 *     2. Activate to staging:
 *     ```bash
 *     pwsh aap -Env prod -ActivateStaging
 *     ```
 *
 *     3. Activate to production:
 *     ```bash
 *     pwsh aap -Env prod -ActivateProduction
 *     ```
 *     
 *     Options:
 *     * Add the `-Debug` option to the command to log all the Terraform actions in a file stored in the specific environment directory.
 *     * Add the `-Dry` option to the command to do a dry-run (nothing is applied).
 *     * You can delete all the resources when you don't need them. Keep in mind some resource can't be deleted in which cases the `terraform destroy` operation will fail as a consequence.
 *     ```bash
 *     pwsh deploy.ps1 aap -Env dev -Destroy
 *     ```
 *
 * ## Known Errors
 * You will see the following error during the first terraform execution because in AAP the Rate Control Policies are created by default, therefore when Terraform tries to create them it fails. So we detect the failure and retry Terraform and import the default Rate Control Policies to their respective resources in the code. This way we can modify them to the best practices in our code. The error should look like the following, which you can ignore.
 *
 * ```hcl
 * │ Error: Title: Invalid Input Error; Type: https://problems.luna.akamaiapis.net/appsec-resource/error-types/INVALID-INPUT-ERROR; Detail: Policy name already exists for configuration version.
 * ```
 * 
 */

data "akamai_contract" "contract" {
  group_name = var.group_name
}


module "client-lists" {
  count               = var.create_client_lists ? 1 : 0
  source              = "./client-lists"
  client_lists_prefix = substr("${MATRIX_NAME}.terra.rafa.cr", 0, 20)
  config_name         = "${MATRIX_NAME}.terra.rafa.cr"
  contract_id         = trimprefix(data.akamai_contract.contract.id, "ctr_")
  group_id            = trimprefix(data.akamai_contract.contract.group_id, "grp_")
  notification_emails = var.emails
  version_notes       = var.version_notes
}

locals {
  client_lists_ipblock           = var.create_client_lists ? module.client-lists[0].client_lists_ipblock_id : var.client_lists_ipblock
  client_lists_ipblock_exception = var.create_client_lists ? module.client-lists[0].client_lists_ipblock_exception_id : var.client_lists_ipblock_exception
  client_lists_geoblock          = var.create_client_lists ? module.client-lists[0].client_lists_geoblock_id : var.client_lists_geoblock
  client_lists_securitybypass    = var.create_client_lists ? module.client-lists[0].client_lists_securitybypass_id : var.client_lists_securitybypass
  client_lists_rcbypass          = var.create_client_lists ? module.client-lists[0].client_lists_rcbypass_id : var.client_lists_rcbypass
  client_lists_pragmabypass      = var.create_client_lists ? module.client-lists[0].client_lists_pragmabypass_id : var.client_lists_pragmabypass
}

module "security" {
  source        = "./security"
  hostnames     = ["${MATRIX_NAME}.terra.rafa.cr"]
  config_name   = "${MATRIX_NAME}.terra.rafa.cr"
  description   = var.description
  version_notes = var.version_notes
  contract_id   = trimprefix(data.akamai_contract.contract.id, "ctr_")
  group_name    = var.group_name

  # Advanced Settings
  inspection_size = var.inspection_size

  # Protections
  enable_waf       = var.enable_waf
  enable_ip_geo    = var.enable_ip_geo
  enable_malware   = var.enable_malware
  enable_rate      = var.enable_rate
  enable_slow_post = var.enable_slow_post

  # IP/Geo Firewall
  client_lists_ipblock           = local.client_lists_ipblock
  client_lists_exception_ipblock = local.client_lists_ipblock_exception
  client_lists_geoblock          = local.client_lists_geoblock

  # Bypass Lists
  client_lists_rcbypass       = local.client_lists_rcbypass
  client_lists_pragmabypass   = local.client_lists_pragmabypass
  client_lists_securitybypass = local.client_lists_securitybypass

  # Dos Protection
  dos_origin_error_action       = var.dos_origin_error_action
  dos_post_page_requests_action = var.dos_post_page_requests_action
  dos_page_view_requests_action = var.dos_page_view_requests_action
  slow_post_action              = var.slow_post_action

  # Web Application Firewall (WAF) Actions
  waf_policy_action   = var.waf_policy_action
  waf_wat_action      = var.waf_wat_action
  waf_protocol_action = var.waf_protocol_action
  waf_sql_action      = var.waf_sql_action
  waf_xss_action      = var.waf_xss_action
  waf_cmd_action      = var.waf_cmd_action
  waf_lfi_action      = var.waf_lfi_action
  waf_rfi_action      = var.waf_rfi_action
  waf_platform_action = var.waf_platform_action
  penalty_box_action  = var.penalty_box_action

  depends_on = [module.client-lists, module.delivery]
}

module "botman" {
  count              = var.enable_botman ? 1 : 0
  source             = "./bot-manager"
  botman_type        = var.botman_type
  config_id          = module.security.config_id
  security_policy_id = module.security.security_policy_id

  add_akamai_bot_header     = var.add_akamai_bot_header
  enable_active_detections  = var.enable_active_detections
  enable_browser_validation = var.enable_browser_validation
  remove_botman_cookies     = var.remove_botman_cookies
  third_party_proxy         = var.third_party_proxy

  # Bot Category Actions
  bot_site_monitoring_and_web_development = var.bot_site_monitoring_and_web_development
  bot_academic_or_research                = var.bot_academic_or_research
  bot_job_search_engine                   = var.bot_job_search_engine
  bot_artificial_intelligence_ai          = var.bot_artificial_intelligence_ai
  bot_online_advertising                  = var.bot_online_advertising
  bot_ecommerce_search_engine             = var.bot_ecommerce_search_engine
  bot_web_search_engine                   = var.bot_web_search_engine
  bot_enterprise_data_aggregator          = var.bot_enterprise_data_aggregator
  bot_financial_services                  = var.bot_financial_services
  bot_social_media_or_blog                = var.bot_social_media_or_blog
  bot_web_archiver                        = var.bot_web_archiver
  bot_business_intelligence               = var.bot_business_intelligence
  bot_news_aggregator                     = var.bot_news_aggregator
  bot_rss_feed_reader                     = var.bot_rss_feed_reader
  bot_financial_account_aggregator        = var.bot_financial_account_aggregator
  bot_media_or_entertainment_search       = var.bot_media_or_entertainment_search
  bot_seo_analytics_or_marketing          = var.bot_seo_analytics_or_marketing

  # Bot Transparent Detections Actions
  bot_impersonators_of_known_bots            = var.bot_impersonators_of_known_bots
  bot_development_frameworks                 = var.bot_development_frameworks
  bot_http_libraries                         = var.bot_http_libraries
  bot_web_services_libraries                 = var.bot_web_services_libraries
  bot_open_source_crawlersscraping_platforms = var.bot_open_source_crawlersscraping_platforms
  bot_headless_browsersautomation_tools      = var.bot_headless_browsersautomation_tools
  bot_declared_bots_keyword_match            = var.bot_declared_bots_keyword_match
  bot_aggressive_web_crawlers                = var.bot_aggressive_web_crawlers
  bot_browser_impersonator                   = var.bot_browser_impersonator
  bot_web_scraper_reputation                 = var.bot_web_scraper_reputation

  # Bot Active Detections Actions
  bot_cookie_integrity_failed                       = var.bot_cookie_integrity_failed
  bot_session_validation                            = var.bot_session_validation
  bot_client_disabled_javascript_noscript_triggered = var.bot_client_disabled_javascript_noscript_triggered
  bot_javascript_fingerprint_anomaly                = var.bot_javascript_fingerprint_anomaly
  bot_javascript_fingerprint_not_received           = var.bot_javascript_fingerprint_not_received

  depends_on = [module.security]
}

module "activate-security" {
  source                          = "./activate-security"
  config_name                     = var.config_name
  config_id                       = module.security.config_id
  activate_to_staging             = var.activate_to_staging
  activation_to_staging_exists    = var.activation_to_staging_exists
  activate_to_production          = var.activate_to_production
  activation_to_production_exists = var.activation_to_production_exists
  notification_emails             = var.emails
  activation_notes                = var.version_notes
  depends_on = [
    module.security,
    module.botman
  ]
}

module "delivery" {
  source = "../delivery"
  contract_id = trimprefix(data.akamai_contract.contract.id, "ctr_")
  group_id = trimprefix(data.akamai_contract.contract.group_id, "grp_")
  hostnames = ["${MATRIX_NAME}.terra.rafa.cr"]
  name = "${MATRIX_NAME}.terra.rafa.cr"
  cpcode_name = "${MATRIX_NAME}.terra.rafa.cr"
  default_origin = "flexibleorigin.rafa.cr"
  additional_origins = []
  notification_emails = ["test@akamai.com"]
  version_notes = "GitHub Actions test"
  certificate_id = null
  peer_reviewed_by = "test@na.com"
  customer_email = "test@akamai.com"
  unit_tested = true
  ticket_id = "some-ticket-id"
  noncompliance_reason = ["NONE"]
  other_noncompliance_reason = "test"
  td_region = "CH2"
  ip_behavior = "IPV6_PERFORMANCE"
  sure_route_test_object = "/terraform/srto.html"
  activation_notes = "GitHub Actions test"
  activation_to_staging_exists = false
  activation_to_production_exists = false
  etls = true
  secure_by_default = true
  product_id = "Fresca"
  activate_to_staging = true
  activate_to_production = false
}