/**
 * # AMD delivery module
 *
 * Creates a CP code, an edge hostname per hostname (one of 4 selectable
 * cert/TLS modes), renders the AMD rule tree via the ./rules submodule,
 * creates the property, and (optionally) activates it to staging/production.
 */

locals {
  # Domain suffix Akamai assigns depending on edge hostname type. Secure By
  # Default uses edgekey.net for secure delivery and edgesuite.net otherwise.
  edge_hostname_domain_suffix = {
    SBD                = var.etls ? "edgekey.net" : "edgesuite.net"
    EDGESUITE          = "edgesuite.net" # Standard TLS, also known as Freeflow
    EDGEKEY            = "edgekey.net"   # Enhanced TLS, also known as ESSL
    AKAMAIZED_HOSTNAME = "akamaized.net" # Shared Cert; cname_from and cname_to are identical
  }

  # cert_provisioning_type accepted on the property's `hostnames` block.
  # EDGEKEY uses a customer-supplied CPS certificate. AKAMAIZED_HOSTNAME uses
  # the shared Akamaized certificate and must not request a DEFAULT DV
  # certificate on the property hostname; CPS_MANAGED is the API value used
  # for this shared-cert hostname mapping.
  edge_hostname_cert_provisioning_type = {
    SBD                = "DEFAULT"
    EDGESUITE          = "DEFAULT"
    EDGEKEY            = "CPS_MANAGED"
    AKAMAIZED_HOSTNAME = "CPS_MANAGED"
  }

  # Only EDGEKEY requires a CPS certificate enrollment ID.
  edge_hostname_requires_certificate = {
    SBD                = false
    EDGESUITE          = false
    EDGEKEY            = true
    AKAMAIZED_HOSTNAME = false
  }

  # AMD requires a use_cases block on the edge hostname declaring the
  # segmented media mode. Kept in sync with the rule tree's
  # segmented_media_optimization_behavior (ON_DEMAND -> VOD, LIVE -> LIVE)
  # so the two never drift apart.
  segmented_media_use_case_option = var.segmented_media_optimization_behavior == "LIVE" ? "LIVE" : "VOD"

  # For every mode except AKAMAIZED_HOSTNAME, cname_from is the customer's own
  # hostname (e.g. "dev-media.example.com") and cname_to is derived by
  # appending the mode's domain suffix. For AKAMAIZED_HOSTNAME, the customer
  # supplies just a label (e.g. "abm-template-test") and cname_from/cname_to
  # both become "<label>.akamaized.net" -- there is no separate customer
  # domain, the akamaized.net hostname *is* the hostname.
  hostnames = {
    for h in var.hostnames : h => {
      cname_from = (
        var.edge_hostname_type == "AKAMAIZED_HOSTNAME"
        ? "${h}.${local.edge_hostname_domain_suffix[var.edge_hostname_type]}"
        : h
      )
      cname_to = "${h}.${local.edge_hostname_domain_suffix[var.edge_hostname_type]}"
    }
  }

  # Secure By Default with Enhanced TLS is provisioned automatically with the
  # property. Standard TLS SBD still requires an explicit edgesuite.net EHN.
  edge_hostname_resources = var.edge_hostname_type == "SBD" && var.etls ? {} : local.hostnames
}

resource "akamai_cp_code" "this" {
  name        = coalesce(var.cpcode_name, var.name)
  contract_id = var.contract_id
  group_id    = var.group_id
  product_id  = var.product_id
}

# Auto-generated enhanced_debug key. Akamai's docs describe this as a
# "64-byte hex string", but the provider's actual validation regex is
# ^[0-9a-fA-F]{64}$ -- i.e. exactly 64 hex *characters* (32 bytes), not 128.
# byte_length = 32 produces a 64-character hex string via .hex (2 hex chars
# per byte). Only created when enable_debug is true and no caller key is
# supplied; it stays stable across applies because it is stored in state.
resource "random_id" "debug_key" {
  count       = var.enable_debug && var.debug_key == null ? 1 : 0
  byte_length = 32
}

locals {
  effective_debug_key = var.enable_debug ? coalesce(var.debug_key, try(random_id.debug_key[0].hex, null)) : null
}

