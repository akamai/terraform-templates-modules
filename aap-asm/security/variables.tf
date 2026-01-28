# -------------------------------------------------
# Common Variables 
# -------------------------------------------------
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
  description = "Hostnames to protect by the security config"
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

# -------------------------------------------------
# Advanced settings
# -------------------------------------------------
variable "inspection_size" {
  description = "Request body inspection limit"
  type        = number
  default     = 32
}

# -------------------------------------------------
# Protections
# -------------------------------------------------
variable "enable_waf" {
  description = "Enable Web Application Firewall Protection"
  type        = bool
}

variable "enable_request_constraints" {
  description = "Enable API Requests Constraints Protection"
  type        = bool
}

variable "enable_ip_geo" {
  description = "Enable IP/Geo Firewall Protection"
  type        = bool
}

variable "enable_malware" {
  description = "Enable Malware Protection"
  type        = bool
}

variable "enable_rate" {
  description = "Enable Rate Protection"
  type        = bool
}

variable "enable_slow_post" {
  description = "Enable Slow POST Protection"
  type        = bool
}

# -------------------------------------------------
# Client Lists
# -------------------------------------------------
# IP/Geo Firewall
variable "client_lists_ipblock" {
  description = "ID(s) for the IP Block Client List"
  type        = list(string)
  default     = []
}

variable "client_lists_exception_ipblock" {
  description = "ID(s) for the IP Block Exceptions Client List"
  type        = list(string)
  default     = []
}

variable "client_lists_geoblock" {
  description = "ID(s) for the Geo Block Client List"
  type        = list(string)
  default     = []
}

# Bypass Lists
variable "client_lists_securitybypass" {
  description = "ID(s) for the Security Bypass Client List"
  type        = list(string)
  default     = []
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

# -------------------------------------------------
# Specifics for the Security Policy
# -------------------------------------------------
# Security Policy Details
variable "policy_name" {
  description = "Name for the security policy"
  type        = string
}

variable "policy_prefix" {
  description = "Prefix for the security policy"
  type        = string
}

# Dos Protection
variable "dos_origin_error_action" {
  description = "Action for the Origin Error"
  type        = string
}

variable "dos_post_page_requests_action" {
  description = "Action for the POST Page Requests"
  type        = string
}

variable "dos_page_view_requests_action" {
  description = "Action for the Page View Requests"
  type        = string
}

variable "slow_post_action" {
  description = "Action for the slow POST Protection"
  type        = string
}

# Web Application Firewall (WAF) Actions
variable "waf_policy_action" {
  description = "Action for WAF attack group: Web Policy Violation"
  type        = string
  default     = "alert"
}

variable "waf_wat_action" {
  description = "Action for WAF attack group: Web Attack Tool"
  type        = string
  default     = "alert"
}

variable "waf_protocol_action" {
  description = "Action for WAF attack group: Web Protocol Attack"
  type        = string
  default     = "alert"
}

variable "waf_sql_action" {
  description = "Action for WAF attack group: SQL Injection"
  type        = string
  default     = "alert"
}

variable "waf_xss_action" {
  description = "Action for WAF attack group: Cross Site Scripting"
  type        = string
  default     = "alert"
}

variable "waf_cmd_action" {
  description = "Action for WAF attack group: Command Injection"
  type        = string
  default     = "alert"
}

variable "waf_lfi_action" {
  description = "Action for WAF attack group: Local File Inclusion"
  type        = string
  default     = "alert"
}

variable "waf_rfi_action" {
  description = "Action for WAF attack group: Remote File Inclusion"
  type        = string
  default     = "alert"
}

variable "waf_platform_action" {
  description = "Action for WAF attack group: Web Platform Attack"
  type        = string
  default     = "alert"
}

variable "penalty_box_action" {
  description = "Action for WAF Penalty Box"
  type        = string
  default     = "alert"
}
