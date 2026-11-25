# ---------- Google Cloud Storage ----------
 gcs_connector = {
   display_name         = "GCS"
   bucket               = "ds2-gss-devops"
   project_id           = "ascendant-nova-260306"
   service_account_name = "gss-dev-ops"
   private_key          = "${GCS_KEY}"
   path                 = "/akamai/logs"   # optional
 }

 property_ids = ["prp_1381184"]