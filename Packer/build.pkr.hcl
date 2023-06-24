build {    
  sources = ["sources.vsphere-iso.build_image"]

  provisioner "shell" {
    inline = [ "echo ${local.ssh_root_pwd} | su - root -c \"apt-get install -y sudo open-vm-tools perl && sed -e '26i'${local.ssh_user}' ALL=(ALL) NOPASSWD:ALL' -i /etc/sudoers\"" ]
  } 
  
  provisioner "ansible" {
    user             = local.ssh_user
    use_proxy        = false
    playbook_file    = "${local.pkr_root}/../Ansible/playbooks/main.yml"
    roles_path       = "${local.pkr_root}/../Ansible/roles"
    ansible_env_vars = [ 
      "ANSIBLE_HOST_KEY_CHECKING=False", 
      "ANSIBLE_CONFIG=${local.pkr_root}/../Ansible/ansible.cfg",
    ]
    extra_arguments  = [
      #"-vvvv",
      "-e", "PACKER=ACTIVE",
      "-e", "SERVICE=Null",
      "-e", "USER=${local.ssh_user}",
      "-e", "ansible_host=${build.Host}",
      "-e", "ansible_sudo_pass=${local.ssh_pwd}",
      "-e", "ansible_password=${local.ssh_pwd}",
    ]
  }
}