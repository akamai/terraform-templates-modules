# ---------- Google Cloud Storage ----------
 gcs_connector = {
   display_name         = "GCS"
   bucket               = "ds2-gss-devops"
   project_id           = "ascendant-nova-260306"
   service_account_name = "gss-dev-ops@ascendant-nova-260306.iam.gserviceaccount.com"
   private_key          = "${GCS_KEY}"
   path                 = "/akamai/logs"   # optional
 }