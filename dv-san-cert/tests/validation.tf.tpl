locals {
  # Keep for_each keys static at plan time; only values come from apply-time challenge data.
  validation_domains = distinct(concat([var.common_name], var.sans))
  challenge_by_domain = {
    for d in local.validation_domains :
    d => one([
      for c in akamai_cps_dv_enrollment.this.dns_challenges : c
      if lower(trimsuffix(trimspace(c.domain), ".")) == lower(trimsuffix(trimspace(d), "."))
    ])
  }
}

resource "akamai_dns_record" "enrollment_validation" {
  for_each = { for d in local.validation_domains : d => d }

  name       = local.challenge_by_domain[each.key].full_path
  zone       = join(".", slice(split(".", each.key), length(split(".", each.key)) - 2, length(split(".", each.key))))
  recordtype = "TXT"
  ttl        = 120
  target     = [local.challenge_by_domain[each.key].response_body]

  lifecycle {
    precondition {
      condition     = local.challenge_by_domain[each.key] != null
      error_message = "No CPS DNS challenge was returned for ${each.key}. Returned challenge domains: ${join(", ", [for challenge in akamai_cps_dv_enrollment.this.dns_challenges : challenge.domain])}."
    }
  }
}

resource "akamai_cps_dv_validation" "my-dv-validation" {
  enrollment_id                          = akamai_cps_dv_enrollment.this.id
  sans                                   = akamai_cps_dv_enrollment.this.sans
  acknowledge_post_verification_warnings = true
  timeouts {
    default = "1h"
  }
  depends_on = [akamai_dns_record.enrollment_validation]
}

#Used to save the enrollment id in order to fix the deletion that the prodvider does not handle gracefully
resource "local_file" "enrollment_id" {
  filename = "enrollment_id.txt"
  content  = akamai_cps_dv_enrollment.this.id
}