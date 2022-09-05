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
  password     = "Password"
  port         = 9440
  endpoint     = "IP address of Prism Central"
  insecure     = true
  wait_timeout = 10
}
