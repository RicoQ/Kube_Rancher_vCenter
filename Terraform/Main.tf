provider "vsphere" {
  user           = var.vc_user
  password       = var.vc_pwd
  vsphere_server = var.vc_host

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_host" "host" {
  name = var.esxi_host 
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datacenter" "dc" {
  name = var.vc_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vc_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

#data "vsphere_cluster" "cluster" {
#  name          = var.esxi_host
#  datacenter_id = data.vsphere_datacenter.dc.id
#}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}