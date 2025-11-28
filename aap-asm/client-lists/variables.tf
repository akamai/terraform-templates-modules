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

variable "version_notes" {
  description = "Notes for the version"
  type        = string
}

variable "notification_emails" {
  description = "List or emails for notifications"
  type        = list(string)
}