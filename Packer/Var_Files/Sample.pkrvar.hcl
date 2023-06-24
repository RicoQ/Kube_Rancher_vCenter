##########################################################################
# For more details on each variables below refer to the descriptions 
# contained in the "variables.pkr.hcl" file
##########################################################################

#############################
# Vault Info
#############################

vault_url       = "<Vault Server URL>"
vault_token     = "<Vault Server Token>"
vcenter_path    = "<Vault Secrets Path for vCenter>"
esxi_path       = "<Vault Secrets Path for esxi>"
ssh_path        = "<Vault Secrets Path for ssh>"
packer_path     = "<Vault Secrets Path for packer>"
ftp_path        = "<Vault Secrets Path for ftp>"

#############################
# Image Info
#############################

#image_url       = "https://cdimage.debian.org/cdimage/archive/11.7.0/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso"
image_checksum  = "SHA256:eb3f96fd607e4b67e80f4fc15670feb7d9db5be50f4ca8d0bf07008cb025766b"
iso_name        = "debian-11.7.0-amd64-netinst.iso"
iso_dist        = "Debian"

#############################
# VM Info
#############################

# Global
vm_name         = "<vm_name>"
vcpu            = 4
core            = 4 
ram             = 4096
disk_size       = 40000
os_type         = "debian11_64Guest"

# Network 
networks        = "<Network name on the vcenter>"
domain_name     = "<Domain name>"

#############################
# Preseed Info
#############################
#http_dir        = "./http/"