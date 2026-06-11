/**
 * # Onboarding: new-property for ION Premier
 *
 * The use case for this module is to quickly create a new configuration
 * serving a set of hostnames.
 *
 * Read on to find out which resources are provisioned as part of this
 * process, and how to customize!
 */

locals {
  ehn_domain = coalesce(
    var.ehn_domain,
    (var.etls == true) ? "edgekey.net" : "edgesuite.net"
  )


  edge_hostnames = (var.etls && var.secure_by_default) ? [] : var.hostnames

  ehn_certificate = (var.etls == true && var.secure_by_default == false) ? var.certificate_id : null
}

module "rules" {
  source                 = "./rules"
  product_id             = var.product_id
  etls                   = var.etls
  default_origin         = var.default_origin
  cpcode_id              = tonumber(trimprefix(akamai_cp_code.this.id, "cpc_"))
  cpcode_name            = var.cpcode_name
  sure_route_test_object = var.sure_route_test_object
  td_region              = var.td_region
  enable_mPulse          = var.enable_mPulse
  additional_origins     = var.additional_origins
}

resource "akamai_cp_code" "this" {
  name        = replace(coalesce(var.cpcode_name, var.name), "/[^a-zA-Z0-9-.]/", "-")
  contract_id = var.contract_id
  group_id    = var.group_id
  product_id  = "prd_${var.product_id}"
}

resource "akamai_edge_hostname" "edge_hostname" {
  for_each      = toset(local.edge_hostnames)
  product_id    = "prd_${var.product_id}"
  contract_id   = var.contract_id
  group_id      = var.group_id
  edge_hostname = "${each.key}.${local.ehn_domain}"
  certificate   = local.ehn_certificate
  ip_behavior   = var.ip_behavior
}

resource "akamai_property" "this" {
  name          = var.name
  product_id    = "prd_${var.product_id}"
  contract_id   = var.contract_id
  group_id      = var.group_id
  version_notes = var.version_notes

  dynamic "hostnames" {
    for_each = var.hostnames
    content {
      cname_from             = hostnames.value
      cname_to               = "${hostnames.value}.${local.ehn_domain}"
      cert_provisioning_type = var.secure_by_default ? "DEFAULT" : "CPS_MANAGED"
    }
  }

  rule_format = module.rules.rule_format
  rules       = module.rules.rules

  depends_on = [akamai_edge_hostname.edge_hostname, akamai_cp_code.this]

  lifecycle {
    ignore_changes = [version_notes]
  }

}
# akamai_property_domainownership_late_validation resource is used to verify the validation state of your hostnames and activate your property on a network.
resource "akamai_property_domainownership_late_validation" "this" {
  count = var.enable_domain_validation ? 1 : 0
  contract_id       = var.contract_id
  group_id          = var.group_id
  property_id       = akamai_property.this.id
  version           = akamai_property.this.latest_version
  validation_method = "DNS_CNAME"

  timeouts {
    create = "5m"
  }
}

resource "akamai_property_activation" "staging" {
  count                          = var.activate_to_staging || var.activation_to_staging_exists ? 1 : 0
  network                        = "STAGING"
  property_id                    = akamai_property.this.id
  version                        = var.activate_to_staging ? akamai_property.this.latest_version : akamai_property.this.staging_version
  note                           = var.activation_notes
  contact                        = var.notification_emails
  auto_acknowledge_rule_warnings = true
  depends_on                     = [akamai_property_domainownership_late_validation.this]

  lifecycle {
    ignore_changes = [note]
  }
}

resource "akamai_property_activation" "production" {
  count                          = var.activate_to_production || var.activation_to_production_exists ? 1 : 0
  network                        = "PRODUCTION"
  property_id                    = akamai_property.this.id
  version                        = var.activate_to_production ? akamai_property.this.latest_version : akamai_property.this.production_version
  note                           = var.activation_notes
  contact                        = var.notification_emails
  auto_acknowledge_rule_warnings = true
  depends_on                     = [akamai_property_domainownership_late_validation.this]

  lifecycle {
    ignore_changes = [note]
  }

  dynamic "compliance_record" {
    for_each = var.noncompliance_reason

    content {
      dynamic "noncompliance_reason_none" {
        for_each = compliance_record.value == "NONE" ? [1] : []
        content {
          ticket_id        = var.ticket_id
          peer_reviewed_by = var.peer_reviewed_by
          customer_email   = var.customer_email
          unit_tested      = var.unit_tested
        }
      }
      dynamic "noncompliance_reason_other" {
        for_each = compliance_record.value == "OTHER" ? [1] : []
        content {
          ticket_id                  = var.ticket_id
          other_noncompliance_reason = var.other_noncompliance_reason
        }
      }

      dynamic "noncompliance_reason_no_production_traffic" {
        for_each = compliance_record.value == "NO_PRODUCTION_TRAFFIC" ? [1] : []
        content {
          ticket_id = var.ticket_id
        }
      }

      dynamic "noncompliance_reason_emergency" {
        for_each = compliance_record.value == "EMERGENCY" ? [1] : []
        content {
          ticket_id = var.ticket_id
        }
      }
    }
  }
}

