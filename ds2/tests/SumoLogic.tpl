#---------- Sumo Logic  ----------
# Akamai appends collector_code to the endpoint URL.
 sumologic_connector = {
   display_name   = "sumologic"
   endpoint       = "https://endpoint4.collection.us2.sumologic.com/receiver/v1/http"
   collector_code = "${SUMOLOGIC_TOKEN}"
 }
