edgerc_section = "default"
contract_id = "ctr_1-5C13O2"
group_id = "grp_315874"
hostnames = ["${MATRIX_NAME}.terra.rafa.cr"]
name = "${MATRIX_NAME}.terra.rafa.cr"
cpcode_name = "${MATRIX_NAME}.terra.rafa.cr"
default_origin = "flexibleorigin.rafa.cr"
forward_host_header = "flexibleorigin.rafa.cr"
notification_emails = ["test@akamai.com"]
version_notes = "GitHub Actions test"
certificate_id = 30192
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
etls=${ETLS}
secure_by_default=${SECURE_BY_DEFAULT}
product_id="${PRODUCT_ID}"
activate_to_staging=${ACTIVATE_TO_STAGING}
activate_to_production=${ACTIVATE_TO_PRODUCTION}
additional_origins = {
  "api_origin" = {
    origin_name         = "api-origin.rafa.cr"
    forward_host_header = "REQUEST_HOST_HEADER"
    hostname_match      = ["api.rafa.cr"]
    path_match          = ["/api/*"]
  },
  "images_origin" = {
    origin_name         = "images-origin.rafa.cr"
    forward_host_header = "ORIGIN_HOSTNAME"
    hostname_match      = ["images.rafa.cr"]
    path_match          = ["/images/*"]
  }
    "custom" = {
    origin_name         = "custom-origin.rafa.cr"
    forward_host_header = "flexibleorigin.rafa.cr"
    hostname_match      = ["custom.rafa.cr"]
    path_match          = ["/custom/*"]
  }
}