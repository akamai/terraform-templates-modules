<!-- BEGIN_TF_DOCS -->

# CPS Third-Party Enrollment

Akamai CPS Third-Party Certificate Module

This Terraform configuration manages Akamai Certificate Provisioning System (CPS) third-party certificate enrollments. Handles both enrollment (creating a new certificate request) and certificate upload.
It supports:

## Two-phase workflow in Terraform when dealing with Third-Party signed certificates:

## Phase 1 → Terraform creates the enrollment + CSR.
- Creating an enrollment with certificate details (SANs, contacts, CSR, network config, etc.)
- You take the CSR, submit to a CA, and later come back with the signed cert.

## Phase 2 → Terraform uploads the signed certificate to Akamai.
- Uploading RSA or ECDSA certificates and their trust chains in pem format

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 admin_contact  = <object({
    first_name       = string
    last_name        = string
    organization     = string
    email            = string
    phone            = string
    address_line_one = string
    address_line_two = string
    city             = string
    region           = string
    postal_code      = string
    country_code     = string
  })>
  	 certificate_ecdsa_pem  = <string>
  	 certificate_rsa_pem  = <string>
  	 common_name  = <string>
  	 contract_id  = <string>
  	 csr  = <object({
    country_code        = string
    city                = string
    organization        = string
    organizational_unit = string
    state               = string
  })>
  	 network_configuration  = <object({
    disallowed_tls_versions = list(string)
    clone_dns_names         = bool
    geography               = string
    must_have_ciphers       = string
    ocsp_stapling           = string
    preferred_ciphers       = string
    quic_enabled            = bool
  })>
  	 organization  = <object({
    name             = string
    phone            = string
    address_line_one = string
    address_line_two = string
    city             = string
    region           = string
    postal_code      = string
    country_code     = string
  })>
  	 sans  = <list(string)>
  	 tech_contact  = <object({
    first_name       = string
    last_name        = string
    organization     = string
    email            = string
    phone            = string
    address_line_one = string
    city             = string
    region           = string
    postal_code      = string
    country_code     = string
  })>
  	 trust_chain_ecdsa_pem  = <string>
  	 trust_chain_rsa_pem  = <string>
  
	 # Optional variables
  	 acknowledge_change_management  = <bool> | default: false
  	 acknowledge_post_verification_warnings  = <bool> | default: false
  	 acknowledge_pre_verification_warnings  = <bool> | default: false
  	 allow_duplicate_common_name  = <bool> | default: false
  	 auto_approve_warnings  = <list(string)> | default: []
  	 certificate_chain_type  = <string> | default: "default"
  	 change_management  = <bool> | default: false
  	 secure_network  = <string> | default: "standard-tls"
  	 signature_algorithm  = <string> | default: ""
  	 sni_only  = <bool> | default: true
  	 wait_for_deployment  = <bool> | default: false
}
 ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | ~> 9.0 |

## Resources