resource "akamai_edge_hostname" "this" {
  for_each = local.edge_hostname_resources

  product_id  = var.product_id
  contract_id = var.contract_id
  group_id    = var.group_id
  ip_behavior = var.ip_behavior

  edge_hostname = each.value.cname_to

  certificate = local.edge_hostname_requires_certificate[var.edge_hostname_type] ? var.certificate_id : null

  # use_cases is a plain string attribute expecting a JSON-encoded list
  use_cases = jsonencode([
    {
      useCase = "Segmented_Media_Mode"
      option  = local.segmented_media_use_case_option
      type    = "GLOBAL"
    }
  ])
}

module "rules" {
  source = "./rules"

  cpcode_id   = tonumber(trimprefix(akamai_cp_code.this.id, "cpc_"))
  cpcode_name = akamai_cp_code.this.name

  etls                = var.etls
  default_origin      = var.default_origin
  additional_origins  = var.additional_origins
  forward_host_header = var.forward_host_header
  http2_enabled       = var.http2_enabled
  min_tls_version     = var.min_tls_version
  verification_mode   = var.verification_mode

  segmented_media_optimization_behavior = var.segmented_media_optimization_behavior
  origin_authentication_method          = var.origin_authentication_method
  origin_country                        = var.origin_country
  client_country                        = var.client_country

  content_catalog_size            = var.content_catalog_size
  content_type                    = var.content_type
  content_popularity_distribution = var.content_popularity_distribution
  enable_dash                     = var.enable_dash
  enable_hds                      = var.enable_hds
  enable_hls                      = var.enable_hls
  enable_smooth                   = var.enable_smooth
  segment_duration_dash           = var.segment_duration_dash
  segment_duration_hds            = var.segment_duration_hds
  segment_duration_hls            = var.segment_duration_hls
  segment_duration_smooth         = var.segment_duration_smooth

  cache_key_query_params_behavior        = var.cache_key_query_params_behavior
  enable_dynamic_throughput_optimization = var.enable_dynamic_throughput_optimization
  enable_http3                           = var.enable_http3

  enable_segmented_content_protection = var.enable_segmented_content_protection
  dash_media_encryption               = var.dash_media_encryption
  hls_media_encryption                = var.hls_media_encryption

  enable_debug = var.enable_debug
  debug_key    = local.effective_debug_key

}

resource "akamai_property" "this" {
  name          = var.name
  contract_id   = var.contract_id
  group_id      = var.group_id
  product_id    = var.product_id
  version_notes = var.version_notes

  rule_format = module.rules.rule_format
  rules       = module.rules.rules

  dynamic "hostnames" {
    for_each = local.hostnames
    content {
      cname_from             = hostnames.value.cname_from
      cname_to               = var.edge_hostname_type == "SBD" && var.etls ? hostnames.value.cname_to : akamai_edge_hostname.this[hostnames.key].edge_hostname
      cert_provisioning_type = local.edge_hostname_cert_provisioning_type[var.edge_hostname_type]
    }
  }

  depends_on = [akamai_cp_code.this, akamai_edge_hostname.this]

  lifecycle {
    ignore_changes = [version_notes]
  }
}

resource "akamai_property_activation" "staging" {
  count = var.activate_to_staging || var.activation_to_staging_exists ? 1 : 0

  property_id                    = akamai_property.this.id
  contact                        = var.activation_contacts
  version                        = var.activate_to_staging ? akamai_property.this.latest_version : akamai_property.this.staging_version
  network                        = "STAGING"
  note                           = var.activation_notes
  auto_acknowledge_rule_warnings = true

  lifecycle {
    ignore_changes = [note]
  }
}

resource "akamai_property_activation" "production" {
  count = var.activate_to_production || var.activation_to_production_exists ? 1 : 0

  property_id                    = akamai_property.this.id
  contact                        = var.activation_contacts
  version                        = var.activate_to_production ? akamai_property.this.latest_version : akamai_property.this.production_version
  network                        = "PRODUCTION"
  note                           = var.activation_notes
  auto_acknowledge_rule_warnings = true

  # var.noncompliance_reason is a list: [] skips the compliance_record block
  # entirely; a single-element list picks exactly one of the four reason
  # sub-blocks below, matching the akamai_property_activation schema.
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

  lifecycle {
    ignore_changes = [note]
  }

  depends_on = [akamai_property_activation.staging]
}
