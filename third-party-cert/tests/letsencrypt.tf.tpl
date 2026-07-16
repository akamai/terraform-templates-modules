locals {

  # issuer_pem contains intermediates + root; strip the last cert (root) for the trust chain
  issuer_certs_rsa             = regexall("-----BEGIN CERTIFICATE-----[\\s\\S]*?-----END CERTIFICATE-----", acme_certificate.certificate_rsa.issuer_pem)
  trust_chain_without_root_rsa = join("\n", slice(local.issuer_certs_rsa, 0, length(local.issuer_certs_rsa) - 1))

  issuer_certs_ecdsa             = regexall("-----BEGIN CERTIFICATE-----[\\s\\S]*?-----END CERTIFICATE-----", acme_certificate.certificate_ecdsa.issuer_pem)
  trust_chain_without_root_ecdsa = join("\n", slice(local.issuer_certs_ecdsa, 0, length(local.issuer_certs_ecdsa) - 1))
}


resource "tls_private_key" "reg_private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.reg_private_key.private_key_pem
  email_address   = var.admin_contact.email
}

resource "acme_certificate" "certificate_rsa" {
  account_key_pem         = acme_registration.reg.account_key_pem
  certificate_request_pem = data.akamai_cps_csr.this.csr_rsa

  dns_challenge {
    provider = "edgedns"
    config = {
      AKAMAI_HOST          = "${AKAMAI_HOST_EDNS}"
      AKAMAI_CLIENT_TOKEN  = "${AKAMAI_CLIENT_TOKEN_EDNS}" 
      AKAMAI_CLIENT_SECRET = "${AKAMAI_CLIENT_SECRET_EDNS}"
      AKAMAI_ACCESS_TOKEN  = "${AKAMAI_ACCESS_TOKEN_EDNS}"
    }
  }

}


resource "acme_certificate" "certificate_ecdsa" {
  account_key_pem         = acme_registration.reg.account_key_pem
  certificate_request_pem = data.akamai_cps_csr.this.csr_ecdsa

  dns_challenge {
    provider = "edgedns"
    config = {
      AKAMAI_HOST          = "${AKAMAI_HOST_EDNS}"
      AKAMAI_CLIENT_TOKEN  = "${AKAMAI_CLIENT_TOKEN_EDNS}" 
      AKAMAI_CLIENT_SECRET = "${AKAMAI_CLIENT_SECRET_EDNS}"
      AKAMAI_ACCESS_TOKEN  = "${AKAMAI_ACCESS_TOKEN_EDNS}"
    }
  }

}

resource "local_file" "rsa_pem" {
  filename = "rsa_certificate.pem" 
  content  = acme_certificate.certificate_rsa.certificate_pem
}

resource "local_file" "rsa_chain_pem" {
  filename = "rsa_certificate_ca.pem"
  content  = local.trust_chain_without_root_rsa
}

  resource "local_file" "ecdsa_pem" {
  filename = "ecdsa_certificate.pem"
  content  = acme_certificate.certificate_ecdsa.certificate_pem
}


resource "local_file" "ecdsa_chain_pem" {
  filename = "ecdsa_certificate_ca.pem"
  content  = local.trust_chain_without_root_ecdsa
}