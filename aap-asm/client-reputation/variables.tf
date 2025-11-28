# Global settings
variable "config_id" {
  description = "Akamai security configuration ID"
  type        = string
}
variable "security_policy_id" {
  description = "Security policy ID"
  type        = string
}

# Bypass List
variable "client_lists_reputationbypass" {
  description = "ID(s) for the Reputation Bypass Client List"
  type        = list(string)
}

# Client Reputation Actions
variable "rep_web_attackers_high" {
  description = "Action for Reputation Profile:  Web Attackers (High Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_web_attackers_high_shared" {
  description = "Action for Reputation Profile:  Web Attackers (High Threat) SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_web_attackers_low" {
  description = "Action for Reputation Profile: Web Attackers (Low Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_web_attackers_low_shared" {
  description = "Action for Reputation Profile: Web Attackers (Low Threat) SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_dos_attackers_high" {
  description = "Action for Reputation Profile: DoS Attackers (High Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_dos_attackers_high_shared" {
  description = "Action for Reputation Profile: DoS Attackers (High Threat) SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_dos_attackers_low" {
  description = "Action for Reputation Profile: DoS Attackers (Low Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_dos_attackers_low_shared" {
  description = "Action for Reputation Profile: DoS Attackers (Low Threat) SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_scanning_tools_high" {
  description = "Action for Reputation Profile: Scanning Tools (High Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_scanning_tools_high_shared" {
  description = "Action for Reputation Profile: Scanning Tools (High Threat) SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_scanning_tools_low" {
  description = "Action for Reputation Profile: Scanning Tools (Low Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_scanning_tools_low_shared" {
  description = "Action for Reputation Profile: Scanning Tools (Low Threat) SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_web_scrapers_high" {
  description = "Action for Reputation Profile: Web Scrapers (High Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_web_scrapers_high_shared" {
  description = "Action for Reputation Profile: Web Scrapers (High Threat) SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_web_scrapers_low" {
  description = "Action for Reputation Profile: Web Scrapers (Low Threat) NON-SHARED IPs"
  type        = string
  default     = "alert"
}

variable "rep_web_scrapers_low_shared" {
  description = "Action for Reputation Profile: Web Scrapers (Low Threat) SHARED IPs"
  type        = string
  default     = "alert"
}
