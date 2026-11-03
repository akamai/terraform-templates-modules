 #---------- Loggly  ----------
 # Akamai appends auth_token to the endpoint URL to form the full bulk ingest URL.
 loggly_connector = {
   display_name = "Loggly"
   endpoint     = "http://logs-01.loggly.com/inputs/"
   auth_token   = "${LOGGLY_TOKEN}"
   tags         = "akamai"
 }

 property_ids = ["prp_1381193"]