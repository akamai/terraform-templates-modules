variable "domain_validation_entries" {
  description = "A list of objects with hostnames, domains, or wildcards to DOM validate"
  type = list(object({
    domain_name       = string
    validation_scope  = string
    validation_method = string
  }))
}

variable "enable_validation" {
  description = "Set to true to enable domain validation"
  type        = bool
}

#tflint-ignore: terraform_unused_declarations
variable "edgerc_path" {
  description = "Path to the .edgerc file"
  type        = string
}

#tflint-ignore: terraform_unused_declarations
variable "edgerc_section" {
  description = "Section in the .edgerc file"
  type        = string
}

variable "domain_search_entries" {
  description = "List of domains to search validation status for"
  type = list(object({
    domain_name      = string
    validation_scope = string
  }))
  default = []
}