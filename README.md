# Nutanix VM Creation


This repository deploys Virtual Machine and configures the apache package in deployed VM on Nutanix cluster using Infrastructure as code with Terraform.

Pre-requites

- Terraform
- Adding nutanix as a required provider.
- Create the new VM in Nutanix, clone it and modify the VM Disk as image template. We require OS image on Nutanix cluster.
- Make sure networking VLAN has been configured.
- Establish the connectivity to Prism.


### Configuration

1. Clone the respository.

        git clone https://github.com/tanmaybhandge/Nutanix_VM_Creation.git

2. Update the variables in the ```variables.tf``` file to match your Nutanix environment.
```hcl
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
  default = "PHX-POC306"
}

variable "subnet_name" {
  type    = string
  default = "Primary"
}

variable "image_name" {
    type = string
    default = "CentOS"
  
}
```

3. You may need to modify the prism configuration on ```provider.tf``` file.

```hcl
provider "nutanix" {
  # Configuration options

  username     = "admin"
  password     = "<password of prism>"
  port         = 9440
  endpoint     = "<IP Address>"
  insecure     = true
  wait_timeout = 10
}
```

4. You may configure the username & password of the VM mentioned on the ```main.tf``` to remotely execute the script.

```hcl
  connection {
    type     = "ssh"
    user     = "root"
    password = "<password goes here>"
    host     = nutanix_virtual_machine.vm1.nic_list_status[0].ip_endpoint_list[0].ip
  }
```

5. Additionally, you may execute the customize script in ```remote-exec``` provisioner

```hcl
  provisioner "remote-exec" {
    inline = [
      "yum -y install git",

      "#To aviod the protocol error",
      "yum update -y nss curl libcurl",

      "curl https://raw.githubusercontent.com/tanmaybhandge/Linux_scripts/main/webserver.sh -o script.sh",
      "sh script.sh",
    ]
  }
```

### Providers

| Name | Version |
|------|---------|
nutanix | >= 1.7.0
terraform | >= 1.2.7


### Running this repository
Initialize the modules (and download the Nutanix Provider) by running terraform init.

    $ terraform init

Once you’ve initialized the directory, it’s good to run the validate command before you run ```plan``` or ```apply```. Validation will catch syntax errors, version errors, and other issues.
    
    $ terraform validate

Next, it’s always a good idea to do a dry run of your plan to see what it’s actually going to do. You can even use one of the subcommands with terraform plan to output your plan to apply it later.

    $ terraform plan

You can execute ```apply``` command, this command will deploy or applies your configuration.

    $ terraform apply

If you would like to remove / delete the resources which has been launched, you can execute the destroy command. This command will destroy your Infrastructure.

    $ terraform destroy
   
