output "dns_challenges_details" {
  value = join("\n", [
    for challenge in akamai_cps_dv_enrollment.this.dns_challenges :
    format("domain: %s\ncname : %s\ntarget: %s\n", challenge.domain, challenge.full_path, challenge.response_body)
  ])
}

output "http_challenges_details" {
  value = join("\n", [
    for challenge in akamai_cps_dv_enrollment.this.http_challenges :
    format("domain: %s\ncname : %s\ntarget: %s\n", challenge.domain, challenge.full_path, challenge.response_body)
  ])
}