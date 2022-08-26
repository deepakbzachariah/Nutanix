resource "nutanix_virtual_machine" "vm1" {
  name                 = var.vm_name
  cluster_uuid         = data.nutanix_cluster.myCluster.id
  num_vcpus_per_socket = var.vcpus_per_socket
  num_sockets          = var.no_socket
  memory_size_mib      = var.Memory_in_MB

  #Commenting out this, as I think this code size is larger than the supported hence it is not working.
  #guest_customization_cloud_init_user_data = base64encode("IyEvYmluL2Jhc2gKICAgICAgICAjIGFwYWNoZSBpbnN0YWxsYXRpb24sIGVuYWJsaW5nIGFuZCBzdGF0dXMgY2hlY2sKICAgICAgICBzdWRvIHl1bSAteSBpbnN0YWxsIGh0dHBkCiAgICAgICAgc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKICAgICAgICBzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKICAgICAgICBzdWRvIHN5c3RlbWN0bCBzdGF0dXMgaHR0cGQgfCBncmVwIEFjdGl2ZQogICAgICAgICMgZmlyZXdhbGwgaW5zdGFsbGF0aW9uLCBzdGFydCBhbmQgc3RhdHVzIGNoZWNrCiAgICAgICAgc3VkbyB5dW0gaW5zdGFsbCBmaXJld2FsbGQKICAgICAgICBzdWRvIHN5c3RlbWN0bCBzdGFydCBmaXJld2FsbGQKICAgICAgICBzdWRvIHN5c3RlbWN0bCBzdGF0dXMgZmlyZXdhbGxkIHwgZ3JlcCBBY3RpdmUKICAgICAgICAjIGFkZGluZyBodHRwIGFuZCBodHRwcyBzZXJ2aWNlcwogICAgICAgIHN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tYWRkLXNlcnZpY2U9aHR0cAogICAgICAgIHN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tYWRkLXNlcnZpY2U9aHR0cHMKICAgICAgICAjIHJlbG9hZGluZyB0aGUgZmlyZXdhbGwKICAgICAgICBzdWRvIGZpcmV3YWxsLWNtZCAtLXJlbG9hZAogICAgICAgICMgYWNxdWlyaW5nIHRoZSBpcCBhZGRyZXNzIGZvciBhY2Nlc3MgdG8gdGhlIHdlYiBzZXJ2ZXIKICAgICAgICBlY2hvICJ0aGlzIGlzIHRoZSBwdWJsaWMgSVAgYWRkcmVzczoiIGBjdXJsIC00IGljYW5oYXppcC5jb21gCiAgICAgICAgIyBhZGRpbmcgdGhlIG5lZWRlZCBwZXJtaXNzaW9ucyBmb3IgY3JlYXRpbmcgYW5kIGVkaXRpbmcgdGhlIGluZGV4Lmh0bWwgZmlsZQogICAgICAgIHN1ZG8gY2hvd24gLVIgJFVTRVI6JFVTRVIgL3Zhci93d3cKICAgICAgICAjIGNyZWF0aW5nIHRoZSBodG1sIGxhbmRpbmcgcGFnZQogICAgICAgIGNkIC92YXIvd3d3L2h0bWwvCiAgICAgICAgZWNobyAnPCFET0NUWVBFIGh0bWw+JyA+IGluZGV4Lmh0bWwKICAgICAgICBlY2hvICc8aHRtbD4nID4+IGluZGV4Lmh0bWwKICAgICAgICBlY2hvICc8aGVhZD4nID4+IGluZGV4Lmh0bWwKICAgICAgICBlY2hvICc8dGl0bGU+TGV2ZWwgSXQgVXA8L3RpdGxlPicgPj4gaW5kZXguaHRtbAogICAgICAgIGVjaG8gJzxtZXRhIGNoYXJzZXQ9IlVURi04Ij4nID4+IGluZGV4Lmh0bWwKICAgICAgICBlY2hvICc8L2hlYWQ+JyA+PiBpbmRleC5odG1sCiAgICAgICAgZWNobyAnPGJvZHk+JyA+PiBpbmRleC5odG1sCiAgICAgICAgZWNobyAnPGgxPldlbGNvbWUgdG8gTGV2ZWwgVXAgaW4gVGVjaDwvaDE+JyA+PiBpbmRleC5odG1sCiAgICAgICAgZWNobyAnPGgzPlJlZCBUZWFtPC9oMz4nID4+IGluZGV4Lmh0bWwKICAgICAgICBlY2hvICc8L2JvZHk+JyA+PiBpbmRleC5odG1sCiAgICAgICAgZWNobyAnPC9odG1sPicgPj4gaW5kZXguaHRtbAo=")

  # Now we are using built in funcationility of the terraform to install the web server


  connection {
    type     = "ssh"
    user     = "root"
    password = "<password goes here>"
    host     = nutanix_virtual_machine.vm1.nic_list_status[0].ip_endpoint_list[0].ip
  }

  provisioner "remote-exec" {
    inline = [
      "yum -y install git",

      "#To aviod the protocol error",
      "yum update -y nss curl libcurl",

      "curl https://raw.githubusercontent.com/tanmaybhandge/Linux_scripts/main/webserver.sh -o script.sh",
      "sh script.sh",
    ]
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet_info.id
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.image_info.id
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
    }
  }

}
