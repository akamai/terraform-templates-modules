edgerc_section = "default"

contract_id = "ctr_1-1NC95D"

# Enrollment details
common_name                 = "a${MATRIX_NAME}.rafa.cr"
allow_duplicate_common_name = false
sans                        = ["a${MATRIX_NAME}1.rafa.cr", "a${MATRIX_NAME}2.rafa.cr"]
secure_network              = "enhanced-tls"
sni_only                    = false
acknowledge_pre_verification_warnings = true
auto_approve_warnings       = []

# Admin contact
admin_contact = {
  first_name       = "GSS DevOps"
  last_name        = "Terraform"
  organization     = ""
  email            = "gssdevps@akamai.com"
  phone            = "8888888888"
  address_line_one = "" 
  address_line_two = ""
  city             = ""
  region           = ""
  postal_code      = ""
  country_code     = ""
}

# CSR details
csr = {
  country_code        = "CR"
  city                = "Atenas"
  organization        = "GSS DevOps Terraform"
  organizational_unit = ""
  state               = "Alajuela"
}

# Network config
network_configuration = {
  disallowed_tls_versions = ["TLSv1", "TLSv1_1"]
  clone_dns_names         = false
  geography               = "core"
  must_have_ciphers       = "ak-akamai-2020q1"
  ocsp_stapling           = "on"
  preferred_ciphers       = "ak-akamai-2020q1"
  quic_enabled            = false
}

signature_algorithm = ""

# Tech contact
tech_contact = {
  first_name       = "GSS DevOps"
  last_name        = "GSS DevOps Terraform"
  organization     = ""
  email            = "gssdevops@akamai.com"
  phone            = "8888888888"
  address_line_one = ""
  city             = ""
  region           = ""
  postal_code      = ""
  country_code     = ""
}

# Organization
organization = {
   name             = "Akamai"
  phone            = "080 4600 1000"
  address_line_one = "EGL"
  address_line_two = "Domlur"
  city             = "Bengaluru"
  region           = "Karnataka"
  postal_code      = "560071"
  country_code     = "IN"
}

certificate_chain_type = "default"

#To test and view certificates on the staging network before deploying to production, set the change_management argument to true in this resource.

change_management = true


# Upload Certificate

# ECDSA Certificate files (If there is no certificate to upload, leave the fields blank while maintaining the same format shown below)
certificate_ecdsa_pem = ""

trust_chain_ecdsa_pem = ""

# RSA Certificate files, Provide the signed RSA certificate file name here. You may rename the files as shown below or use the same names as downloaded

certificate_rsa_pem = "" 

trust_chain_rsa_pem = ""

# Whether to acknowledge post-verification warnings defined in auto_approve_warnings. Provide true to acknowledge them.

acknowledge_post_verification_warnings = true

# Whether to acknowledge change management. Provide true to acknowledge that testing on staging is complete and to deploy the certificate to production.
#Note: Use only if the change_management argument is set to true

acknowledge_change_management          = true

# Whether to wait for a certificate to be deployed. Provide true to wait for its deployment.

wait_for_deployment                    = true