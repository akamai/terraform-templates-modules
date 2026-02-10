terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "~> 9.0"
    }
  }
  required_version = ">= 1.9.0"
}
provider "akamai" {
  edgerc         = var.edgerc_path
  config_section = var.config_section
}
