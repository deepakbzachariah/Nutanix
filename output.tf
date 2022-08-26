output "ip_address" {
  value = nutanix_virtual_machine.vm1.nic_list_status[0].ip_endpoint_list[0].ip
}

output "VM_name" {
  value = nutanix_virtual_machine.vm1.name
}