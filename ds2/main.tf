/**
 * # Module: DataStream 2 (DS-managed / Decoupled)
 *
 * This module provisions a DataStream 2 (DS2) configuration using the decoupled 
 * workflow introduced in Milestone-1. It allows log collection without requiring 
 * any DataStream behavior in the Property Manager.
 */

locals {
  final_dataset_fields = distinct(concat(
    var.dataset_fields_ids,
    var.enable_midgress ? [2051] : []
  ))
}

resource "akamai_cp_code" "this" {
  name        = replace(coalesce(var.cpcode_name, var.name), "/[^a-zA-Z0-9-.]/", "-")
  contract_id = var.contract_id
  group_id    = var.group_id
  product_id  = "prd_${var.product_id}"
}

resource "akamai_datastream" "this" {
  stream_name = var.name
  contract_id = var.contract_id
  group_id    = var.group_id
  active      = var.activate_stream

  properties     = var.property_ids
  dataset_fields = local.final_dataset_fields

  delivery_configuration {
    format = var.log_format
    frequency {
      interval_in_secs = 60
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
      display_name = datadog_connector.value.display_name
      endpoint     = datadog_connector.value.endpoint
      auth_token   = datadog_connector.value.auth_token
      service      = datadog_connector.value.service
      source       = datadog_connector.value.source
      tags         = datadog_connector.value.tags
    }
  }

  dynamic "splunk_connector" {
    for_each = var.splunk_connector != null ? [var.splunk_connector] : []
    content {
      display_name          = splunk_connector.value.display_name
      endpoint              = splunk_connector.value.endpoint
      event_collector_token = splunk_connector.value.event_collector_token
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

  depends_on = [akamai_cp_code.this]
}