module "Rancher" {
  source = "./modules/Rancher"
  
  # Global Info
  esxi_host     = data.vsphere_host.host.id
  
  # vCenter Info 
  vc_host       = var.vc_host
  vc_user       = var.vc_user
  vc_pwd        = var.vc_pwd
  vc_datacenter = data.vsphere_datacenter.dc.id
  vc_datastore  = data.vsphere_datastore.datastore.id
  resource_pool = data.vsphere_resource_pool.pool.id

  # VM Info
  vm_path        = var.vm_path
  vm_name        = "Rancher"
  disk_size      = var.disk_size
  vm_info = [
    {
      hostname   = "Rancher"
    }
  ]
  ovf_name      = "Rancher-Base-Debian"
  networks      = "Rancher-vnet"

  # SSH Info
  ssh_comm      = var.ssh_comm
  ssh_user      = "rancher"
  ssh_pwd       = var.rancher_ssh_pwd
}