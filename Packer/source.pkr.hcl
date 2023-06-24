source "vsphere-iso" "build_image" {
    # vCenter Connection Info
    vcenter_server      = local.vc_host
    username            = local.vc_user
    password            = local.vc_pwd
    datacenter          = local.vc_datacenter
    #cluster             = local.vc_cluster
    datastore           = local.vc_datastore
    
    # Extra Info
    insecure_connection = true
    destroy             = true

    # Template Info
    convert_to_template = true
    content_library_destination {
      library           = local.library
      destroy           = false
      ovf               = true
    }

    # Image Source
    #iso_url             = var.image_url
    iso_checksum        = var.image_checksum
    iso_paths           = ["${local.local_path}/${var.iso_dist}/${var.iso_name}"]
    folder              = "${local.vm_path}/${var.iso_dist}/${var.vm_name}"
    
    # SSH Connection Info
    communicator        = "ssh"
    ssh_pty             = true
    ssh_username        = local.ssh_user
    ssh_password        = local.ssh_pwd
    ssh_timeout         = "45m"
    
    ## VM Configuration
    host                = local.esxi_ip
    vm_name             = "${var.vm_name}-${var.iso_dist}"
    firmware            = "bios"
    guest_os_type       = var.os_type
    
    # VM build Conf
    CPUs                = var.vcpu
    cpu_cores           = var.core
    RAM                 = var.ram  # In Mo (4096 = 4Go)
    video_ram           = 4096     # In Ko (4096 = 4Mo)

    # VM Disk conf
    disk_controller_type = ["lsilogic-sas"]
    storage {
      disk_size         = var.disk_size # In Mo (40000 = 40Go)
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
    shutdown_command    = "echo ${local.ssh_root_pwd} | su - root -c \"systemctl poweroff\""

    # Boot commands
    boot_wait           = "3s"
    #http_directory      = "./http"
    
    boot_command        = [   # This is for a Debian 11.6 build 
      "<wait3s><esc><wait>", "/install.amd/vmlinuz ", "auto=true ", "language=en ",
      "country=FR ", "locale=fr_FR.UTF-8 ", "keymap=fr ", "interface=auto ", "vga=788 ",
      "url=ftp://${local.ftp_user}:${local.ftp_pwd}@${local.ftp_host}/${local.ftp_seed} ",
      #"url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
      "hostname=${var.vm_name} ", "domain=${var.domain_name} ",
       "initrd=/install.amd/initrd.gz ", "noprompt quiet --<enter>"
    ]
}
