
# Query all client lists
data "akamai_clientlist_lists" "all" {
}

# Build the client list objects with id and name
locals {
  # Create a map of list_id to list details from the data source
  all_lists = {
    for list in data.akamai_clientlist_lists.all.lists : list.list_id => list
  }

  # Build the bypass network lists with id and name
  bypass_network_lists = [
    for id in var.client_lists_securitybypass : {
      "id"   = id
      "name" = lookup(local.all_lists, id, { name = "Unknown" }).name
    }
  ]
}

resource "akamai_appsec_match_target" "website_8232297" {
  config_id = akamai_appsec_configuration.config.config_id
  match_target = jsonencode(
    {
      "defaultFile" : "NO_MATCH",
      "filePaths" : [
        "/*"
      ],
      "hostnames" : var.hostnames,
      "isNegativeFileExtensionMatch" : false,
      "isNegativePathMatch" : false,
      "bypassNetworkLists" : local.bypass_network_lists,
      "securityPolicy" : {
        "policyId" : akamai_appsec_security_policy.tfdemo.security_policy_id
      },
      "sequence" : 0,
      "type" : "website"
    }
  )
}