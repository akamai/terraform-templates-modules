/**
 * # Transactional Endpoint Module
 * 
 * Configures Akamai Bot Manager Premier transactional endpoint protection for each API operation. This module sets up bot detection, JavaScript injection, telemetry, client-side security, and cross-policy bot score thresholds.
 * 
 * ---
 * 
 * ## What This Module Does
 * 
 * 1. **Looks up** the existing AppSec security configuration and policy by name
 * 2. **Creates transactional endpoints** for every operation defined in the operations JSON, with telemetry settings based on expected traffic types
 * 3. **Configures JavaScript injection** rules for specified hostnames (conditional)
 * 4. **Sets client-side security** settings (same-site cookies, strict CSP compatibility)
 * 5. **Configures cross-policy bot score thresholds** for inline, SDK, and standard telemetry
 * 
 * ```
 *                     +--------------------------+
 *  config_name ------>|  data.appsec_config      |---> config_id
 *  policy_name ------>|  data.appsec_policy      |---> policy_id
 *                     +--------------------------+
 *                                |
 *           +--------------------+------------------------+
 *           v                    v                        v
 *  transactional_endpoints   js_injection       client_side_security
 *  (one per operation)       (conditional)      + endpoint_protection
 * ```
 * 
 * ---
 * 
 * ## Files
 * 
 * | File | Purpose |
 * |---|---|
 * | `main.tf` | Data sources: looks up AppSec config and policy, exposes `config_id` and `policy_id` as locals |
 * | `transactional-endpoints.tf` | Creates `akamai_botman_transactional_endpoint` for each operation with telemetry config |
 * | `javascript-injection.tf` | Configures `akamai_botman_javascript_injection` rules (conditional on `enable_js_injection`) |
 * | `cross-policy-bot-setting.tf` | Configures `akamai_botman_client_side_security` and `akamai_botman_transactional_endpoint_protection` with bot score thresholds |
 * | `custom_client.tf` | Custom client definition (currently commented out, template for future use) |
 * | `variables.tf` | All input variables |
 * | `output.tf` | Exports `config_id` for downstream modules |
 * | `versions.tf` | Terraform and provider version constraints (Terraform >= 1.0, Akamai provider >= 9.2.0) |
 * 
 * ---
 * 
 * ## Usage
 * 
 * Called from the root `main.tf` using `for_each` over the `apis` map. Not invoked directly.
 * 
 * ```hcl
 * module "transactional_endpoint" {
 *   source   = "../../terraform-templates-modules/bmp/transactional_endpoint"
 *   for_each = var.apis
 * 
 *   config_name = var.config_name
 *   policy_name = var.policy_name
 * 
 *   enable_js_injection  = each.key == "api1"
 *   javascript_hostnames = var.javascript_hostnames
 *   injection_type       = var.injection_type
 * 
 *   operation_json    = "${path.module}/${var.operations[each.key]}"
 *   akamai_operations = module.api_definition[each.key].api_operations
 * 
 *   expect_inline_traffic   = var.expect_inline_traffic
 *   expect_sdk_traffic      = var.expect_sdk_traffic
 *   expect_standard_traffic = var.expect_standard_traffic
 * 
 *   depends_on = [module.api_definition]
 * }
 * ```
 * 
 * ---
 * 
 * ## Inputs
 * 
 * ### Security Configuration
 * 
 * | Variable | Type | Default | Description |
 * |---|---|---|---|
 * | `config_name` | `string` | required | Name of the existing AppSec security configuration |
 * | `policy_name` | `string` | required | Name of the security policy within the configuration |
 * 
 * ### JavaScript Injection
 * 
 * | Variable | Type | Default | Description |
 * |---|---|---|---|
 * | `enable_js_injection` | `string` | `""` | Set to truthy value to enable JS injection for this API. Typically `each.key == "api1"` so only one API gets injection |
 * | `javascript_hostnames` | `list(string)` | required | Hostnames where JavaScript injection rules are applied |
 * | `injection_type` | `string` | required | JS injection mode: `NEVER`, `AROUND_PROTECTED_OPERATIONS`, or `ALWAYS` |
 * 
 * ### Traffic Expectations
 * 
 * | Variable | Type | Default | Description |
 * |---|---|---|---|
 * | `expect_inline_traffic` | `bool` | required | Whether inline browser-based telemetry traffic is expected. Unexpected traffic may be flagged as bot activity |
 * | `expect_sdk_traffic` | `bool` | required | Whether SDK-instrumented traffic (Android/iOS) is expected |
 * | `expect_standard_traffic` | `bool` | required | Whether standard non-instrumented traffic is expected |
 * 
 * ### Operations
 * 
 * | Variable | Type | Default | Description |
 * |---|---|---|---|
 * | `operation_json` | `string` | required | Path to the operations JSON file (plan-time input, used to build the operation key map) |
 * | `akamai_operations` | `list(any)` | required | Operations returned by Akamai after API creation (apply-time data from `module.api_definition[].api_operations`) |
 * 
 * ---
 * 
 * ## Outputs
 * 
 * | Output | Description |
 * |---|---|
 * | `config_id` | The AppSec configuration ID resolved by name. Passed to `module.security_config_activation` |
 * 
 * ---
 * 
 * ## Resources Created
 * 
 * | Resource | Condition | Description |
 * |---|---|---|
 * | `data.akamai_appsec_configuration.config` | Always | Looks up the AppSec config by name |
 * | `data.akamai_appsec_security_policy.policy` | Always | Looks up the security policy by name |
 * | `akamai_botman_transactional_endpoint.bmp_endpoint` | One per operation | Creates transactional endpoint with telemetry for each operation |
 * | `akamai_botman_javascript_injection.injection` | `enable_js_injection = true` | Configures JS injection rules for specified hostnames |
 * | `akamai_botman_client_side_security.client_side_security` | `enable_js_injection = true` | Enables client-side security (strict CSP, secure traffic) |
 * | `akamai_botman_transactional_endpoint_protection` | Always | Sets bot score thresholds for inline, SDK, and standard telemetry |
 * 
 * ---
 * 
 * ## How Transactional Endpoints Are Built
 * 
 * The module uses a two-step key-matching approach to link your operations JSON to Akamai's returned operation IDs:
 * 
 * 1. **Plan time:** Reads `operation_json` and builds keys as `resource_path|operation_name|purpose` (e.g. `/login|user_login|LOGIN`)
 * 2. **Apply time:** Receives `akamai_operations` from the api-definition module and builds a lookup map using the same key format
 * 3. **Creates one endpoint per key** using `for_each`, matching each operation to its Akamai-assigned `operation_id` and `api_id`
 * 
 * A `precondition` lifecycle check ensures every operation in your JSON has a matching Akamai response. If not, Terraform fails with a clear error.
 * 
 * ### Telemetry Configuration
 * 
 * Traffic telemetry buckets are dynamically built based on the `expect_*_traffic` flags:
 * 
 * | Flag | Telemetry Buckets Added |
 * |---|---|
 * | `expect_standard_traffic = true` | `standardTelemetry` |
 * | `expect_inline_traffic = true` | `inlineTelemetry` |
 * | `expect_sdk_traffic = true` | `nativeSdkAndroid` + `nativeSdkIos` |
 * 
 * Disabled traffic types get `"disabledAction": "monitor"` so they are still monitored but not blocked.
 * 
 * All thresholds default to: aggressive = 90, strict = 50, action = monitor.
 * 
 * ---
 * 
 * ## Dependencies
 * 
 * - **Upstream:** `module.api_definition` provides `akamai_operations` (Akamai-assigned operation IDs)
 * - **Downstream:** `module.security_config_activation` receives `config_id` from this module
 * 
 */ 