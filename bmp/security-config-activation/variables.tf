# ============================================================
# Security Configuration Identification
# ============================================================

variable "config_id" {
  description = "Unique ID of the existing AppSec security configuration."
  type        = string
}

variable "config_name" {
  description = "Name of the AppSec security configuration."
  type        = string
}



# ============================================================
# Activation Settings
# ============================================================

variable "activation_notes" {
  description = "Notes included with the activation request (e.g., version or change summary)."
  type        = string
}

variable "notification_emails" {
  description = "List of email addresses to receive activation notifications."
  type        = list(string)
}

variable "activate_to_staging" {
  description = "Set to true to activate the configuration to the STAGING network."
  type        = bool
  default     = false
}

variable "activate_to_production" {
  description = "Set to true to activate the configuration to the PRODUCTION network."
  type        = bool
  default     = false
}

variable "activation_to_staging_exists" {
  description = "Internal flag indicating whether a staging activation already exists. Used by activation logic; do not manually modify."
  type        = bool
  default     = false
}

variable "activation_to_production_exists" {
  description = "Internal flag indicating whether a production activation already exists. Used by activation logic; do not manually modify."
  type        = bool
  default     = false
}