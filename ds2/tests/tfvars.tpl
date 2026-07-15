#### ------------------------------------------------------------
## Account
#### ------------------------------------------------------------

group_id    = "grp_315874"
contract_id = "ctr_1-5C13O2"

#### ------------------------------------------------------------
## Stream Identity
#### ------------------------------------------------------------

name         = "GSS-DEVOPS-${MATRIX_NAME}"
property_ids = ["prp_1381068"]

#### ------------------------------------------------------------
## Stream Behaviour
#### ------------------------------------------------------------

activate_stream = true

enable_midgress     = false
notification_emails = []
log_format          = "JSON"
interval_in_secs    = 60

# dataset_fields_ids  = [1000, 1002, 1015, 1037, 1100]   # default field set
# sampling_percentage = 100    # deliver 10 % of log lines (null = 100 %)
# upload_file_prefix  = "ak"  # log file name prefix (default: ak)
# upload_file_suffix  = "ds"  # log file name suffix (default: ds)
# field_delimiter     = "SPACE"  # only when log_format = STRUCTURED

#### ============================================================
## Connector — uncomment exactly ONE block
#### ============================================================
