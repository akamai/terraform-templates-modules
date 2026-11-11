# ---------- S3-Compatible (MinIO, Wasabi, Cloudflare R2)  ----------
# endpoint is the scheme-qualified host only; Akamai builds {endpoint}/{bucket}/{path}/{file}.
 s3_compatible_connector = {
   display_name      = "linode"
   endpoint          = "us-mia-1.linodeobjects.com"
   bucket            = "rafa"
   region            = "us-mia-1"
   access_key        = "${LINODE_ACCESS}"
   secret_access_key = "${LINODE_SECRET}"
   path              = "akamai/logs"
 }


 property_ids = ["prp_1381196"]