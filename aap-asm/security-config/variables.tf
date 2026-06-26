variable "contract_id" {
  description = "Akamai Contract ID"
  type        = string
}

variable "group_name" {
  description = "Akamai Group Name"
  type        = string
}

variable "config_name" {
  description = "Security configuration name"
  type        = string
}

variable "description" {
  description = "Security configuration description"
  type        = string
}

variable "hostnames" {
  description = "All hostnames to protect by the security config"
  type        = list(string)

  validation {
    condition = alltrue([
      for h in var.hostnames : h == lower(h)
    ])
    error_message = "All hostnames must be lowercase."
  }
}

variable "version_notes" {
  description = "Notes for the configuration version"
  type        = string
}

variable "inspection_size" {
  description = "Request body inspection limit"
  type        = number
  default     = 32
}

variable "client_lists_rcbypass" {
  description = "ID(s) for the Rate Control Bypass Client List"
  type        = list(string)
  default     = []
}

variable "client_lists_pragmabypass" {
  description = "ID(s) for the Pragma Bypass Client List"
  type        = list(string)
  default     = []
}

variable "client_lists_securitybypass" {
  description = "ID(s) for the Security Bypass Client List"
  type        = list(string)
  default     = []
}

variable "enable_client_reputation" {
  description = "Enable Client Reputation profiles at config level"
  type        = bool
  default     = false
}

variable "client_lists_reputationbypass" {
  description = "ID(s) for the Reputation Bypass Client List"
  type        = list(string)
  default     = []
}
