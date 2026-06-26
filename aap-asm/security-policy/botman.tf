# Bot Management Settings

resource "akamai_botman_bot_management_settings" "bot_manager_bvm" {
  count              = var.enable_botman && var.botman_type == "bvm" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  bot_management_settings = jsonencode(
    {
      "addAkamaiBotHeader" : var.add_akamai_bot_header,
      "enableActiveDetections" : var.enable_active_detections,
      "enableBotManagement" : true,
      "enableBrowserValidation" : var.enable_browser_validation,
      "removeBotManagementCookies" : var.remove_botman_cookies,
      "thirdPartyProxyServiceInUse" : var.third_party_proxy
    }
  )
}

resource "akamai_botman_bot_management_settings" "bot_manager_bms" {
  count              = var.enable_botman && var.botman_type == "bms" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  bot_management_settings = jsonencode(
    {
      "addAkamaiBotHeader" : var.add_akamai_bot_header,
      "enableActiveDetections" : var.enable_active_detections,
      "enableBotManagement" : true
      "enableBrowserValidation" : var.enable_browser_validation,
      "removeBotManagementCookies" : var.remove_botman_cookies,
      "thirdPartyProxyServiceInUse" : var.third_party_proxy
    }
  )
}

# Bot Active Detection Actions (BMS only)

resource "akamai_botman_bot_detection_action" "session_validation" {
  count              = var.enable_botman && var.botman_type == "bms" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "1bb748e2-b3ad-41db-85fa-c69e62be59dc"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_session_validation,
      "sessionActivitySensitivity" : "MEDIUM"
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "javascript_fingerprint_anomaly" {
  count              = var.enable_botman && var.botman_type == "bms" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "393cba3d-656f-48f1-abe4-8dd5028c6871"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_javascript_fingerprint_anomaly
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "cookie_integrity_failed" {
  count              = var.enable_botman && var.botman_type == "bms" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "4f1fd3ea-7072-4cd0-8d12-24f275e6c75d"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_cookie_integrity_failed
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "client_disabled_javascript_noscript_triggered" {
  count              = var.enable_botman && var.botman_type == "bms" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "c5623efa-f326-41d1-9601-a2d201bedf63"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_client_disabled_javascript_noscript_triggered
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "javascript_fingerprint_not_received" {
  count              = var.enable_botman && var.botman_type == "bms" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "c7f70f75-e3e2-4181-8ef8-30afb6576147"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_javascript_fingerprint_not_received
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

# Bot Category Actions

resource "akamai_botman_akamai_bot_category_action" "site_monitoring_and_web_development" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "07782c03-8d21-4491-9078-b83514e6508f"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_site_monitoring_and_web_development
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "academic_or_research" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "0c508e1d-73a4-4366-9e48-3c4a080f1c5d"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_academic_or_research
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "job_search_engine" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "2f169206-f32c-48f7-b281-d534cf1ceeb3"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_job_search_engine
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "artificial_intelligence_ai" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "352fca87-71ee-4b8d-ae15-d36772556072"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_artificial_intelligence_ai
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "online_advertising" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "36b27e0c-76fc-44a4-b913-c598c5af8bba"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_online_advertising
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "ecommerce_search_engine" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "47bcfb70-f3f5-458b-8f7c-1773b14bc6a4"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_ecommerce_search_engine
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "web_search_engine" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "4e14219f-6568-4c9d-9bd8-b29ca2afc422"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_web_search_engine
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "enterprise_data_aggregator" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "50395ad2-2673-41a4-b317-9b70742fd40f"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_enterprise_data_aggregator
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "financial_services" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "53598904-21f5-46b1-8b51-1b991beef73b"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_financial_services
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "social_media_or_blog" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "7035af8d-148c-429a-89da-de41e68c72d8"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_social_media_or_blog
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "web_archiver" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "831ef84a-c2bb-4b0d-b90d-bcd16793b830"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_web_archiver
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "business_intelligence" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "8a70d29c-a491-4583-9768-7deea2f379c1"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_business_intelligence
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "news_aggregator" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "ade03247-6519-4591-8458-9b7347004b63"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_news_aggregator
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "rss_feed_reader" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "b58c9929-9fd0-45f7-86f4-1d6259285c3c"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_rss_feed_reader
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "financial_account_aggregator" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "c6692e03-d3a8-49b0-9566-5003eeaddbc1"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_financial_account_aggregator
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "media_or_entertainment_search" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "dff258d5-b1ad-4bbb-b1d1-cf8e700e5bba"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_media_or_entertainment_search
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_akamai_bot_category_action" "seo_analytics_or_marketing" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  category_id        = "f7558c03-9033-46ce-bbda-10eeda62a5d4"
  akamai_bot_category_action = jsonencode(
    {
      "action" : var.bot_seo_analytics_or_marketing
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

# Bot Transparent Detection Actions

resource "akamai_botman_bot_detection_action" "declared_bots_keyword_match" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "074df68e-fb28-432a-ac6d-7cfb958425f1"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_declared_bots_keyword_match
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "http_libraries" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "578dad32-024b-48b4-930c-db81831686f4"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_http_libraries
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "aggressive_web_crawlers" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "5bc041ad-c840-4202-9c2e-d7fc873dbeaf"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_aggressive_web_crawlers
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "open_source_crawlersscraping_platforms" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "601192ae-f5e2-4a29-8f75-a0bcd3584c2b"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_open_source_crawlersscraping_platforms
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "web_services_libraries" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "872ed6c2-514c-4055-9c44-9782b1c783bf"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_web_services_libraries
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "web_scraper_reputation" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "9712ab32-83bb-43ab-a46d-4c2a5a42e7e2"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_web_scraper_reputation,
      "webScraperReputationSensitivity" : 4
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "browser_impersonator" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "a3b92f75-fa5d-436e-b066-426fc2919968"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_browser_impersonator
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "headless_browsersautomation_tools" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "b88cba13-4d11-46fe-a7e0-b47e78892dc4"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_headless_browsersautomation_tools
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "development_frameworks" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "da005ad3-8bbb-43c8-a783-d97d1fb71ad2"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_development_frameworks
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}

resource "akamai_botman_bot_detection_action" "impersonators_of_known_bots" {
  count              = var.enable_botman ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  detection_id       = "fda1ffb9-ef46-4570-929c-7449c0c750f8"
  bot_detection_action = jsonencode(
    {
      "action" : var.bot_impersonators_of_known_bots
    }
  )
  depends_on = [
    akamai_botman_bot_management_settings.bot_manager_bvm,
    akamai_botman_bot_management_settings.bot_manager_bms,
  ]
}
