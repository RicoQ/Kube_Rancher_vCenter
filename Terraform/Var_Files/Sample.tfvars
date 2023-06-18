# vCenter Info
vc_host         = "<vCenter_Name>"
#vc_ip          = "<vCenter_IP>"
ssl_verify      = true # <bool>
user            = "<vCenter_User_Name>"
password        = "<vCenter_User_Password>"
datacenter      = "<Datacenter_Name>"
#cluster         = "<Cluster_Name>"
datastore       = "<Datastore_Name>"

# ESXi Info
esxi_host       = "<Esxi_name or Esxi_IP>"
resource_pool   = "<Resource_Pool_Name>"

# VM Image Info
ovf_name        = "<OVF_Name>"
vm_path         = "<Path_to_VM_folder>"
firmware        = "<boot_firmware>" # "Bios" or "efi" or "efi-secure"

# VM Info
vm_name         = "<VM_name>"
os_guest        = "<Guest_os_type>"
cpus            = 1     # <Number_of_Core>              Default is 1.
cores           = 1     # <Number_of_core_per_socket>   Default is 1. (usually same as <Number_of_Core>)
ram             = 512   # <Amount_of_RAM>               Default 512Mo.

# VM Disk Info
disk_lable      = "<Disk_Name>"
#disk_type       = "<Disk_Type>" # "thin" / "zeroedthick" / "eagerzeroedthick"
disk_size       = 16 # <Disk_Size> Default 16Go
disk_scsi_type  = "<Adaptateur_type>" # "lsilogic-sas" / "lsilogic" / "scsi" / "paravirtual"
disk_scsi_bus   = "<Sharing_bus_type>" # "physicalSharing" / "virtualSharing" / "None"

# VM Network Info
network         = "<Network_Name>"
domain          = "<Domain_Name"
vm_ipv4         = "<VM_IPv4_Address>"
vm_ipv4_mask    = 24 # <VM_IPv4_mask> Default 24
vm_dns_list     = ["0.0.0.0", "8.8.8.8"] # List(string) of Default DNS
vm_ipv4_gateway = "<Gateway_IPv4>"

# VM SSH Info
communicator    = "<Communicator_Type" #Default "ssh"
#ssh_root_pwd    = "<Template_root_password"    # Requirement: must be the same as in the preseed file used to create the Template 
ssh_user        = "<Template_user_name>"        # Requirement: must be the same as in the preseed file used to create the Template 
ssh_pwd         = "<Template_user_password>"    # Requirement: must be the same as in the preseed file used to create the Template 

# Ansible Info
#Service         = "<Ansible_Service_Name>"     # Exemple: "Gitlab"         Default "Null" 
#Service_Ver     = "<Ansible_Service_Version>"  # Exemple: "15.5.0-ee.0"    Default "Null"