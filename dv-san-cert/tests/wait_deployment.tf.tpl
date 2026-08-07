terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "~> 9.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 1.9.0"
}

data "akamai_cps_enrollment" "my-enrollment" {
  enrollment_id = var.enrollment_id
}

resource "local_file" "enrollment_id_pending_changes" {
  filename = "enrollment_pending_changes.txt"
  content  = data.akamai_cps_enrollment.my-enrollment.pending_changes
}

variable "enrollment_id"{
  description = "enrollment id"
  type        = number
}