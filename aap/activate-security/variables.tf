variable "config_name" {
  description = "Security configuration name"
  type        = string
}

variable "config_id" {
  description = "Security configuration ID"
  type        = number
}

variable "activation_notes" {
  description = "Notes for the activation"
  type        = string
}

variable "notification_emails" {
  description = "List or emails for notifications"
  type        = list(string)
}

variable "activate_to_staging" {
  description = "Set to true to directly activate on the staging network."
  type        = bool
  default     = false
}

variable "activate_to_production" {
  description = "Set to true to directly activate on the production network."
  type        = bool
  default     = false
}

variable "activation_to_staging_exists" {
  description = "Do not modify. Flag used together with the logic in the activation resources for the initial activation to staging."
  type        = bool
  default     = false
}

variable "activation_to_production_exists" {
  description = "Do not modify. Flag used together with the logic in the activation resources for the initial activation to production."
  type        = bool
  default     = false
}

variable "dummy_temp_var" {
  type    = string
  default = "test"
}