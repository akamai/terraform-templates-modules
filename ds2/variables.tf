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
  description = "Product ID (e.g., SPM for Ion)."
  default     = "SPM"
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
  description = "Enable midgress traffic logging."
  default     = false
}

variable "dataset_fields_ids" {
  type        = list(number)
  description = "List of dataset fields IDs to log."
  default     = [1000, 1002, 1015, 1037, 1100]
}

variable "log_format" {
  type        = string
  description = "Format of the logs (JSON or STRUCTURED)."
  default     = "JSON"
}

variable "s3_connector" {
  description = "Configuration for AWS S3 destination."
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
  description = "Configuration for Datadog destination."
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
  description = "Configuration for Splunk destination."
  type = object({
    display_name          = string
    endpoint              = string
    event_collector_token = string
  })
  default = null
}

variable "azure_connector" {
  description = "Configuration for Azure Storage destination."
  type = object({
    display_name   = string
    account_name   = string
    container_name = string
    access_key     = string
    path           = string
  })
  default = null
}