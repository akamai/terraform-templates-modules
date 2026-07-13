data "akamai_contract" "contract" {
  group_name = var.group_name
}

module "delivery" {
  source = "../../delivery"
  contract_id = trimprefix(data.akamai_contract.contract.id, "ctr_")
  group_id = trimprefix(data.akamai_contract.contract.group_id, "grp_")
  hostnames = ["${MATRIX_NAME}.terra.rafa.cr"]
  name = "${MATRIX_NAME}.terra.rafa.cr"
  cpcode_name = "${MATRIX_NAME}.terra.rafa.cr"
  default_origin = "flexibleorigin.rafa.cr"
  additional_origins = null
  notification_emails = ["test@akamai.com"]
  version_notes = "GitHub Actions test"
  certificate_id = null
  peer_reviewed_by = "test@na.com"
  customer_email = "test@akamai.com"
  unit_tested = true
  ticket_id = "some-ticket-id"
  noncompliance_reason = ["NONE"]
  other_noncompliance_reason = "test"
  td_region = "CH2"
  ip_behavior = "IPV6_COMPLIANCE"
  sure_route_test_object = "/terraform/srto.html"
  activation_notes = "GitHub Actions test"
  activation_to_staging_exists = false
  activation_to_production_exists = false
  etls = true
  secure_by_default = true
  product_id = "Fresca"
  activate_to_staging = true
  activate_to_production = false
}