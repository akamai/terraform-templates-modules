/**
 * # Onboarding: Application Security Configuration
 *
 * The use case for this module is to quickly create a new Application Security configuration
 * serving a set of hostnames following Akamai Professional Services Best Practices.
 *
 * Read on to find out which resources are provisioned as part of this
 * process, and how to customize!
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