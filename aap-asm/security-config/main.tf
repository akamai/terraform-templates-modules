/**
 * # Security Configuration (Config-Level)
 *
 * Creates and manages the Akamai Application Security configuration,
 * advanced settings, rate policies, and reputation profiles.
 * This module is called once per deployment. Individual security policies
 * are created by the companion `security-policy` module using `for_each`.
 *
 */

data "akamai_group" "group" {
  group_name  = var.group_name
  contract_id = var.contract_id
}

resource "akamai_appsec_configuration" "config" {
  name        = var.config_name
  description = var.description
  contract_id = var.contract_id
  group_id    = trimprefix(data.akamai_group.group.id, "grp_")
  host_names  = var.hostnames
}

resource "akamai_appsec_version_notes" "version_notes" {
  config_id     = akamai_appsec_configuration.config.config_id
  version_notes = var.version_notes
}