| Name | Type |
|------|------|
| [akamai_cps_third_party_enrollment.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/cps_third_party_enrollment) | resource |
| [akamai_cps_upload_certificate.upload_cert](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/cps_upload_certificate) | resource |
| [akamai_cps_csr.this](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/cps_csr) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_contact"></a> [admin\_contact](#input\_admin\_contact) | Admin contact details | <pre>object({<br/>    first_name       = string<br/>    last_name        = string<br/>    organization     = string<br/>    email            = string<br/>    phone            = string<br/>    address_line_one = string<br/>    address_line_two = string<br/>    city             = string<br/>    region           = string<br/>    postal_code      = string<br/>    country_code     = string<br/>  })</pre> | n/a | yes |
| <a name="input_certificate_ecdsa_pem"></a> [certificate\_ecdsa\_pem](#input\_certificate\_ecdsa\_pem) | ECDSA certificate PEM string | `string` | n/a | yes |
| <a name="input_certificate_rsa_pem"></a> [certificate\_rsa\_pem](#input\_certificate\_rsa\_pem) | RSA certificate PEM string | `string` | n/a | yes |
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Primary certificate common name | `string` | n/a | yes |
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Akamai contract ID | `string` | n/a | yes |
| <a name="input_csr"></a> [csr](#input\_csr) | CSR details | <pre>object({<br/>    country_code        = string<br/>    city                = string<br/>    organization        = string<br/>    organizational_unit = string<br/>    state               = string<br/>  })</pre> | n/a | yes |
| <a name="input_network_configuration"></a> [network\_configuration](#input\_network\_configuration) | Network configuration for enrollment | <pre>object({<br/>    disallowed_tls_versions = list(string)<br/>    clone_dns_names         = bool<br/>    geography               = string<br/>    must_have_ciphers       = string<br/>    ocsp_stapling           = string<br/>    preferred_ciphers       = string<br/>    quic_enabled            = bool<br/>  })</pre> | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization details | <pre>object({<br/>    name             = string<br/>    phone            = string<br/>    address_line_one = string<br/>    address_line_two = string<br/>    city             = string<br/>    region           = string<br/>    postal_code      = string<br/>    country_code     = string<br/>  })</pre> | n/a | yes |
| <a name="input_sans"></a> [sans](#input\_sans) | Subject Alternative Names for the certificate | `list(string)` | n/a | yes |
| <a name="input_tech_contact"></a> [tech\_contact](#input\_tech\_contact) | Technical contact details | <pre>object({<br/>    first_name       = string<br/>    last_name        = string<br/>    organization     = string<br/>    email            = string<br/>    phone            = string<br/>    address_line_one = string<br/>    city             = string<br/>    region           = string<br/>    postal_code      = string<br/>    country_code     = string<br/>  })</pre> | n/a | yes |
| <a name="input_trust_chain_ecdsa_pem"></a> [trust\_chain\_ecdsa\_pem](#input\_trust\_chain\_ecdsa\_pem) | ECDSA trust chain PEM string | `string` | n/a | yes |
| <a name="input_trust_chain_rsa_pem"></a> [trust\_chain\_rsa\_pem](#input\_trust\_chain\_rsa\_pem) | RSA trust chain PEM string | `string` | n/a | yes |
| <a name="input_acknowledge_change_management"></a> [acknowledge\_change\_management](#input\_acknowledge\_change\_management) | Acknowledge change management for certificate upload | `bool` | `false` | no |
| <a name="input_acknowledge_post_verification_warnings"></a> [acknowledge\_post\_verification\_warnings](#input\_acknowledge\_post\_verification\_warnings) | Acknowledge post-verification warnings | `bool` | `false` | no |
| <a name="input_acknowledge_pre_verification_warnings"></a> [acknowledge\_pre\_verification\_warnings](#input\_acknowledge\_pre\_verification\_warnings) | Acknowledge pre-verification warnings | `bool` | `false` | no |
| <a name="input_allow_duplicate_common_name"></a> [allow\_duplicate\_common\_name](#input\_allow\_duplicate\_common\_name) | Whether duplicate common names are allowed | `bool` | `false` | no |
| <a name="input_auto_approve_warnings"></a> [auto\_approve\_warnings](#input\_auto\_approve\_warnings) | List of warnings to auto-approve | `list(string)` | `[]` | no |
| <a name="input_certificate_chain_type"></a> [certificate\_chain\_type](#input\_certificate\_chain\_type) | Certificate chain type (default or test). | `string` | `"default"` | no |
| <a name="input_change_management"></a> [change\_management](#input\_change\_management) | Enable/disable change management | `bool` | `false` | no |
| <a name="input_secure_network"></a> [secure\_network](#input\_secure\_network) | TLS network setting | `string` | `"standard-tls"` | no |
| <a name="input_signature_algorithm"></a> [signature\_algorithm](#input\_signature\_algorithm) | Signature algorithm for CSR | `string` | `""` | no |
| <a name="input_sni_only"></a> [sni\_only](#input\_sni\_only) | Enable SNI-only certificates | `bool` | `true` | no |
| <a name="input_wait_for_deployment"></a> [wait\_for\_deployment](#input\_wait\_for\_deployment) | Wait for deployment to complete before proceeding | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_csr_ecdsa"></a> [csr\_ecdsa](#output\_csr\_ecdsa) | n/a |
| <a name="output_csr_rsa"></a> [csr\_rsa](#output\_csr\_rsa) | n/a |
<!-- END_TF_DOCS -->