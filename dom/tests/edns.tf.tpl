resource "akamai_dns_record" "dom_validation_record" {
  for_each = {
    for domain_resource in akamai_property_domainownership_domains.domains :
    element(flatten([for domain in domain_resource.domains : domain.domain_name]), 0) =>
    element(flatten([for domain in domain_resource.domains : domain.validation_challenge.txt_record]), 0)
  }
    # zone command splits up the input dns name and takes the top level and second level only
    zone = join(".", slice(split(".", lower(each.key)), length(split(".", lower(each.key))) - 2, length(split(".", lower(each.key)))))
    name       = each.value.name
    recordtype = "TXT"
    ttl        = 120
    target     = [each.value.target]
}