resource "akamai_appsec_reputation_protection" "this" {
  count              = var.enable_client_reputation ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_security_policy.this.security_policy_id
  enabled            = true
}

# Web Attackers
resource "akamai_appsec_reputation_profile_action" "web_attackers_high_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_attackers_high_threat"]
  action                = var.rep_web_attackers_high
}

resource "akamai_appsec_reputation_profile_action" "web_attackers_high_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_attackers_high_threat_shared"]
  action                = var.rep_web_attackers_high_shared
}

resource "akamai_appsec_reputation_profile_action" "web_attackers_low_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_attackers_low_threat"]
  action                = var.rep_web_attackers_low
}

resource "akamai_appsec_reputation_profile_action" "web_attackers_low_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_attackers_low_threat_shared"]
  action                = var.rep_web_attackers_low_shared
}

# DoS Attackers
resource "akamai_appsec_reputation_profile_action" "dos_attackers_high_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["dos_attackers_high_threat"]
  action                = var.rep_dos_attackers_high
}

resource "akamai_appsec_reputation_profile_action" "dos_attackers_high_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["dos_attackers_high_threat_shared"]
  action                = var.rep_dos_attackers_high_shared
}

resource "akamai_appsec_reputation_profile_action" "dos_attackers_low_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["dos_attackers_low_threat"]
  action                = var.rep_dos_attackers_low
}

resource "akamai_appsec_reputation_profile_action" "dos_attackers_low_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["dos_attackers_low_threat_shared"]
  action                = var.rep_dos_attackers_low_shared
}

# Scanning Tools
resource "akamai_appsec_reputation_profile_action" "scanning_tools_high_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["scanning_tools_high_threat"]
  action                = var.rep_scanning_tools_high
}

resource "akamai_appsec_reputation_profile_action" "scanning_tools_high_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["scanning_tools_high_threat_shared"]
  action                = var.rep_scanning_tools_high_shared
}

resource "akamai_appsec_reputation_profile_action" "scanning_tools_low_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["scanning_tools_low_threat"]
  action                = var.rep_scanning_tools_low
}

resource "akamai_appsec_reputation_profile_action" "scanning_tools_low_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["scanning_tools_low_threat_shared"]
  action                = var.rep_scanning_tools_low_shared
}

# Web Scrapers
resource "akamai_appsec_reputation_profile_action" "web_scrapers_high_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_scrapers_high_threat"]
  action                = var.rep_web_scrapers_high
}

resource "akamai_appsec_reputation_profile_action" "web_scrapers_high_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_scrapers_high_threat_shared"]
  action                = var.rep_web_scrapers_high_shared
}

resource "akamai_appsec_reputation_profile_action" "web_scrapers_low_threat" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_scrapers_low_threat"]
  action                = var.rep_web_scrapers_low
}

resource "akamai_appsec_reputation_profile_action" "web_scrapers_low_threat_shared" {
  count                 = var.enable_client_reputation ? 1 : 0
  config_id             = var.config_id
  security_policy_id    = akamai_appsec_security_policy.this.security_policy_id
  reputation_profile_id = var.reputation_profile_ids["web_scrapers_low_threat_shared"]
  action                = var.rep_web_scrapers_low_shared
}
