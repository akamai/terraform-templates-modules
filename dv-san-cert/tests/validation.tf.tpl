resource "akamai_dns_record" "enrollment_validation" {
  for_each   = akamai_cps_dv_enrollment.this.dns_challenges
  name       = each.value.full_path
  zone       = join(".", slice(split(".", each.value.domain), length(split(".", each.value.domain)) - 2, length(split(".", each.value.domain))))
  recordtype = "TXT"
  ttl        = 120
  target     = [each.value.response_body]
}

resource "akamai_cps_dv_validation" "my-dv-validation" {
  for_each   = akamai_cps_dv_enrollment.this
  enrollment_id                          = each.value.id
  sans                                   = each.value.sans
  acknowledge_post_verification_warnings = true
  timeouts {
    default = "1h"
  }
  depends_on = [akamai_dns_record.enrollment_validation]
}