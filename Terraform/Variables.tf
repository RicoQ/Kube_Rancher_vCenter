# Vault Info
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
variable "ftp_path" {
  description = "The path within the Vault where the ftp secrets are stored."
  type        = string
}


### VM Info 
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
