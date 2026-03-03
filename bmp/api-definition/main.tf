
data "akamai_apidefinitions_openapi" "def" {
  file_path = var.api_json
}

resource "akamai_apidefinitions_api" "api" {
  api         = data.akamai_apidefinitions_openapi.def.api
  contract_id = var.contract_id
  group_id    = var.group_id
}

resource "akamai_apidefinitions_resource_operations" "my_operations" {
  api_id = akamai_apidefinitions_api.api.id
  resource_operations = file(var.operation_json)
}

data "akamai_apidefinitions_resource_operations" "operations" {
  api_id = akamai_apidefinitions_api.api.id
  depends_on = [
    akamai_apidefinitions_resource_operations.my_operations
  ]
}


resource "akamai_apidefinitions_activation" "staging" {
  count                     = var.activate_to_staging || var.activation_to_staging_exists ? 1 : 0
  network                   = "STAGING"
  api_id                    = akamai_apidefinitions_api.api.id
  version                   = var.activate_to_staging ? akamai_apidefinitions_api.api.latest_version : akamai_apidefinitions_api.api.staging_version
  notification_recipients   = var.notification_emails
  auto_acknowledge_warnings = true

  depends_on = [
    akamai_apidefinitions_resource_operations.my_operations
  ]
}

resource "akamai_apidefinitions_activation" "production" {
  count                     = var.activate_to_production || var.activation_to_production_exists ? 1 : 0
  network                   = "PRODUCTION"
  api_id                    = akamai_apidefinitions_api.api.id
  version                   = var.activate_to_production ? akamai_apidefinitions_api.api.latest_version : akamai_apidefinitions_api.api.production_version
  notification_recipients   = var.notification_emails
  auto_acknowledge_warnings = true

  depends_on = [
    akamai_apidefinitions_resource_operations.my_operations
  ]

}