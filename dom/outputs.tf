output "txt_validation_challenges" {
  description = "Map of TXT records for domain validation challenges (key: domain_name)"
  value = {
    for domain_resource in akamai_property_domainownership_domains.domains :
    element(flatten([for domain in domain_resource.domains : domain.domain_name]), 0) =>
    element(flatten([for domain in domain_resource.domains : domain.validation_challenge.txt_record]), 0)
  }
}

output "cname_validation_challenges" {
  description = "Map of CNAME records for domain validation challenges (key: domain_name)"
  value = {
    for domain_resource in akamai_property_domainownership_domains.domains :
    element(flatten([for domain in domain_resource.domains : domain.domain_name]), 0) =>
    element(flatten([for domain in domain_resource.domains : domain.validation_challenge.cname_record]), 0)
  }
}

output "domain_search_results" {
  # 'domains' is the actual attribute name for this Akamai data source
  value = one(data.akamai_property_domainownership_search_domains.search[*].domains)
}