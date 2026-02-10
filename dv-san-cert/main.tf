/**
* # Akamai DV SAN Certificate Enrollment Module
*
* This Terraform module automates the creation and management of **Akamai Certificate Provisioning System (CPS)** enrollments for **Domain Validated (DV)** certificates with **Subject Alternative Names (SANs)**.
*
* The module supports configuration of administrative and technical contacts, CSR generation, network and TLS configurations, After creation, the module automatically outputs DNS and HTTP challenge details into [dns-challenges.txt] and [http-challenges.txt]
*
* ## Prerequisites
*
* - Terraform v1.4+  
* - Akamai Terraform Provider installed  
* - Access to an Akamai account with CPS permissions  
* - `.edgerc` file configured with proper credentials
* - **Recommendation**: Use a dedicated .edgerc section per account for clean separation.
*/

resource "akamai_cps_dv_enrollment" "this" {
  common_name                           = var.common_name
  allow_duplicate_common_name           = var.allow_duplicate_common_name
  sans                                  = var.sans
  secure_network                        = var.secure_network
  sni_only                              = var.sni_only
  acknowledge_pre_verification_warnings = var.acknowledge_pre_verification_warnings

  admin_contact {
    first_name       = var.admin_contact.first_name
    last_name        = var.admin_contact.last_name
    organization     = var.admin_contact.organization
    email            = var.admin_contact.email
    phone            = var.admin_contact.phone
    address_line_one = var.admin_contact.address_line_one
    city             = var.admin_contact.city
    region           = var.admin_contact.region
    postal_code      = var.admin_contact.postal_code
    country_code     = var.admin_contact.country_code
  }

  certificate_chain_type = var.certificate_chain_type

  csr {
    country_code        = var.csr.country_code
    city                = var.csr.city
    organization        = var.csr.organization
    organizational_unit = var.csr.organizational_unit
    state               = var.csr.state
  }

  network_configuration {
    disallowed_tls_versions = var.network_configuration.disallowed_tls_versions
    clone_dns_names         = var.network_configuration.clone_dns_names
    geography               = var.network_configuration.geography
    must_have_ciphers       = var.network_configuration.must_have_ciphers
    ocsp_stapling           = var.network_configuration.ocsp_stapling
    preferred_ciphers       = var.network_configuration.preferred_ciphers
  }

  signature_algorithm = var.signature_algorithm

  tech_contact {
    first_name       = var.tech_contact.first_name
    last_name        = var.tech_contact.last_name
    organization     = var.tech_contact.organization
    email            = var.tech_contact.email
    phone            = var.tech_contact.phone
    address_line_one = var.tech_contact.address_line_one
    city             = var.tech_contact.city
    region           = var.tech_contact.region
    postal_code      = var.tech_contact.postal_code
    country_code     = var.tech_contact.country_code
  }

  organization {
    name             = var.organization.name
    phone            = var.organization.phone
    address_line_one = var.organization.address_line_one
    address_line_two = var.organization.address_line_two
    city             = var.organization.city
    region           = var.organization.region
    postal_code      = var.organization.postal_code
    country_code     = var.organization.country_code
  }

  contract_id = var.contract_id
}
