# Policy Identity

variable "config_id" {
  description = "Akamai security configuration ID"
  type        = number
}

variable "policy_name" {
  description = "Name for the security policy"
  type        = string
}

variable "policy_prefix" {
  description = "Four-character alphanumeric prefix for the security policy"
  type        = string
  validation {
    condition     = can(regex("^[A-Z0-9]{4}$", var.policy_prefix))
    error_message = "Policy prefix must be exactly 4 uppercase alphanumeric characters."
  }
}

# Match Target

variable "hostnames" {
  description = "List of hostnames this policy protects"
  type        = list(string)
  validation {
    condition     = alltrue([for h in var.hostnames : h == lower(h)])
    error_message = "Hostnames must be lowercase."
  }
}

variable "match_target_sequence" {
  description = "Sequence number for the match target (must be unique per policy)"
  type        = number
}

variable "bypass_network_lists" {
  description = "List of bypass network list objects for the match target"
  type = list(object({
    id   = string
    name = string
  }))
  default = []
}

# Protection Toggles

variable "enable_waf" {
  description = "Enable WAF protection"
  type        = bool
  default     = true
}

variable "enable_request_constraints" {
  description = "Enable API request constraints protection"
  type        = bool
  default     = false
}

variable "enable_ip_geo" {
  description = "Enable IP/Geo firewall protection"
  type        = bool
  default     = true
}

variable "enable_malware" {
  description = "Enable malware protection"
  type        = bool
  default     = false
}

variable "enable_rate" {
  description = "Enable rate control protection"
  type        = bool
  default     = true
}

variable "enable_slow_post" {
  description = "Enable slow POST protection"
  type        = bool
  default     = true
}

variable "enable_client_reputation" {
  description = "Enable client reputation protection"
  type        = bool
  default     = false
}

variable "enable_botman" {
  description = "Enable bot manager protection"
  type        = bool
  default     = false
}

# IP/Geo Firewall

variable "client_lists_ipblock" {
  description = "List of IP network list IDs to block"
  type        = list(string)
  default     = []
}

variable "client_lists_geoblock" {
  description = "List of geo network list IDs to block"
  type        = list(string)
  default     = []
}

variable "client_lists_exception_ipblock" {
  description = "List of IP network list IDs to exempt from blocking"
  type        = list(string)
  default     = []
}

# WAF Actions

variable "waf_policy_action" {
  description = "WAF action for POLICY attack group"
  type        = string
  default     = "alert"
}

variable "waf_wat_action" {
  description = "WAF action for WAT (Web Attack Tool) attack group"
  type        = string
  default     = "alert"
}

variable "waf_protocol_action" {
  description = "WAF action for PROTOCOL attack group"
  type        = string
  default     = "alert"
}

variable "waf_sql_action" {
  description = "WAF action for SQL injection attack group"
  type        = string
  default     = "alert"
}

variable "waf_xss_action" {
  description = "WAF action for XSS attack group"
  type        = string
  default     = "alert"
}

variable "waf_cmd_action" {
  description = "WAF action for CMD injection attack group"
  type        = string
  default     = "alert"
}

variable "waf_lfi_action" {
  description = "WAF action for LFI (Local File Inclusion) attack group"
  type        = string
  default     = "alert"
}

variable "waf_rfi_action" {
  description = "WAF action for RFI (Remote File Inclusion) attack group"
  type        = string
  default     = "alert"
}

variable "waf_platform_action" {
  description = "WAF action for PLATFORM attack group"
  type        = string
  default     = "alert"
}

# Penalty Box

variable "penalty_box_action" {
  description = "Penalty box action (deny or alert)"
  type        = string
  default     = "alert"
}

# Rate Policy Actions

variable "rate_policy_origin_error_id" {
  description = "Rate policy ID for origin error"
  type        = number
}

variable "rate_policy_post_page_requests_id" {
  description = "Rate policy ID for POST page requests"
  type        = number
}

variable "rate_policy_page_view_requests_id" {
  description = "Rate policy ID for page view requests"
  type        = number
}

variable "dos_origin_error_action" {
  description = "DoS action for origin error rate policy"
  type        = string
  default     = "alert"
}

variable "dos_post_page_requests_action" {
  description = "DoS action for POST page requests rate policy"
  type        = string
  default     = "alert"
}

