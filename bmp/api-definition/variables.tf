# ============================================================
# Global Activation Controls
# ============================================================

variable "activate_to_staging" {
  description = "Set to true to activate the resource to the STAGING network."
  type        = bool
  default     = false
}

variable "activate_to_production" {
  description = "Set to true to activate the resource to the PRODUCTION network."
  type        = bool
  default     = false
}

variable "activation_to_staging_exists" {
  description = "Internal flag indicating whether a staging activation already exists. Used by activation logic; do not modify manually."
  type        = bool
  default     = false
}

variable "activation_to_production_exists" {
  description = "Internal flag indicating whether a production activation already exists. Used by activation logic; do not modify manually."
  type        = bool
  default     = false
}



# ============================================================
# API Definition Inputs
# ============================================================


variable "api_json" {
  description = "Path to the API definition (OpenAPI JSON/YAML file)."
  type        = string
  default     = "null"
}

variable "operation_json" {
  description = "Path to the API operations definition JSON file."
  type        = string
  default     = "null"
}



# ============================================================
# Contract / Group Configuration
# ============================================================

variable "contract_id" {
  description = "Akamai Contract ID (without 'ctr_' prefix if trimmed externally)."
  type        = string
}

variable "group_id" {
  description = "Akamai Group ID (without 'grp_' prefix if trimmed externally)."
  type        = string
}



# ============================================================
# Notifications
# ============================================================

variable "notification_emails" {
  description = "List of email addresses that will receive activation notifications."
  type        = list(string)
}