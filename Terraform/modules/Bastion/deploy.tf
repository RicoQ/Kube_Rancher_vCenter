data "vsphere_network" "network" {
  name          = var.networks
  datacenter_id = var.vc_datacenter
}

resource "vsphere_virtual_machine" "vm" {
  # VM Count
  count = length(var.vm_info)

  # vCenter Info
  name                 = var.vm_info[count.index].hostname
  datastore_id         = var.vc_datastore
  host_system_id       = var.esxi_host
  resource_pool_id     = var.resource_pool
  #folder   = vsphere_folder.folder.path
  
  # VM Info
  num_cpus = 4
  num_cores_per_socket = 4
  memory   = 4096
  guest_id = "debian11_64Guest"
  firmware = "bios"
  scsi_type = "lsilogic-sas"
  scsi_bus_sharing = "physicalSharing"
  
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  
  disk {
    label = "${var.vm_name}-disk1"
    thin_provisioned = false
    eagerly_scrub = true
    unit_number = 0
    size = var.disk_size
    #attach =  true
    disk_sharing = "sharingNone"
    datastore_id = var.vc_datastore
    path = "${var.vm_path}/${var.vm_name}-disk1.vmdk"
  }

  # SSH connection Info
  connection {
      host        = self.default_ip_address
      type        = var.ssh_comm
      user        = var.ssh_user
      password    = var.ssh_pwd
    }
  
  # Clone Template From Content Library
  clone {
    template_uuid = data.vsphere_content_library_item.template.id
  }

  # Add VM to the Ansible host List
  provisioner "local-exec" {
    command = "echo \"${var.vm_info[count.index].hostname} ansible_host=\"${self.default_ip_address}\" ansible_user=\"${var.ssh_user}\" ansible_password=\"${var.ssh_pwd}\"\" >> ../Ansible/Inventory.txt"
  }

 # Run Ansible playbook
 provisioner "local-exec" {
    command = "ansible-playbook -u ${var.ssh_user} -i \"${self.default_ip_address},\" -e \"USER=${var.ssh_user}\" -e \"TERRA=ACTIVE\" -e \"SERVICE=Bastion\" -e \"VERSION=1.0\" -e \"ansible_password=${var.ssh_pwd}\" -e \"ansible_sudo_pass=${var.ssh_pwd}\" ../ansible/playbooks/main.yml"
    when = create
  }
}