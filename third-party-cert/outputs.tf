output "csr_ecdsa" {
  value     = data.akamai_cps_csr.this.csr_ecdsa
  sensitive = true
}

output "csr_rsa" {
  value     = data.akamai_cps_csr.this.csr_rsa
  sensitive = true
}
