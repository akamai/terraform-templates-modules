 #---------- Custom HTTPS  (most reliable) ----------
 #authentication_type must be NONE or BASIC.
 https_connector = {
   display_name        = "datastream.rafa.cr"
   endpoint            = "https://ds-amplify-rafa-cr.akamaized.net/receiver/v1/http"
   authentication_type = "NONE"
   content_type        = "application/json"
   custom_header_name  = ""
   custom_header_value = ""
 }

 property_ids = ["prp_1381185"]