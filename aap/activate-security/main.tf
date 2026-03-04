/**
 * # Activation: Application Security Configuration
 *
 * The use case for this module is to activate a new Application Security Configuration version
 * independently of the modules in use, and following Akamai Professional Services Best Practices.
 *
 * Read on to find out which resources are provisioned as part of this
 * process, and how to customize!
 *
 */

data "akamai_appsec_configuration" "config" {
  name = var.config_name
}

resource "akamai_appsec_activations" "staging" {
  count               = var.activate_to_staging || var.activation_to_staging_exists ? 1 : 0
  network             = "STAGING"
  config_id           = var.config_id
  version             = var.activate_to_staging ? data.akamai_appsec_configuration.config.latest_version : data.akamai_appsec_configuration.config.staging_version
  note                = var.activation_notes-var.dummy_temp_var
  notification_emails = var.notification_emails

  timeouts {
    default = "15m"
  }

  lifecycle {
    ignore_changes = [note]
  }
}

resource "akamai_appsec_activations" "production" {
  count               = var.activate_to_production || var.activation_to_production_exists ? 1 : 0
  network             = "PRODUCTION"
  config_id           = var.config_id
  version             = var.activate_to_production ? data.akamai_appsec_configuration.config.latest_version : data.akamai_appsec_configuration.config.production_version
  note                = var.activation_notes
  notification_emails = var.notification_emails

  timeouts {
    default = "30m"
  }

  lifecycle {
    ignore_changes = [note]
  }
}
