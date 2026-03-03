data "akamai_appsec_configuration" "config" {
  name = var.config_name
}


resource "akamai_appsec_activations" "staging" {
  count               = var.activate_to_staging || var.activation_to_staging_exists ? 1 : 0
  network             = "STAGING"
  config_id           = var.config_id
  version             = var.activate_to_staging ? data.akamai_appsec_configuration.config.latest_version : data.akamai_appsec_configuration.config.staging_version
  note                = var.activation_notes
  notification_emails = var.notification_emails

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

  lifecycle {
    ignore_changes = [note]
  }

}
