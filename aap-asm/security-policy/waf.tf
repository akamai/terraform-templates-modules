resource "akamai_appsec_waf_mode" "this" {
  count              = var.enable_waf ? 1 : 0
  config_id          = var.config_id
  security_policy_id = akamai_appsec_waf_protection.this.security_policy_id
  mode               = "ASE_AUTO"
}

resource "akamai_appsec_attack_group" "POLICY" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "POLICY"
  attack_group_action = var.waf_policy_action
}

resource "akamai_appsec_attack_group" "WAT" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "WAT"
  attack_group_action = var.waf_wat_action
}

resource "akamai_appsec_attack_group" "PROTOCOL" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "PROTOCOL"
  attack_group_action = var.waf_protocol_action
}

resource "akamai_appsec_attack_group" "SQL" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "SQL"
  attack_group_action = var.waf_sql_action
}

resource "akamai_appsec_attack_group" "XSS" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "XSS"
  attack_group_action = var.waf_xss_action
}

resource "akamai_appsec_attack_group" "CMD" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "CMD"
  attack_group_action = var.waf_cmd_action
}

resource "akamai_appsec_attack_group" "LFI" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "LFI"
  attack_group_action = var.waf_lfi_action
}

resource "akamai_appsec_attack_group" "RFI" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "RFI"
  attack_group_action = var.waf_rfi_action
}

resource "akamai_appsec_attack_group" "PLATFORM" {
  count               = var.enable_waf ? 1 : 0
  config_id           = var.config_id
  security_policy_id  = akamai_appsec_waf_protection.this.security_policy_id
  attack_group        = "PLATFORM"
  attack_group_action = var.waf_platform_action
}
