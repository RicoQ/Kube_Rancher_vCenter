module "Bastion" {
  source = "./modules/Bastion"
  
  # Global Info
  esxi_host     = data.vsphere_host.host.id
  
  # vCenter Info 
  vc_host       = data.vault_generic_secret.vcenter_secret.data["vc_host"]
  vc_user       = data.vault_generic_secret.vcenter_secret.data["vc_user"]
  vc_pwd        = data.vault_generic_secret.vcenter_secret.data["vc_pwd"]
  vc_datacenter = data.vsphere_datacenter.dc.id
  vc_datastore  = data.vsphere_datastore.datastore.id
  resource_pool = data.vsphere_resource_pool.pool.id

  # VM Info
  vm_path        = data.vault_generic_secret.esxi_secret.data["vm_path"]
  vm_name        = "Bastion"
  vcpu            = var.vcpu
  core           = var.core
  ram            = var.ram
  disk_size      = var.disk_size
  vm_info = [
    {
      hostname   = "Bastion"
    }
  ]
  ovf_name       = "Base-Debian"
  networks       = "VM Network"

  # SSH Info
  ssh_comm      = "ssh"
  ssh_user      = data.vault_generic_secret.ssh_secret.data["bastion_ssh_user"]
  ssh_pwd       = data.vault_generic_secret.ssh_secret.data["bastion_ssh_pwd"]
}