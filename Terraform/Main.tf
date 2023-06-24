provider "vsphere" {
  user           = data.vault_generic_secret.vcenter_secret.data["vc_user"]
  password       = data.vault_generic_secret.vcenter_secret.data["vc_pwd"]
  vsphere_server = data.vault_generic_secret.vcenter_secret.data["vc_host"]

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_host" "host" {
  name = data.vault_generic_secret.esxi_secret.data["esxi_ip"]
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datacenter" "dc" {
  name = data.vault_generic_secret.vcenter_secret.data["vc_datacenter"]
}

data "vsphere_datastore" "datastore" {
  name          = data.vault_generic_secret.vcenter_secret.data["vc_datastore"]
  datacenter_id = data.vsphere_datacenter.dc.id
}

#data "vsphere_cluster" "cluster" {
#  name          = data.vault_generic_secret.vcenter_secrets.data["vc_cluster"]
#  datacenter_id = data.vsphere_datacenter.dc.id
#}

data "vsphere_resource_pool" "pool" {
  name          = data.vault_generic_secret.esxi_secret.data["esxi_pool"]
  datacenter_id = data.vsphere_datacenter.dc.id
}