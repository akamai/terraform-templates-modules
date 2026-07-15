 #---------- New Relic  ----------
 #auth_token is sent as the Api-Key header.
 new_relic_connector = {
   display_name = "newrelic"
   endpoint     = "https://log-api.newrelic.com/log/v1"
   auth_token   = "${NEWRELIC_TOKEN}"
 }

  property_ids = ["prp_1381194"]