/**
 * # Akamai Domain Ownership Management (DOM)
 *
 * This directory contains the resource for Domain entry creation and Validation
 *
 */

resource "akamai_property_domainownership_domains" "domains" {
  for_each = {
    for entry in var.domain_validation_entries :
    entry.domain_name => entry
  }

  domains = [
    {
      domain_name      = upper(each.value.validation_scope) == "WILDCARD" ? trimprefix(each.value.domain_name, "*.") : each.value.domain_name
      validation_scope = upper(each.value.validation_scope)
    }
  ]
}

resource "akamai_property_domainownership_validation" "validation" {
  for_each = var.enable_validation ? {
    for entry in var.domain_validation_entries :
    entry.domain_name => entry
  } : {}

  domains = [
    {
      domain_name       = upper(each.value.validation_scope) == "WILDCARD" ? trimprefix(each.value.domain_name, "*.") : each.value.domain_name
      validation_scope  = upper(each.value.validation_scope)
      validation_method = each.value.validation_method
    }
  ]
}

data "akamai_property_domainownership_search_domains" "search" {
  count = length(var.domain_search_entries) > 0 ? 1 : 0

  domains = [
    for entry in var.domain_search_entries : {
      domain_name      = entry.domain_name
      validation_scope = upper(entry.validation_scope)
    }
  ]
}