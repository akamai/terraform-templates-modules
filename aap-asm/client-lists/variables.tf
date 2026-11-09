# Global settings
variable "contract_id" {
  description = "Akamai Contract ID"
  type        = string
}

variable "group_id" {
  description = "Akamai Group ID"
  type        = string
}

variable "config_name" {
  description = "Security configuration name"
  type        = string
}

variable "client_lists_prefix" {
  description = "Prefix for the Client Lists"
  type        = string
}

variable "client_list_entries" {
  description = "Entries for each list. Each entry can be a string value or an object with value and optional description and tags fields. Values must match the list type, such as IP addresses or CIDRs, country codes, or ASNs."
  type = object({
    ipblock            = optional(list(any), [])
    ipblock_exceptions = optional(list(any), [])
    geoblock           = optional(list(any), [])
    asnblock           = optional(list(any), [])
    securitybypass     = optional(list(any), [])
    rcbypass           = optional(list(any), [])
    pragmabypass       = optional(list(any), [])
  })
  default = {}
}

variable "activation_networks" {
  description = "Networks on which to activate every client list. Removing a network deactivates the lists there."
  type        = set(string)
  default     = []

  validation {
    condition = alltrue([
      for network in var.activation_networks : contains(["STAGING", "PRODUCTION"], network)
    ])
    error_message = "Activation networks may only contain STAGING and/or PRODUCTION."
  }
}

variable "version_notes" {
  description = "Comments attached to client list activation and deactivation requests."
  type        = string
  default     = "Managed by Terraform"
}

variable "notification_emails" {
  description = "Email addresses notified about client list activation and deactivation."
  type        = list(string)
  default     = []
}

