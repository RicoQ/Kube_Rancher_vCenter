packer {
  required_version = ">= 1.7.0"
}

locals {
  # vCenter Secrets
  vc_host       = vault(var.vcenter_path, "vc_host")
  vc_user       = vault(var.vcenter_path, "vc_user")
  vc_pwd        = vault(var.vcenter_path, "vc_pwd")
  vc_datacenter = vault(var.vcenter_path, "vc_datacenter") 
  vc_cluster    = vault(var.vcenter_path, "vc_cluster")
  vc_datastore  = vault(var.vcenter_path, "vc_datastore") 
  
  # Packer Secrets
  vm_path       = vault(var.packer_path, "vm_path") 
  pkr_root      = vault(var.packer_path, "pkr_root") 

  # ESXI Secrets
  esxi_ip       = vault(var.esxi_path, "esxi_ip")
  library       = vault(var.esxi_path, "library")
  local_path    = vault(var.esxi_path, "local_path") 

  # SSH Secrets
  ssh_user      = var.vm_name != "Bastion" ? vault(var.ssh_path, "bastion_ssh_user") : vault(var.ssh_path, "rancher_ssh_user")
  ssh_pwd       = var.vm_name != "Bastion" ? vault(var.ssh_path, "bastion_ssh_pwd") : vault(var.ssh_path, "rancher_ssh_pwd")
  ssh_root_pwd  = var.vm_name != "Bastion" ? vault(var.ssh_path, "bastion_root_pwd") : vault(var.ssh_path, "rancher_root_pwd")

  # FTP Secrets 
  ftp_host      = vault(var.ftp_path, "ip_add")
  ftp_user      = vault(var.ftp_path, "user_name")
  ftp_pwd       = vault(var.ftp_path, "user_pwd")
  ftp_seed      = var.vm_name != "Bastion" ? vault(var.ftp_path, "bastion_seed") : vault(var.ftp_path, "rancher_seed")  
}