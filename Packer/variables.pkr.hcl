### Global Info
variable "pkr_root_path" {
  description = "The directory of your Packer tamplate. The default is ./"
  type    = string
  default = "./"
}
variable "esxi_ip" {
  description = "The <host_ip> for the ESXi machine."
  type    = string
}
variable "vm_path" {
  description = "The path where the iso should be saved after download. By default will go in the packer cache, with a hash of the original filename and checksum as its name."
  type    = string
}
variable "library" {
  description = "The Library name on the vCenter where the template will be saved to. Must already exist on the vCenter."
  type    = string
}


### vCenter Connection Info
variable "vc_host" {
  description = "The <host_name>, <host_ip> or <host_url> to the ESXi machine."
  type    = string
}
variable "vc_user" {
  description = "The SSH username used to access the ESXi machine."
  type    = string
}
variable "vc_pwd" {
  description = "The SSH user password used to access the ESXi machine."
  type    = string
}
variable "vc_datacenter" {
  description = "The name of the datacenter where the VM will be stored on the ESXi machine."
  type    = string
}
#variable "vc_cluster" {
#  #only needed with vCenter with multiple hosts. when dealing with standalone esxi host use the esxi host ip/hostname as the cluster name.  
#  description = "The name of the cluster where the VM will be stored on the ESXi machine."
#  type    = string
#}
variable "vc_datastore" {
  description = "The name of the datastore where the VM will be stored on the ESXi machine."
  type    = string
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
variable "vc_local_path" {
  description = "The path where the image is stored on the vCenter."
  type    = string
  default = "[SSD] Images/ISO/"
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
  default = "Rancher_Base"
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

### SSH Info
variable "ssh_comm" {
  description = "Packer currently supports three kinds of communicators (none / ssh / winrm )" 
  type    = string
  default = "ssh"
}
variable "ssh_user" {
  description = "The username to connect to SSH with. Required if using SSH" 
  type    = string
  default = "rancher"
}
variable "ssh_pwd" {
  description = "A plaintext password to use to authenticate with SSH"
  type    = string
}
variable "ssh_root_pwd" {
  description = "A plaintext password to use to for the user root"
  type    = string
}

### Preseed Info
#variable "http_dir" {
#  description = "Path to a directory to serve using an HTTP server. The files in this directory will be available over HTTP that will be requestable from the virtual machine. This is useful for hosting kickstart files and so on. By default this is an empty string, which means no HTTP server will be started. The address and port of the HTTP server will be available as variables in boot_command."
#  type = string 
#}

# Only use the following if you have an ftp to store the preseed file 
# I was having trouble with the built-in <http_directory>, this is my workaround  
variable "ftp_usr" {
  description = "The user name used to connect to ftp "
  type = string 
  }
variable "ftp_pwd" {
  description = "The user password used to connect to ftp "
  type = string 
}
variable "ftp_ip" {
  description = "The ip for the ftp "
  type = string 
}
variable "preseed_file" {
  description = "The path for the preseed file on the ftp. Note: the file should be placed in the <ftp_usr> home directory and the path starts after /home/$USER/ "
  type = string 
  default = "Rancher/preseed.cfg"
  #The default full path is translated to /home/<ftp_usr>/<Dist_Name>/preseed.cfg (make sure you have the same on your FTP)
}