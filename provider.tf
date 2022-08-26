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
  password     = "<password of prism>"
  port         = 9440
  endpoint     = "<IP Address>"
  insecure     = true
  wait_timeout = 10
}
