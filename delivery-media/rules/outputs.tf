output "rule_format" {
  description = "Rule format string produced by the default rule builder, passed through to akamai_property."
  value       = data.akamai_property_rules_builder.rule_default.rule_format
}

output "rules" {
  description = "Rendered JSON rule tree, passed through to akamai_property."
  value       = data.akamai_property_rules_builder.rule_default.json
}
