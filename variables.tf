variable "vm_name" {
  type    = string
  default = "Terraform_VM"
}

variable "Memory_in_MB" {
  type    = number
  default = 2048
}

variable "vcpus_per_socket" {
  type    = number
  default = 1
}

variable "no_socket" {
  type    = number
  default = 1
}

variable "cluster_name" {
  type    = string
  default = "POC"
}

variable "endpoint" {
  type    = string
  default = "PC_IP"
}

variable "user" {
  type    = string
  default = "PC_user"
}

variable "password" {
  type    = string
  default = "PC_pass"
}

variable "subnet_name" {
  type    = string
  default = "Primary"
}

variable "image_name" {
    type = string
    default = "CentOS"
  
}

data "nutanix_cluster" "myCluster" {
  name = var.cluster_name
}

data "nutanix_subnet" "subnet_info" {
  subnet_name = var.subnet_name
}

data "nutanix_image" "image_info" {
  image_name = var.image_name
}
