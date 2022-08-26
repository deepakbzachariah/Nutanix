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
  password     = "nx2Tech398!"
  port         = 9440
  endpoint     = "10.38.78.37"
  insecure     = true
  wait_timeout = 10
}