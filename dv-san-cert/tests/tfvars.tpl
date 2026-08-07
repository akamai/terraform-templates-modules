contract_id = "1-1NC95D"

common_name = "${MATRIX_NAME}.rafa.cr"

allow_duplicate_common_name = false

sans = ["${MATRIX_NAME}1.rafa.cr", "${MATRIX_NAME}2.rafa.cr"]

secure_network = "enhanced-tls"

sni_only = ${SNI}

# Whether to acknowledge post-verification warnings defined in auto_approve_warnings. Provide true to acknowledge them.

acknowledge_pre_verification_warnings = true

#customer contact details to be filled here 
admin_contact = {
  first_name       = "GSS DevOps"
  last_name        = "Terraform"
  organization     = ""
  email            = "gssdevps@test.com"
  phone            = "8888888888"
  address_line_one = "" 
  address_line_two = ""
  city             = ""
  region           = ""
  postal_code      = ""
  country_code     = ""
}

certificate_chain_type = "default"

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

signature_algorithm = "SHA-256"

#Akamai Technical Contact Information to be filled here
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