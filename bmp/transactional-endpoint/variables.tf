# ============================================================
# Security Configuration / Policy
# ============================================================

variable "config_name" {
  description = "Name of the existing AppSec security configuration."
  type        = string
}

variable "policy_name" {
  description = "Name of the security policy within the specified configuration."
  type        = string
}



# ============================================================
# Bot Manager – JavaScript Injection
# ============================================================

variable "enable_js_injection" {
  description = "Optional flag or mode to enable JavaScript injection logic."
  type        = string
  default     = ""
}

variable "javascript_hostnames" {
  description = "List of hostnames where JavaScript injection should be applied."
  type        = list(string)
}

variable "injection_type" {
  description = "JavaScript injection mode. Allowed values: NEVER, AROUND_PROTECTED_OPERATIONS, ALWAYS."
  type        = string
}



# ============================================================
# Traffic Expectations (Transactional Endpoint Logic)
# ============================================================

variable "expect_inline_traffic" {
  description = "Indicates whether inline browser-based traffic is expected. Unexpected traffic may be treated as bot traffic."
  type        = bool
}

variable "expect_sdk_traffic" {
  description = "Indicates whether SDK-based (instrumented) traffic is expected. Unexpected traffic may be treated as bot traffic."
  type        = bool
}

variable "expect_standard_traffic" {
  description = "Indicates whether standard (non-instrumented) traffic is expected. Unexpected traffic may be treated as bot traffic."
  type        = bool
}



# ============================================================
# Operations Inputs
# ============================================================

variable "operation_json" {
  description = "Path to the local operation specification JSON file (plan-time known input)."
  type        = string
}

variable "akamai_operations" {
  description = "List of operation objects returned by Akamai after API creation (apply-time data)."
  type        = list(any) # Can be tightened to object(...) if schema stabilizes
}