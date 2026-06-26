resource "time_sleep" "wait_cr" {
  count           = var.enable_client_reputation ? 1 : 0
  create_duration = "20s"
  depends_on      = [akamai_appsec_configuration.config]
}

# Web Attackers
resource "akamai_appsec_reputation_profile" "web_attackers_high_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBATCK",
    "name" : "Web Attackers (High Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 9
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "web_attackers_high_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBATCK",
    "name" : "Web Attackers (High Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 9
  })
  depends_on = [akamai_appsec_reputation_profile.web_attackers_high_threat, time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "web_attackers_low_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBATCK",
    "name" : "Web Attackers (Low Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 5
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "web_attackers_low_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBATCK",
    "name" : "Web Attackers (Low Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 7
  })
  depends_on = [akamai_appsec_reputation_profile.web_attackers_low_threat, time_sleep.wait_cr]
}

# DoS Attackers
resource "akamai_appsec_reputation_profile" "dos_attackers_high_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "DOSATCK",
    "name" : "DoS Attackers (High Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 9
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "dos_attackers_high_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "DOSATCK",
    "name" : "DoS Attackers (High Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 9
  })
  depends_on = [akamai_appsec_reputation_profile.dos_attackers_high_threat, time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "dos_attackers_low_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "DOSATCK",
    "name" : "DoS Attackers (Low Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 5
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "dos_attackers_low_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "DOSATCK",
    "name" : "DoS Attackers (Low Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 7
  })
  depends_on = [akamai_appsec_reputation_profile.dos_attackers_low_threat, time_sleep.wait_cr]
}

# Scanning Tools
resource "akamai_appsec_reputation_profile" "scanning_tools_high_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "SCANTL",
    "name" : "Scanning Tools (High Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 9
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "scanning_tools_high_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "SCANTL",
    "name" : "Scanning Tools (High Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 9
  })
  depends_on = [akamai_appsec_reputation_profile.scanning_tools_high_threat, time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "scanning_tools_low_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "SCANTL",
    "name" : "Scanning Tools (Low Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 5
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "scanning_tools_low_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "SCANTL",
    "name" : "Scanning Tools (Low Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 7
  })
  depends_on = [akamai_appsec_reputation_profile.scanning_tools_low_threat, time_sleep.wait_cr]
}

# Web Scrapers
resource "akamai_appsec_reputation_profile" "web_scrapers_high_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBSCRP",
    "name" : "Web Scrapers (High Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 9
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "web_scrapers_high_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBSCRP",
    "name" : "Web Scrapers (High Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 9
  })
  depends_on = [akamai_appsec_reputation_profile.web_scrapers_high_threat, time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "web_scrapers_low_threat" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBSCRP",
    "name" : "Web Scrapers (Low Threat)",
    "sharedIpHandling" : "NON_SHARED",
    "threshold" : 5
  })
  depends_on = [time_sleep.wait_cr]
}

resource "akamai_appsec_reputation_profile" "web_scrapers_low_threat_shared" {
  count     = var.enable_client_reputation ? 1 : 0
  config_id = akamai_appsec_configuration.config.config_id
  reputation_profile = jsonencode({
    "condition" : {
      "atomicConditions" : [{
        "checkIps" : "connecting",
        "className" : "NetworkListCondition",
        "index" : 1,
        "positiveMatch" : true,
        "value" : var.client_lists_reputationbypass
      }],
      "positiveMatch" : false
    },
    "context" : "WEBSCRP",
    "name" : "Web Scrapers (Low Threat) [Shared IPs]",
    "sharedIpHandling" : "SHARED_ONLY",
    "threshold" : 7
  })
  depends_on = [akamai_appsec_reputation_profile.web_scrapers_low_threat, time_sleep.wait_cr]
}
