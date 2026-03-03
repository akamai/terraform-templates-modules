resource "akamai_botman_client_side_security" "client_side_security" {
  count     = var.enable_js_injection ? 1 : 0
  config_id = local.config_id
  client_side_security = jsonencode(
    {
      "useAllSecureTraffic" : true,
      "useSameSiteCookies" : false,
      "useStrictCspCompatibility" : true
    }
  )
}

resource "akamai_botman_transactional_endpoint_protection" "transactional_endpoint_protection" {
  config_id = local.config_id
  transactional_endpoint_protection = jsonencode(
    {
      "inlineTelemetry" : {
        "aggressiveThreshold" : 90,
        "detectionSetType" : "BOT_SCORE",
        "safeguardAction" : "USE_STRICT_ACTION",
        "strictThreshold" : 50
      },
      "sdkTelemetry" : {
        "androidAggressiveThreshold" : 90,
        "androidStrictThreshold" : 50,
        "detectionSetType" : "BOT_SCORE_SDK",
        "iosAggressiveThreshold" : 90,
        "iosStrictThreshold" : 50,
        "safeguardAction" : "USE_STRICT_ACTION"
      },
      "standardTelemetry" : {
        "aggressiveThreshold" : 90,
        "detectionSetType" : "BOT_SCORE",
        "safeguardAction" : "USE_STRICT_ACTION",
        "strictThreshold" : 50
      }
    }
  )
}