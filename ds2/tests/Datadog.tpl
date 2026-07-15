# ---------- Datadog  ----------
# Akamai only accepts Datadog v1 endpoints and validates the key with a live POST at apply.
datadog_connector = {
   display_name  = "datadog"
   endpoint      = "https://http-intake.logs.datadoghq.com/v1/input"
   auth_token    = "${DATADOG_TOKEN}"
   service       = "akamai-cdn"
   source        = "akamai"
   tags          = "env:test,team:platform"
}