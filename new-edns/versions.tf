terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "~> 9.2"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.13"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.4"
    }
  }
  required_version = ">= 1.9.0"

}
