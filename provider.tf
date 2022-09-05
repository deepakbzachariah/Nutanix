terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.7.0"
    }
  }
}

provider "nutanix" {
  # Configuration options

  username     = "admin"
  password     = var.password
  port         = 9440
  endpoint     = var.endpoint
  insecure     = true
  wait_timeout = 10
}