variable "dos_page_view_requests_action" {
  description = "DoS action for page view requests rate policy"
  type        = string
  default     = "alert"
}

# Slow POST

variable "slow_post_action" {
  description = "Slow POST protection action"
  type        = string
  default     = "alert"
}

# Client Reputation Actions

variable "reputation_profile_ids" {
  description = "Map of reputation profile IDs from the security-config module"
  type        = map(number)
  default     = {}
}

variable "rep_web_attackers_high" {
  description = "Action for web attackers high threat reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_web_attackers_high_shared" {
  description = "Action for web attackers high threat shared reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_web_attackers_low" {
  description = "Action for web attackers low threat reputation profile"
  type        = string
  default     = "none"
}

variable "rep_web_attackers_low_shared" {
  description = "Action for web attackers low threat shared reputation profile"
  type        = string
  default     = "none"
}

variable "rep_dos_attackers_high" {
  description = "Action for DoS attackers high threat reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_dos_attackers_high_shared" {
  description = "Action for DoS attackers high threat shared reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_dos_attackers_low" {
  description = "Action for DoS attackers low threat reputation profile"
  type        = string
  default     = "none"
}

variable "rep_dos_attackers_low_shared" {
  description = "Action for DoS attackers low threat shared reputation profile"
  type        = string
  default     = "none"
}

variable "rep_scanning_tools_high" {
  description = "Action for scanning tools high threat reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_scanning_tools_high_shared" {
  description = "Action for scanning tools high threat shared reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_scanning_tools_low" {
  description = "Action for scanning tools low threat reputation profile"
  type        = string
  default     = "none"
}

variable "rep_scanning_tools_low_shared" {
  description = "Action for scanning tools low threat shared reputation profile"
  type        = string
  default     = "none"
}

variable "rep_web_scrapers_high" {
  description = "Action for web scrapers high threat reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_web_scrapers_high_shared" {
  description = "Action for web scrapers high threat shared reputation profile"
  type        = string
  default     = "alert"
}

variable "rep_web_scrapers_low" {
  description = "Action for web scrapers low threat reputation profile"
  type        = string
  default     = "none"
}

variable "rep_web_scrapers_low_shared" {
  description = "Action for web scrapers low threat shared reputation profile"
  type        = string
  default     = "none"
}

# Bot Manager Settings

variable "botman_type" {
  description = "Bot manager entitlement type: bvm (Bot Visibility and Management) or bms (Bot Management Standard)"
  type        = string
  default     = "bvm"
  validation {
    condition     = can(index(["bvm", "bms"], var.botman_type))
    error_message = "Invalid value for botman_type. Allowed values are bvm or bms."
  }
}

variable "add_akamai_bot_header" {
  description = "Adds a header named Akamai-Bot to bot requests forwarded to the origin (BMS only)"
  type        = bool
  default     = false
}

variable "enable_active_detections" {
  description = "Enable active detection methods that interact with the requesting client (BMS only)"
  type        = bool
  default     = false
}

variable "enable_browser_validation" {
  description = "Confirm that requests come from a browser (BMS only)"
  type        = bool
  default     = false
}

variable "remove_botman_cookies" {
  description = "Remove Bot Manager cookies before sending request to origin"
  type        = bool
  default     = true
}

variable "third_party_proxy" {
  description = "Enable if using a third-party proxy service between Akamai Edge servers"
  type        = bool
  default     = false
}

# Bot Active Detection Actions (BMS only)

variable "bot_session_validation" {
  description = "Bot active detection action: Session Validation"
  type        = string
  default     = "alert"
}

variable "bot_javascript_fingerprint_anomaly" {
  description = "Bot active detection action: JavaScript Fingerprint Anomaly"
  type        = string
  default     = "alert"
}

variable "bot_cookie_integrity_failed" {
  description = "Bot active detection action: Cookie Integrity Failed"
  type        = string
  default     = "alert"
}

variable "bot_client_disabled_javascript_noscript_triggered" {
  description = "Bot active detection action: Client Disabled JavaScript (Noscript Triggered)"
  type        = string
  default     = "alert"
}

variable "bot_javascript_fingerprint_not_received" {
  description = "Bot active detection action: JavaScript Fingerprint Not Received"
  type        = string
  default     = "alert"
}

# Bot Category Actions

variable "bot_site_monitoring_and_web_development" {
  description = "Action for Akamai bot category: Site Monitoring and Web Development Bots"
  type        = string
  default     = "alert"
}

variable "bot_academic_or_research" {
  description = "Action for Akamai bot category: Academic or Research Bots"
  type        = string
  default     = "alert"
}

variable "bot_job_search_engine" {
  description = "Action for Akamai bot category: Job Search Engine Bots"
  type        = string
  default     = "alert"
}

variable "bot_artificial_intelligence_ai" {
  description = "Action for Akamai bot category: Artificial Intelligence (AI) Bots"
  type        = string
  default     = "alert"
}

variable "bot_online_advertising" {
  description = "Action for Akamai bot category: Online Advertising Bots"
  type        = string
  default     = "alert"
}

variable "bot_ecommerce_search_engine" {
  description = "Action for Akamai bot category: E-Commerce Search Engine Bots"
  type        = string
  default     = "alert"
}

variable "bot_web_search_engine" {
  description = "Action for Akamai bot category: Web Search Engine Bots"
  type        = string
  default     = "alert"
}

variable "bot_enterprise_data_aggregator" {
  description = "Action for Akamai bot category: Enterprise Data Aggregator Bots"
  type        = string
  default     = "alert"
}

variable "bot_financial_services" {
  description = "Action for Akamai bot category: Financial Services Bots"
  type        = string
  default     = "alert"
}

variable "bot_social_media_or_blog" {
  description = "Action for Akamai bot category: Social Media or Blog Bots"
  type        = string
  default     = "alert"
}

variable "bot_web_archiver" {
  description = "Action for Akamai bot category: Web Archiver Bots"
  type        = string
  default     = "alert"
}

variable "bot_business_intelligence" {
  description = "Action for Akamai bot category: Business Intelligence Bots"
  type        = string
  default     = "alert"
}

variable "bot_news_aggregator" {
  description = "Action for Akamai bot category: News Aggregator Bots"
  type        = string
  default     = "alert"
}

variable "bot_rss_feed_reader" {
  description = "Action for Akamai bot category: RSS Feed Reader Bots"
  type        = string
  default     = "alert"
}

variable "bot_financial_account_aggregator" {
  description = "Action for Akamai bot category: Financial Account Aggregator Bots"
  type        = string
  default     = "alert"
}

variable "bot_media_or_entertainment_search" {
  description = "Action for Akamai bot category: Media or Entertainment Search Bots"
  type        = string
  default     = "alert"
}

variable "bot_seo_analytics_or_marketing" {
  description = "Action for Akamai bot category: SEO, Analytics or Marketing Bots"
  type        = string
  default     = "alert"
}

# Bot Transparent Detection Actions

variable "bot_declared_bots_keyword_match" {
  description = "Action for bot transparent detection: Declared Bots (Keyword Match)"
  type        = string
  default     = "alert"
}

variable "bot_http_libraries" {
  description = "Action for bot transparent detection: HTTP Libraries"
  type        = string
  default     = "alert"
}

variable "bot_aggressive_web_crawlers" {
  description = "Action for bot transparent detection: Aggressive Web Crawlers"
  type        = string
  default     = "alert"
}

variable "bot_open_source_crawlersscraping_platforms" {
  description = "Action for bot transparent detection: Open Source Crawlers/Scraping Platforms"
  type        = string
  default     = "alert"
}

variable "bot_web_services_libraries" {
  description = "Action for bot transparent detection: Web Services Libraries"
  type        = string
  default     = "alert"
}

variable "bot_web_scraper_reputation" {
  description = "Action for bot transparent detection: Web Scraper Reputation"
  type        = string
  default     = "alert"
}

variable "bot_browser_impersonator" {
  description = "Action for bot transparent detection: Browser Impersonator"
  type        = string
  default     = "alert"
}

variable "bot_headless_browsersautomation_tools" {
  description = "Action for bot transparent detection: Headless Browsers/Automation Tools"
  type        = string
  default     = "alert"
}

variable "bot_development_frameworks" {
  description = "Action for bot transparent detection: Development Frameworks"
  type        = string
  default     = "alert"
}

variable "bot_impersonators_of_known_bots" {
  description = "Action for bot transparent detection: Impersonators of Known Bots"
  type        = string
  default     = "alert"
}
