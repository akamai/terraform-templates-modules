<!-- BEGIN_TF_DOCS -->

# API Definition Module

Creates and manages Akamai API definitions for Bot Manager Premier (BMP). This module handles the full lifecycle of an API definition — from parsing the OpenAPI schema, to registering it with Akamai, to configuring operations and activating to staging/production networks.

---

## What This Module Does

1. **Parses** your OpenAPI schema (`.yml`) into an Akamai API definition format
2. **Creates** the API definition in Akamai with your contract and group
3. **Configures** resource operations (methods, purposes, parameters, success/failure conditions) from your operations JSON
4. **Activates** the API definition to staging and/or production networks

```
api_json (.yml)  ──▶  akamai_apidefinitions_openapi  ──▶  akamai_apidefinitions_api
                                                              │
operation_json (.json)  ──────────────────────────────▶  resource_operations
                                                              │
                                          ┌───────────────────┴───────────────────┐
                                          ▼                                       ▼
                                  activation.staging                    activation.production
```

---

## Usage

This module is called from the root `main.tf` using `for_each` over the `apis` map. You do not call it directly — it is invoked by the deploy script.

```hcl
module "api_definition" {
  source   = "../../terraform-templates-modules/bmp/api-definition"
  for_each = var.apis

  api_json       = "${path.module}/${var.apis[each.key]}"
  operation_json = "${path.module}/${var.operations[each.key]}"

  contract_id         = trimprefix(data.akamai_contract.contract.id, "ctr_")
  group_id            = trimprefix(data.akamai_contract.contract.group_id, "grp_")
  notification_emails = var.emails

  activate_to_staging             = var.activate_to_staging
  activation_to_staging_exists    = var.activation_to_staging_exists
  activation_to_production_exists = var.activation_to_production_exists
  activate_to_production          = var.activate_to_production
}
```

---

## Inputs

### API Definition Inputs

| Variable | Type | Default | Description |
|---|---|---|---|
| `api_json` | `string` | `"null"` | Path to the OpenAPI schema file (`.yml`) that defines the API |
| `operation_json` | `string` | `"null"` | Path to the operations JSON file that maps resource paths to methods, purposes, parameters, and conditions |
| `apis` | `map(string)` | `{ api1 = "null" }` | Map of logical API identifiers to schema file paths. Used by the root module's `for_each` |

### Contract / Group Configuration

| Variable | Type | Default | Description |
|---|---|---|---|
| `contract_id` | `string` | — (required) | Akamai Contract ID (without `ctr_` prefix) |
| `group_id` | `string` | — (required) | Akamai Group ID (without `grp_` prefix) |

### Activation Controls

| Variable | Type | Default | Description |
|---|---|---|---|
| `activate_to_staging` | `bool` | `false` | Set to `true` to activate the API definition to the staging network |
| `activate_to_production` | `bool` | `false` | Set to `true` to activate the API definition to the production network |
| `activation_to_staging_exists` | `bool` | `false` | Internal flag — indicates whether a staging activation already exists in state. Managed by the deploy script; do not modify manually |
| `activation_to_production_exists` | `bool` | `false` | Internal flag — indicates whether a production activation already exists in state. Managed by the deploy script; do not modify manually |

### Notifications

| Variable | Type | Default | Description |
|---|---|---|---|
| `notification_emails` | `list(string)` | — (required) | Email addresses that receive activation notifications |

---

## Outputs

| Output | Description |
|---|---|
| `api_operations` | Decoded operations object returned by Akamai after the operations are registered. Passed to the `transactional_endpoint` module as `akamai_operations` |
| `api_id` | The Akamai API definition ID created by this module |

---

## Resources Created

| Resource | Description |
|---|---|
| `data.akamai_apidefinitions_openapi.def` | Parses the OpenAPI schema file into Akamai's API definition format |
| `akamai_apidefinitions_api.api` | Creates the API definition in Akamai |
| `akamai_apidefinitions_resource_operations.my_operations` | Registers the operations (methods, purposes, parameters, conditions) for the API |
| `data.akamai_apidefinitions_resource_operations.operations` | Reads back the registered operations (used by outputs) |
| `akamai_apidefinitions_activation.staging[0]` | Activates the API definition to staging (conditional) |
| `akamai_apidefinitions_activation.production[0]` | Activates the API definition to production (conditional) |

