## ----------------------------------------------------------------------------
## EdgeGrid
## ----------------------------------------------------------------------------

variable "edgerc_path" {
  description = <<EOD
    Path to the .edgerc file.
  EOD
  type        = string
  default     = "~/.edgerc"
}

variable "edgerc_section" {
  description = <<EOD
    Section in the .edgerc file.

    For professional services, it is recommended to create a new section for
    each account managed.
  EOD
  type        = string
}

#### ----------------------------------------------------------------------------
## Configuration
#### ----------------------------------------------------------------------------

variable "name" {
  type        = string
  description = "Name of the DataStream 2 configuration and CP Code."
}

variable "group_id" {
  type        = string
  description = "Group ID for property/config creation."
}

variable "contract_id" {
  type        = string
  description = "Contract ID for property/config creation."
}

variable "product_id" {
  type        = string
  description = "Product ID (e.g., SPM for Ion). Only used when cpcode_id is null and a new CP Code is created."
  default     = "SPM"
}

variable "cpcode_id" {
  type        = number
  description = <<EOD
    ID of an existing CP Code to use for this stream.

    When set, the module skips CP Code creation entirely and the
    `cpcode_name` and `product_id` variables are ignored.

    When null (default), the module creates a new CP Code using
    `cpcode_name` (or `name`) and `product_id`.
  EOD
  default     = null
}

variable "cpcode_name" {
  type        = string
  description = "Optional custom name for the CP Code. If null, 'name' is used."
  default     = null
}

variable "property_ids" {
  type        = list(string)
  description = "List of Akamai Property IDs to monitor (Decoupled architecture)."
}

variable "activate_stream" {
  type        = bool
  description = "Whether to activate the stream upon creation."
  default     = true
}

variable "enable_midgress" {
  type        = bool
  description = "Enable midgress traffic collection (sets collect_midgress on the stream). Requires dataset field 2084 to log midgress hits."
  default     = false
}

variable "dataset_fields_ids" {
  type        = list(number)
  description = "List of dataset fields IDs to log."
  default     = [1000, 1002, 1015, 1037, 1100]
}

variable "log_format" {
  type        = string
  description = "Format of the logs. Must be JSON or STRUCTURED. When STRUCTURED, a field_delimiter is used."
  default     = "JSON"
  validation {
    condition     = contains(["JSON", "STRUCTURED"], var.log_format)
    error_message = "log_format must be either JSON or STRUCTURED."
  }
}

variable "s3_connector" {
  description = "Configuration for AWS S3 destination."
  sensitive   = true
  type = object({
    display_name      = string
    bucket            = string
    region            = string
    access_key        = string
    secret_access_key = string
    path              = string
  })
  default = null
}

variable "datadog_connector" {
  description = <<EOD
    Configuration for Datadog destination.

    NOTE: Akamai DataStream only supports Datadog v1 endpoints, not v2.
    Akamai validates the API key with a live POST before creating the stream.
    Correct endpoint format (include https:// scheme):
      EU: https://http-intake.logs.datadoghq.eu/v1/input
      US: https://http-intake.logs.datadoghq.com/v1/input
  EOD
  sensitive   = true
  type = object({
    display_name = string
    endpoint     = string
    auth_token   = string
    service      = optional(string)
    source       = optional(string)
    tags         = optional(string)
  })
  default = null
}

variable "splunk_connector" {
  description = "Configuration for Splunk destination. NOTE: Akamai DataStream only accepts the Splunk HEC raw endpoint — the URL must end with /services/collector/raw."
  sensitive   = true
  type = object({
    display_name          = string
    endpoint              = string
    event_collector_token = string
  })
  default = null
}

variable "azure_connector" {
  description = "Configuration for Azure Storage destination."
  sensitive   = true
  type = object({
    display_name   = string
    account_name   = string
    container_name = string
    access_key     = string
    path           = string
  })
  default = null
}