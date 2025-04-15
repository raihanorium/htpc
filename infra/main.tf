# terraform {
#   required_providers {
#     proxmox = {
#       source = "Telmate/proxmox"
#       version = "3.0.1-rc8"
#     }
#   }
# }
#
# provider "proxmox" {
#   pm_api_url      = "https://10.11.1.59:8006/api2/json"
#   pm_api_token_id = "terraform"
#   pm_api_token_secret = "f8eeb142-58c0-40b5-aee9-efd635b6db2d"
#   pm_tls_insecure = true
# }
#
# # resource is formatted to be "[type]" "[entity_name]" so in this case
# # we are looking to create a proxmox_vm_qemu entity named test_server
# resource "proxmox_vm_qemu" "test_server" {
#   count = 1 # just want 1 for now, set to 0 and apply to destroy VM
#   name = "test-vm-${count.index + 1}" #count.index starts at 0, so + 1 means this VM will be named test-vm-1 in proxmox
#   # this now reaches out to the vars file. I could've also used this var above in the pm_api_url setting but wanted to spell it out up there. target_node is different than api_url. target_node is which node hosts the template and thus also which node will host the new VM. it can be different than the host you use to communicate with the API. the variable contains the contents "prox-1u"
#   target_node = var.proxmox_host
#   # another variable with contents "ubuntu-2004-cloudinit-template"
#   clone = var.template_name
#   # basic VM settings here. agent refers to guest agent
#   agent = 1
#   os_type = "cloud-init"
#   cores = 2
#   sockets = 1
#   cpu = "host"
#   memory = 2048
#   scsihw = "virtio-scsi-pci"
#   bootdisk = "scsi0"
#   disk {
#     slot = 0
#     # set disk size here. leave it small for testing because expanding the disk takes time.
#     size = "10G"
#     type = "scsi"
#     storage = "local-zfs"
#     iothread = 1
#   }
#
#   # if you want two NICs, just copy this whole network section and duplicate it
#   network {
#     model = "virtio"
#     bridge = "vmbr0"
#   }
#   # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
#   lifecycle {
#     ignore_changes = [
#       network,
#     ]
#   }
#
#   # the ${count.index + 1} thing appends text to the end of the ip address
#   # in this case, since we are only adding a single VM, the IP will
#   # be 10.98.1.91 since count.index starts at 0. this is how you can create
#   # multiple VMs and have an IP assigned to each (.91, .92, .93, etc.)
#   ipconfig0 = "ip=10.98.1.9${count.index + 1}/24,gw=10.98.1.1"
#
#   # sshkeys set using variables. the variable contains the text of the key.
#   sshkeys = <<EOF
#   ${var.ssh_key}
#   EOF
# }