---

## Activation Logic

The staging and production activation resources use `count` to conditionally create:

- **Staging:** Created when `activate_to_staging = true` OR `activation_to_staging_exists = true`
- **Production:** Created when `activate_to_production = true` OR `activation_to_production_exists = true`

When activating, the module uses `latest_version`. When preserving an existing activation (exists flag only), it uses the current `staging_version` or `production_version` to avoid unintended version changes.

---

## Dependencies

This module has no upstream dependencies. It is consumed by:

- **`module.transactional_endpoint`** — receives `api_operations` output to configure bot protection
- **`module.security_config_activation`** — depends on transactional\_endpoint, which depends on this module

# Usage
Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-location>"
  
	 # Required variables
  	 contract_id  = <string>
  	 group_id  = <string>
  	 notification_emails  = <list(string)>
  
	 # Optional variables
  	 activate_to_production  = <bool> | default: false
  	 activate_to_staging  = <bool> | default: false
  	 activation_to_production_exists  = <bool> | default: false
  	 activation_to_staging_exists  = <bool> | default: false
  	 api_json  = <string> | default: "null"
  	 operation_json  = <string> | default: "null"
}
 ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_akamai"></a> [akamai](#requirement\_akamai) | >= 9.2.0 |

## Resources

| Name | Type |
|------|------|
| [akamai_apidefinitions_activation.production](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/apidefinitions_activation) | resource |
| [akamai_apidefinitions_activation.staging](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/apidefinitions_activation) | resource |
| [akamai_apidefinitions_api.api](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/apidefinitions_api) | resource |
| [akamai_apidefinitions_resource_operations.my_operations](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/apidefinitions_resource_operations) | resource |
| [akamai_apidefinitions_openapi.def](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/apidefinitions_openapi) | data source |
| [akamai_apidefinitions_resource_operations.operations](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/apidefinitions_resource_operations) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contract_id"></a> [contract\_id](#input\_contract\_id) | Akamai Contract ID (without 'ctr\_' prefix if trimmed externally). | `string` | n/a | yes |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | Akamai Group ID (without 'grp\_' prefix if trimmed externally). | `string` | n/a | yes |
| <a name="input_notification_emails"></a> [notification\_emails](#input\_notification\_emails) | List of email addresses that will receive activation notifications. | `list(string)` | n/a | yes |
| <a name="input_activate_to_production"></a> [activate\_to\_production](#input\_activate\_to\_production) | Set to true to activate the resource to the PRODUCTION network. | `bool` | `false` | no |
| <a name="input_activate_to_staging"></a> [activate\_to\_staging](#input\_activate\_to\_staging) | Set to true to activate the resource to the STAGING network. | `bool` | `false` | no |
| <a name="input_activation_to_production_exists"></a> [activation\_to\_production\_exists](#input\_activation\_to\_production\_exists) | Internal flag indicating whether a production activation already exists. Used by activation logic; do not modify manually. | `bool` | `false` | no |
| <a name="input_activation_to_staging_exists"></a> [activation\_to\_staging\_exists](#input\_activation\_to\_staging\_exists) | Internal flag indicating whether a staging activation already exists. Used by activation logic; do not modify manually. | `bool` | `false` | no |
| <a name="input_api_json"></a> [api\_json](#input\_api\_json) | Path to the API definition (OpenAPI JSON/YAML file). | `string` | `"null"` | no |
| <a name="input_operation_json"></a> [operation\_json](#input\_operation\_json) | Path to the API operations definition JSON file. | `string` | `"null"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | Created API ID |
| <a name="output_api_operations"></a> [api\_operations](#output\_api\_operations) | Decoded operations returned by Akamai for this API |
<!-- END_TF_DOCS -->