# Activating the rate control bypass list as terraform requires that the list be active before using in rate policies
resource "akamai_clientlist_activation" "client-lists-rcbypass-list_staging" {
  list_id                 = akamai_clientlist_list.client-lists-rcbypass-list.id
  version                 = akamai_clientlist_list.client-lists-rcbypass-list.version
  network                 = "STAGING"
  comments                = var.version_notes
  notification_recipients = var.notification_emails
}

# For now the activation to production is disabled
resource "akamai_clientlist_activation" "client-lists-rcbypass-list_production" {
  count                   = 0
  list_id                 = akamai_clientlist_list.client-lists-rcbypass-list.id
  version                 = akamai_clientlist_list.client-lists-rcbypass-list.version
  network                 = "PRODUCTION"
  comments                = var.version_notes
  notification_recipients = var.notification_emails
}