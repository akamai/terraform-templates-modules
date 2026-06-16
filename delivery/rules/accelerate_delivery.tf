
data "akamai_property_rules_builder" "rule_accelerate_delivery" {
  rules_v2026_02_16 {
    name                  = "Accelerate delivery"
    comments              = "Control the settings related to improving the performance of delivering objects to your users."
    criteria_must_satisfy = "all"
    children = concat(
      [
        data.akamai_property_rules_builder.rule_origin_connectivity.json,
        data.akamai_property_rules_builder.rule_protocol_optimizations.json,
        data.akamai_property_rules_builder.rule_prefetching.json,
      ],

      # Add rule_adaptive_acceleration ONLY if product_id is NOT "Site_Accel", (only for Ion and Ion Premier). If mpulse is disabled, thenwe will not add A2.
      var.product_id != "Site_Accel" && var.enable_mPulse ? [
        data.akamai_property_rules_builder.rule_adaptive_acceleration.json
      ] : []
    )
  }
}
