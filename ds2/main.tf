/**
 * # Module: DataStream 2 (DS-managed / Decoupled)
 *
 * This module provisions a DataStream 2 (DS2) configuration using the decoupled
 * workflow introduced in Milestone-1. It allows log collection without requiring
 * any DataStream behavior in the Property Manager.
 *
 * Associate existing properties via `property_ids` — the stream runs in
 * `DS_MANAGED` mode and begins delivering logs when those properties are active.
 */

resource "akamai_datastream" "this" {
  stream_name         = var.name
  contract_id         = var.contract_id
  group_id            = var.group_id
  active              = var.activate_stream
  notification_emails = var.notification_emails

  properties          = var.property_ids
  dataset_fields      = var.dataset_fields_ids
  collect_midgress    = var.enable_midgress
  sampling_percentage = var.sampling_percentage

  delivery_configuration {
    format             = var.log_format
    field_delimiter    = var.field_delimiter
    upload_file_prefix = var.upload_file_prefix
    upload_file_suffix = var.upload_file_suffix
    frequency {
      interval_in_secs = var.interval_in_secs
    }
  }

  dynamic "s3_connector" {
    for_each = var.s3_connector != null ? [var.s3_connector] : []
    content {
      display_name      = s3_connector.value.display_name
      bucket            = s3_connector.value.bucket
      region            = s3_connector.value.region
      access_key        = s3_connector.value.access_key
      secret_access_key = s3_connector.value.secret_access_key
      path              = s3_connector.value.path
    }
  }

  dynamic "datadog_connector" {
    for_each = var.datadog_connector != null ? [var.datadog_connector] : []
    content {
      display_name  = datadog_connector.value.display_name
      endpoint      = datadog_connector.value.endpoint
      auth_token    = datadog_connector.value.auth_token
      service       = datadog_connector.value.service
      source        = datadog_connector.value.source
      tags          = datadog_connector.value.tags
      compress_logs = datadog_connector.value.compress_logs
    }
  }

  dynamic "splunk_connector" {
    for_each = var.splunk_connector != null ? [var.splunk_connector] : []
    content {
      display_name          = splunk_connector.value.display_name
      endpoint              = splunk_connector.value.endpoint
      event_collector_token = splunk_connector.value.event_collector_token
      compress_logs         = splunk_connector.value.compress_logs
      custom_header_name    = splunk_connector.value.custom_header_name
      custom_header_value   = splunk_connector.value.custom_header_value
      tls_hostname          = splunk_connector.value.tls_hostname
      ca_cert               = splunk_connector.value.ca_cert
      client_cert           = splunk_connector.value.client_cert
      client_key            = splunk_connector.value.client_key
    }
  }

  dynamic "azure_connector" {
    for_each = var.azure_connector != null ? [var.azure_connector] : []
    content {
      display_name   = azure_connector.value.display_name
      account_name   = azure_connector.value.account_name
      container_name = azure_connector.value.container_name
      access_key     = azure_connector.value.access_key
      path           = azure_connector.value.path
    }
  }

  dynamic "https_connector" {
    for_each = var.https_connector != null ? [var.https_connector] : []
    content {
      display_name        = https_connector.value.display_name
      endpoint            = https_connector.value.endpoint
      authentication_type = https_connector.value.authentication_type
      content_type        = https_connector.value.content_type
      custom_header_name  = https_connector.value.custom_header_name
      custom_header_value = https_connector.value.custom_header_value
      user_name           = https_connector.value.user_name
      password            = https_connector.value.password
      compress_logs       = https_connector.value.compress_logs
      tls_hostname        = https_connector.value.tls_hostname
      ca_cert             = https_connector.value.ca_cert
      client_cert         = https_connector.value.client_cert
      client_key          = https_connector.value.client_key
    }
  }

  dynamic "elasticsearch_connector" {
    for_each = var.elasticsearch_connector != null ? [var.elasticsearch_connector] : []
    content {
      display_name        = elasticsearch_connector.value.display_name
      endpoint            = elasticsearch_connector.value.endpoint
      user_name           = elasticsearch_connector.value.user_name
      password            = elasticsearch_connector.value.password
      index_name          = elasticsearch_connector.value.index_name
      content_type        = elasticsearch_connector.value.content_type
      custom_header_name  = elasticsearch_connector.value.custom_header_name
      custom_header_value = elasticsearch_connector.value.custom_header_value
      tls_hostname        = elasticsearch_connector.value.tls_hostname
      ca_cert             = elasticsearch_connector.value.ca_cert
      client_cert         = elasticsearch_connector.value.client_cert
      client_key          = elasticsearch_connector.value.client_key
    }
  }

  dynamic "loggly_connector" {
    for_each = var.loggly_connector != null ? [var.loggly_connector] : []
    content {
      display_name        = loggly_connector.value.display_name
      endpoint            = loggly_connector.value.endpoint
      auth_token          = loggly_connector.value.auth_token
      tags                = loggly_connector.value.tags
      content_type        = loggly_connector.value.content_type
      custom_header_name  = loggly_connector.value.custom_header_name
      custom_header_value = loggly_connector.value.custom_header_value
    }
  }

  dynamic "new_relic_connector" {
    for_each = var.new_relic_connector != null ? [var.new_relic_connector] : []
    content {
      display_name        = new_relic_connector.value.display_name
      endpoint            = new_relic_connector.value.endpoint
      auth_token          = new_relic_connector.value.auth_token
      content_type        = new_relic_connector.value.content_type
      custom_header_name  = new_relic_connector.value.custom_header_name
      custom_header_value = new_relic_connector.value.custom_header_value
    }
  }

  dynamic "s3_compatible_connector" {
    for_each = var.s3_compatible_connector != null ? [var.s3_compatible_connector] : []
    content {
      display_name      = s3_compatible_connector.value.display_name
      endpoint          = s3_compatible_connector.value.endpoint
      bucket            = s3_compatible_connector.value.bucket
      region            = s3_compatible_connector.value.region
      access_key        = s3_compatible_connector.value.access_key
      secret_access_key = s3_compatible_connector.value.secret_access_key
      path              = s3_compatible_connector.value.path
    }
  }

  dynamic "sumologic_connector" {
    for_each = var.sumologic_connector != null ? [var.sumologic_connector] : []
    content {
      display_name        = sumologic_connector.value.display_name
      endpoint            = sumologic_connector.value.endpoint
      collector_code      = sumologic_connector.value.collector_code
      content_type        = sumologic_connector.value.content_type
      compress_logs       = sumologic_connector.value.compress_logs
      custom_header_name  = sumologic_connector.value.custom_header_name
      custom_header_value = sumologic_connector.value.custom_header_value
    }
  }

  dynamic "trafficpeak_connector" {
    for_each = var.trafficpeak_connector != null ? [var.trafficpeak_connector] : []
    content {
      display_name        = trafficpeak_connector.value.display_name
      endpoint            = trafficpeak_connector.value.endpoint
      authentication_type = trafficpeak_connector.value.authentication_type
      content_type        = trafficpeak_connector.value.content_type
      user_name           = trafficpeak_connector.value.user_name
      password            = trafficpeak_connector.value.password
      custom_header_name  = trafficpeak_connector.value.custom_header_name
      custom_header_value = trafficpeak_connector.value.custom_header_value
      compress_logs       = trafficpeak_connector.value.compress_logs
    }
  }

  dynamic "dynatrace_connector" {
    for_each = var.dynatrace_connector != null ? [var.dynatrace_connector] : []
    content {
      display_name        = dynatrace_connector.value.display_name
      endpoint            = dynatrace_connector.value.endpoint
      api_token           = dynatrace_connector.value.api_token
      custom_header_name  = dynatrace_connector.value.custom_header_name
      custom_header_value = dynatrace_connector.value.custom_header_value
    }
  }

  dynamic "gcs_connector" {
    for_each = var.gcs_connector != null ? [var.gcs_connector] : []
    content {
      display_name         = gcs_connector.value.display_name
      bucket               = gcs_connector.value.bucket
      private_key          = gcs_connector.value.private_key
      project_id           = gcs_connector.value.project_id
      service_account_name = gcs_connector.value.service_account_name
      path                 = gcs_connector.value.path
    }
  }

  dynamic "oracle_connector" {
    for_each = var.oracle_connector != null ? [var.oracle_connector] : []
    content {
      display_name      = oracle_connector.value.display_name
      bucket            = oracle_connector.value.bucket
      region            = oracle_connector.value.region
      namespace         = oracle_connector.value.namespace
      path              = oracle_connector.value.path
      access_key        = oracle_connector.value.access_key
      secret_access_key = oracle_connector.value.secret_access_key
    }
  }

  lifecycle {
    precondition {
      condition = (
        var.s3_connector != null ||
        var.datadog_connector != null ||
        var.splunk_connector != null ||
        var.azure_connector != null ||
        var.https_connector != null ||
        var.elasticsearch_connector != null ||
        var.loggly_connector != null ||
        var.new_relic_connector != null ||
        var.s3_compatible_connector != null ||
        var.sumologic_connector != null ||
        var.trafficpeak_connector != null ||
        var.dynatrace_connector != null ||
        var.gcs_connector != null ||
        var.oracle_connector != null
      )
      error_message = "At least one connector must be specified."
    }
  }
}