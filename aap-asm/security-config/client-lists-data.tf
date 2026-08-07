data "akamai_clientlist_lists" "all" {
}

locals {
  all_lists = {
    for list in data.akamai_clientlist_lists.all.lists : list.list_id => list
  }

  bypass_network_lists = [
    for id in var.client_lists_securitybypass : {
      "id"   = id
      "name" = lookup(local.all_lists, id, { name = "Unknown" }).name
    }
  ]
}
