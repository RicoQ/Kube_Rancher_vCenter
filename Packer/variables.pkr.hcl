### Vault Info
variable "vault_url" {
  description = "The Vault's URL"
  type        = string
}
variable "vault_token" {
  description = "The Vault's access token"
  type        = string
}
variable "vcenter_path" {
  description = "The path within the Vault where the vCenter secrets are stored."
  type        = string
}
variable "esxi_path" {
  description = "The path within the Vault where the esxi secrets are stored."
  type        = string
}
variable "ssh_path" {
  description = "The path within the Vault where the ssh secrets are stored."
  type        = string
}
variable "packer_path" {
  description = "The path within the Vault where the packer secrets are stored."
  type        = string
}
variable "ftp_path" {
  description = "The path within the Vault where the ftp secrets are stored."
  type        = string
}

### Image Info 
#variable "image_url" {
#  description = " A URL to the ISO containing the installation image or virtual hard drive (VHD or VHDX) file to clone."
#  type    = string
#  default = "https://cdimage.debian.org/cdimage/archive/11.7.0/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso"
#} 
variable "image_checksum" {
  description = "The checksum for the ISO file or virtual hard drive file. The type of the checksum is specified within the checksum field as a prefix, ex: 'md5:{$checksum}'. The type of the checksum can also be omitted and Packer will try to infer it based on string length. Valid values are 'none', '{$checksum}', 'md5:{$checksum}', 'sha1:{$checksum}', 'sha256:{$checksum}', 'sha512:{$checksum}' or 'file:{$path}'."
  type    = string
  default = "SHA256:eb3f96fd607e4b67e80f4fc15670feb7d9db5be50f4ca8d0bf07008cb025766b"
}
variable "iso_name" {
  description = "The name of the iso. (must include the .<extention_name> (ie: image.iso)"
  type    = string
  default = "debian-11.7.0-amd64-netinst.iso"
}
variable "iso_dist" {
  description = "The name of image distribution."
  type    = string
  default = "Debian"
}

### VM Info
# Global
variable "vm_name" {
  description = "The Name assigned to the VM"
  type    = string
  default = "Base"
}
variable "vcpu" {
  description = "The the number of vcpus assigned to the vm"
  type = number
}
variable "core" {
  description = "Number of core assigned for the vcpu. (example: if you have 4 vcpu you can have 1, 2 or 4 cores. (i.e: 1 core = (4 vcpus x 1 core), 2 cores = (2 vcpus x 2 cores), 4 cores = (1vcpu x 4 cores)))"
  type = number
}
variable "ram" {
  description = "Amount of RAM assigned to the VM (in Mo  4096Mo = 4Go)"
  type = number
}
variable "disk_size" {
  description = "The sise of the vm's disk in Go (example 40 = 40Go)"
  type = number
}
variable "os_type" {
  description = "The guest OS type being installed. This will be set in the VMware VMX. By default this is other."
  type    = string
  default = "debian11_64Guest"
}


# Network
variable "networks" {
  description = "The custom name of the network. Sets the vmx value 'ethernet0.networkName'"
  type    = string
  default = "VM Network"
}
variable "domain_name" {
  description = "Domain Name for the VM. "
  type    = string
  default = "home"
}

### Preseed Info
#variable "http_dir" {
#  description = "Path to a directory to serve using an HTTP server. The files in this directory will be available over HTTP that will be requestable from the virtual machine. This is useful for hosting kickstart files and so on. By default this is an empty string, which means no HTTP server will be started. The address and port of the HTTP server will be available as variables in boot_command."
#  type = string 
#}
