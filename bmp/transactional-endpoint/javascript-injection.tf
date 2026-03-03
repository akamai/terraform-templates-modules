resource "akamai_botman_javascript_injection" "injection" {
  count              = var.enable_js_injection ? 1 : 0
  config_id          = local.config_id
  security_policy_id = local.policy_id
  javascript_injection = jsonencode(
    {
      "injectJavaScript" : var.injection_type,
      "rules" : [
        {
          "conditions" : [
            {
              "host" : var.javascript_hostnames,
              "positiveMatch" : true,
              "type" : "hostCondition"
            }
          ],
          "injectJavaScript" : var.injection_type,
          "ruleName" : "New Injection Rule"
        }
      ]
    }
  )
}