/**
 * # Onboarding: Application Security Configuration for Bot Manager
 *
 * The use case for this module is to quickly create a new Application Security Configuration for Bot Manager
 * serving a set of hostnames following Akamai Professional Services Best Practices.
 *
 * Read on to find out which resources are provisioned as part of this
 * process, and how to customize!
 *
 */

resource "akamai_botman_bot_management_settings" "bot_manager_bvm" {
  count              = var.botman_type == "bvm" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = var.security_policy_id
  bot_management_settings = jsonencode(
    {
      "enableBotManagement" : true
      "removeBotManagementCookies" : var.remove_botman_cookies,
      "thirdPartyProxyServiceInUse" : var.third_party_proxy
    }
  )
}

resource "akamai_botman_bot_management_settings" "bot_manager_bms" {
  count              = var.botman_type == "bms" ? 1 : 0
  config_id          = var.config_id
  security_policy_id = var.security_policy_id
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

