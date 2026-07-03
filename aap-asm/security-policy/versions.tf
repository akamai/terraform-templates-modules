terraform {
  required_version = ">= 1.9.0"
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "~> 10.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13"
    }
  }
}
