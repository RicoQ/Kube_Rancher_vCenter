source "vsphere-iso" "build_image" {
    # vCenter Connection Info
    vcenter_server      = var.vc_host
    username            = var.vc_user
    password            = var.vc_pwd
    datacenter          = var.vc_datacenter
    #cluster             = var.vc_cluster
    datastore           = var.vc_datastore
    
    # Extra Info
    insecure_connection = true
    destroy             = true

    # Template Info
    convert_to_template = true
    content_library_destination {
      library           = var.library
      destroy           = false
      ovf               = true
    }

    # Image Source
    #iso_url             = var.image_url
    iso_checksum        = var.image_checksum
    iso_paths           = ["${var.vc_local_path}/${var.iso_dist}/${var.iso_name}"]
    folder              = "${var.vm_path}/${var.iso_dist}/${var.vm_name}"
    
    # SSH Connection Info
    communicator        = var.ssh_comm
    ssh_pty             = true
    ssh_username        = var.ssh_user
    ssh_password        = var.ssh_pwd
    ssh_timeout         = "45m"
    
    ## VM Configuration
    host                = var.esxi_ip
    vm_name             = "${var.vm_name}-${var.iso_dist}"
    firmware            = "bios"
    guest_os_type       = var.os_type
    
    # VM build Conf
    CPUs                = 4
    cpu_cores           = 4
    RAM                 = 4096  # In Mo (4096 = 4Go)
    video_ram           = 4096  # In Ko (4096 = 4Mo)

    # VM Disk conf
    disk_controller_type = ["lsilogic-sas"]
    storage {
      disk_size         = 40000 # In Mo (40000 = 40Go)
      disk_thin_provisioned = false
      disk_eagerly_scrub  = true
      disk_controller_index = 0
    }   
    
    # VM Network Conf
    network_adapters {
      network           = var.networks
      network_card      = "vmxnet3"
    }

    # VM Shutdown Command
    shutdown_command    = "echo ${var.ssh_root_pwd} | su - root -c \"systemctl poweroff\""

    # Boot commands
    boot_wait           = "3s"
    #http_directory      = "./http"
    
    boot_command        = [   # This is for a Debian 11.6 build 
      "<wait3s><esc><wait>", "/install.amd/vmlinuz ", "auto=true ", "language=en ",
      "country=FR ", "locale=fr_FR.UTF-8 ", "keymap=fr ", "interface=auto ", "vga=788 ",
      "url=ftp://${var.ftp_usr}:${var.ftp_pwd}@${var.ftp_ip}/${var.preseed_file} ",
      #"url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
      "hostname=${var.vm_name} ", "domain=${var.domain_name} ",
       "initrd=/install.amd/initrd.gz ", "noprompt quiet --<enter>"
    ]
}

build {    
  sources = ["sources.vsphere-iso.build_image"]

  provisioner "shell" {
    inline = [ "echo ${var.ssh_root_pwd} | su - root -c \"apt-get install -y sudo open-vm-tools perl && sed -e '26i'${var.ssh_user}' ALL=(ALL) NOPASSWD:ALL' -i /etc/sudoers\"" ]
  } 
  
  provisioner "ansible" {
    user             = var.ssh_user
    use_proxy        = false
    playbook_file    = "${var.pkr_root_path}/../Ansible/playbooks/main.yml"
    roles_path       = "${var.pkr_root_path}/../Ansible/roles"
    ansible_env_vars = [ 
      "ANSIBLE_HOST_KEY_CHECKING=False", 
      "ANSIBLE_CONFIG=${var.pkr_root_path}/../Ansible/ansible.cfg",
    ]
    extra_arguments  = [
      #"-vvvv",
      "-e", "PACKER=ACTIVE",
      "-e", "SERVICE=Null",
      "-e", "USER=${var.ssh_user}",
      "-e", "ansible_host=${build.Host}",
      "-e", "ansible_sudo_pass=${var.ssh_pwd}",
      "-e", "ansible_password=${var.ssh_pwd}",
    ]
  }
}