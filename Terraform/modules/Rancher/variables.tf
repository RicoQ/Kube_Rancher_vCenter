### Global Info
# variable root_path
variable "esxi_host" {
  description = "Value of the ip/url for the vsphere server"
  type        = string
}
variable "vm_path" {
  description = "Directory where the vm is to be created. (is relative to the datastore)"
  type        = string
  default     = "/VM"
}

## vCenter Info ##
variable "vc_host" {
  description = "Value of the ip/url for the vCenter server"
  type        = string
}
variable "vc_user" {
  description = "Value of the user name for the vCenter"
  type        = string
}
variable "vc_pwd" {
  description = "Value of the user password for the vCenter"
  type        = string
}
variable "vc_datacenter" {
  description = "Value of the datacenter name on the vCenter"
  type        = string
}
#variable "vc_cluster" {
#  description = "Value of the cluster name. Used only with vCenter. If ESXi is standalone with no cluster use <esxi_host>"
#  type        = string
#}
variable "vc_datastore" {
  description = "Value of the datastore name"
  type        = string
}


## ESXI Info ##
variable "resource_pool" {
  description = "Value of the resource pool name"
  type        = string
  default     = "Resources"
}

### VM Info 
# Global
variable "vm_name" {
  description = " "
  type = string
}
variable "vm_info" {
  type = list(object({
    hostname = string
  }))
}
variable "ovf_name" {
  description = "Content_library name where the templete for the clone is located"
  type = string
}
variable "networks" {
  description = "Name of the network"
  type        = string
}
variable "disk_size" {
  description = " "
  type = number
}

## VM SSH Info
variable "ssh_comm" {
  description = "communicator used to connect to the vm "
  type        = string
  default     = "ssh"
}
variable "ssh_user" {
  description = "User_Name used to connect to the VM via SSH "
  type        = string
}
variable "ssh_pwd" {
  description = "User_Password used to connect to the VM via SSH"
  type        = string
}
#variable "ssh_root_pwd" {
#  description = "A plaintext password to use to for the user root"
#  type    = string
#}