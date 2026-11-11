/**
 * # Onboarding: Application Security Configuration for Client Lists
 *
 * Create the IP block, IP block exceptions, GEO block, ASN block, security bypass, rate control bypass, and
 * pragma bypass lists for an Application Security Configuration.
 *
 * Use client_list_entries to populate each list. Entries can be plain string values or objects with a value
 * and optional description and tags. For example:
 *
 * ```hcl
 * client_list_entries = {
 *   ipblock = [{
 *     value       = "203.0.113.10"
 *     description = "Trusted office address"
 *     tags        = ["office"]
 *   }]
 *   geoblock = ["US", "CA"]
 * }
 * ```
 *
 * Set activation_networks to STAGING and/or PRODUCTION to activate all seven lists on those networks. The
 * default is no activation; removing a network from the set deactivates the lists there.
 *
 * Read on to find out which resources are provisioned as part of this
 * process, and how to customize!
 *
 */

resource "akamai_clientlist_list" "client-lists-ipblock" {
  name        = "${var.client_lists_prefix}-IP Block List"
  type        = "IP"
  notes       = "IP Block List for ${var.config_name}"
  tags        = []
  contract_id = var.contract_id
  group_id    = var.group_id

  dynamic "items" {
    for_each = var.client_list_entries.ipblock
    content {
      value       = try(items.value.value, items.value)
      description = try(items.value.description, null)
      tags        = try(items.value.tags, null)
    }
  }
}

resource "akamai_clientlist_list" "client-lists-ipblock-list-exceptions" {
  name        = "${var.client_lists_prefix}-IP Block List Exceptions"
  type        = "IP"
  notes       = "IP Block List Exceptions for ${var.config_name}"
  tags        = []
  contract_id = var.contract_id
  group_id    = var.group_id

  dynamic "items" {
    for_each = var.client_list_entries.ipblock_exceptions
    content {
      value       = try(items.value.value, items.value)
      description = try(items.value.description, null)
      tags        = try(items.value.tags, null)
    }
  }
}

resource "akamai_clientlist_list" "client-lists-geoblock-list" {
  name        = "${var.client_lists_prefix}-GEO Block List"
  type        = "GEO"
  notes       = "GEO Block List for ${var.config_name}"
  tags        = []
  contract_id = var.contract_id
  group_id    = var.group_id

  dynamic "items" {
    for_each = var.client_list_entries.geoblock
    content {
      value       = try(items.value.value, items.value)
      description = try(items.value.description, null)
      tags        = try(items.value.tags, null)
    }
  }
}

resource "akamai_clientlist_list" "client-lists-asnblock-list" {
  name        = "${var.client_lists_prefix}-ASN Block List"
  type        = "ASN"
  notes       = "ASN Block List for ${var.config_name}"
  tags        = []
  contract_id = var.contract_id
  group_id    = var.group_id

  dynamic "items" {
    for_each = var.client_list_entries.asnblock
    content {
      value       = try(items.value.value, items.value)
      description = try(items.value.description, null)
      tags        = try(items.value.tags, null)
    }
  }
}

resource "akamai_clientlist_list" "client-lists-securitybypass-list" {
  name        = "${var.client_lists_prefix}-Security Bypass List"
  type        = "IP"
  notes       = "Security Bypass List for ${var.config_name}"
  tags        = []
  contract_id = var.contract_id
  group_id    = var.group_id

  dynamic "items" {
    for_each = var.client_list_entries.securitybypass
    content {
      value       = try(items.value.value, items.value)
      description = try(items.value.description, null)
      tags        = try(items.value.tags, null)
    }
  }
}

resource "akamai_clientlist_list" "client-lists-rcbypass-list" {
  name        = "${var.client_lists_prefix}-Rate Control Bypass List"
  type        = "IP"
  notes       = "Rate Control Bypass List for ${var.config_name}"
  tags        = []
  contract_id = var.contract_id
  group_id    = var.group_id

  dynamic "items" {
    for_each = var.client_list_entries.rcbypass
    content {
      value       = try(items.value.value, items.value)
      description = try(items.value.description, null)
      tags        = try(items.value.tags, null)
    }
  }
}

resource "akamai_clientlist_list" "client-lists-pragmabypass-list" {
  name        = "${var.client_lists_prefix}-Pragma Bypass List"
  type        = "IP"
  notes       = "Pragma Bypass List for ${var.config_name}"
  tags        = []
  contract_id = var.contract_id
  group_id    = var.group_id

  dynamic "items" {
    for_each = var.client_list_entries.pragmabypass
    content {
      value       = try(items.value.value, items.value)
      description = try(items.value.description, null)
      tags        = try(items.value.tags, null)
    }
  }
}

locals {
  client_lists = {
    ipblock = {
      id = akamai_clientlist_list.client-lists-ipblock.id
    }
    ipblock_exceptions = {
      id = akamai_clientlist_list.client-lists-ipblock-list-exceptions.id
    }
    geoblock = {
      id = akamai_clientlist_list.client-lists-geoblock-list.id
    }
    asnblock = {
      id = akamai_clientlist_list.client-lists-asnblock-list.id
    }
    securitybypass = {
      id = akamai_clientlist_list.client-lists-securitybypass-list.id
    }
    rcbypass = {
      id = akamai_clientlist_list.client-lists-rcbypass-list.id
    }
    pragmabypass = {
      id = akamai_clientlist_list.client-lists-pragmabypass-list.id
    }
  }

  client_list_activations = {
    for activation in setproduct(keys(local.client_lists), var.activation_networks) :
    "${activation[0]}-${lower(activation[1])}" => {
      list_id = local.client_lists[activation[0]].id
      network = activation[1]
    }
  }
}
