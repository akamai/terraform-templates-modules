resource "akamai_clientlist_activation" "this" {
  for_each = local.client_list_activations

  list_id                 = each.value.list_id
  network                 = each.value.network
  comments                = var.version_notes
  notification_recipients = var.notification_emails
}
