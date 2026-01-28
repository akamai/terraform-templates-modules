
data "akamai_property_rules_builder" "rule_augment_insights" {
  rules_v2025_10_16 {
    name                  = "Augment insights"
    comments              = "Control the settings related to monitoring and reporting. This gives you additional visibility into your traffic and audiences."
    criteria_must_satisfy = "all"
    children = concat(
      [
        data.akamai_property_rules_builder.rule_traffic_reporting.json,
        data.akamai_property_rules_builder.rule_geolocation.json,
        data.akamai_property_rules_builder.rule_log_delivery.json,
      ],
      # Add rule_script_management ONLY if product_id is NOT "Site_Accel", (only for Ion and Ion Premier)
      var.enable_mPulse ? [
        data.akamai_property_rules_builder.rule_m_pulse_rum.json
      ] : []
    )
  }
}
