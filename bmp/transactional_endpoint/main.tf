
data "akamai_appsec_configuration" "config" {
  name = var.config_name
}

data "akamai_appsec_security_policy" "policy" {
  config_id = data.akamai_appsec_configuration.config.config_id
  security_policy_name = var.policy_name
}

locals {
  config_id = data.akamai_appsec_configuration.config.config_id
  policy_id = data.akamai_appsec_security_policy.policy.security_policy_id
}

