variable "product_id" {
  description = "Property Manager product. [ION => Fresca, ION Premier => SPM, DSA => Site_Accel]"
  type        = string
  default     = "Site_Accel"
}

variable "etls" {
  description = "Boolean to switch between Enhanced and Standard TLS modes"
  type        = bool
}

variable "cpcode_id" {
  description = "Default CP Code id."
  type        = number
  default     = null
}

variable "cpcode_name" {
  description = "Default CP Code name. Will be the property name (var.name) if null."
  type        = string
  default     = null
}

variable "default_origin" {
  description = "Default origin server for all properties"
  type        = string
}

variable "additional_origins" {
  description = "Additional origins for the property. For now the match is only by hostname."
  type = map(object({
    origin_name    = string
    hostname_match = list(string)
    path_match     = list(string)
  }))
}

variable "sure_route_test_object" {
  description = "Test object path for SureRoute"
  type        = string
  default     = "/akamai/testobject.html"
}

variable "td_region" {
  description = <<-EOD
    Region (map) for Tiered Distribution behaviour. Only applies if network is Standard TLS.
    Options are: CH2, CHAPAC, CHEU2, CHEUS2, CHWUS2, CHCUS2, CHAUS
  EOD
  type        = string
  default     = "CH2"
}

variable "enable_mPulse" {
  description = "Boolean tod ecide whether to inject the mpulse behavior"
  type        = bool
  default     = true
}
