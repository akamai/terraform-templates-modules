 #---------- Oracle Cloud Object Storage ----------
 oracle_connector = {
   display_name      = "Oracle"
   bucket            = "gss-dev-ops"
   namespace         = "idknfrrof2ec"
   region            = "us-ashburn-1"
   access_key        = "${OSS_ACCESS}"
   secret_access_key = "${OSS_SECRET}"
   path              = "/akamai/logs"
 }

  property_ids = ["prp_1381195"]