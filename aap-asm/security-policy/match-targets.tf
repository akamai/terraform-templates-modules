resource "akamai_appsec_match_target" "this" {
  config_id = var.config_id
  match_target = jsonencode(
    {
      "defaultFile" : "NO_MATCH",
      "filePaths" : [
        "/*"
      ],
      "hostnames" : var.hostnames,
      "isNegativeFileExtensionMatch" : false,
      "isNegativePathMatch" : false,
      "bypassNetworkLists" : var.bypass_network_lists,
      "securityPolicy" : {
        "policyId" : akamai_appsec_security_policy.this.security_policy_id
      },
      "sequence" : var.match_target_sequence,
      "type" : "website"
    }
  )
}
