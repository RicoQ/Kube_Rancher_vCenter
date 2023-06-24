<a href="https://terraform.io">
    <img src="./Terraform/.terraform.png" alt="Terraform logo" title="Terraform" align="left" height="100" />
</a>
<b href="https://www.packer.io/">
    <img src="./Packer/.packer.png" alt="Packer logo" title="Packer" align="center" height="100" /> 
</b>
<c href="https://www.ansible.com/">
    <img src="./Ansible/.ansible.png" alt="Ansible logo" title="Ansible" align="center" height="80" /> 
</c>

# A Small Kubernetes Cluster (k3s - 1 nodes) created with Rancher (Made with IaC in mind)

This project is my personal play ground for using IaC in order to populate my HomeLab. Testing and Learning in the Process. I use a VMware vSphere Hypervisor (ESXi) 7.0U3g standard edition and a Debian WSL on my PC. 

**NOTE**: 
- The terraform provider for vSphere requires API write access and is therefore **not supported** for use with a free VMware vSphere Hypervisor license.

- A vCenter server is needed as some features for Terraform and Packer are not supported on a standalone ESXi. (i.e: Template cloning and ovf manipulations) I was having a lot of trouble without the vcenter providers.

- I need to start working with Vault (ansible and terraform). At the moment all my Passwords and sensible data are in plain text in a '.tfvar' and '.pkrvar.hcl', I've added this files to the .gitignore to keep them secured to my pc only... but I really need to get familiar and use the vaults. So those tools are soon to come.

#
## What this Project does:
The project does 3 things automatically. 
- Creates 2 Base Images using Packer: 
    - Base-Debian 
    - Rancher-Base-Debian
- Install the required pakages needed using Ansible:
    - On Both servers A few small personal scripts for my use, it adds a few aliases in the user's .bashrc file as well as a few "admin sys'" utilitises such as ncdu, net-tools, ltrace, git, screen, etc... (see [Setup.sh](./Ansible/files/Scripts/Setup.sh) and [New_Install.sh](./Ansible/files/Scripts/New_Install.sh) for more details) 
    - On the Bastion Server: The Script [Utiles_Install.sh](./Ansible/files/Scripts/Utiles_Install.sh) installs : Ansible, Terraform, Packer, Docker and kubectl.
    - On the Rancher Server: Ansible installs the Rancher compatible Docker version, and the Rancher containers (k3s). 
- Creates 2 VM with Terraform using the above Images
    - A Bastion server (with Base-Debian)
    - A Rancher server (with Rancher-base-debian) 


For this project I use the following tools:

* [Terraform] https://www.hashicorp.com/products/terraform
* [Packer] https://www.packer.io/
* [Ansible] https://www.ansible.com/
* [Rancher] https://www.rancher.com/

Other Tools To be Added:
* [Vault] https://www.hashicorp.com/products/vault

## Requirements

* [Terraform 1.0+](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

* [VMware vSphere 6.5+](https://customerconnect.vmware.com/downloads/details?downloadGroup=ESXI65U3A&productId=614&rPId=102857)

* [VMware vCenter 6.5+](https://customerconnect.vmware.com/downloads/details?downloadGroup=VC65U3U&productId=614&rPId=102857)

* [Ansible 12.0+](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

* [Packer 1.8+](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)

* [ovftools 4.3+](https://docs.vmware.com/en/VMware-Telco-Cloud-Operations/1.4.0/deployment-guide-140/GUID-95301A42-F6F6-4BA9-B3A0-A86A268754B6.html)

* [Enable Remote support for Packer](https://developer.hashicorp.com/packer/plugins/builders/vmware/iso#building-on-a-remote-vsphere-hypervisor)

* [vault](https://www.vaultproject.io/)

* You need a vault sever already up en running. As a note I have it installed on my ftp. Anyway, I started using it, but I'm still having a litte touble with the "Dynamic Secrets", something is not quite right on my system... So, for now, I have a few variables in a .tfvars and .pkrvars.hcl files. Until I get the [Vault Dynamic Secrets](https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dynamic-secrets) to work properly, the below requirement is still true.  

* [Install sshpass and add 'export ANSIBLE_HOST_KEY_CHECKING=False' to your .bashrc] 
 ** This is a workaround - ~~Until I start using Vaults~~. (Important note= This is very insecure it is ok for a HomeLab, but it should never be used in a real production environement [see this ref](https://stackoverflow.com/questions/42462435/ansible-provisioning-error-using-a-ssh-password-instead-of-a-key-is-not-possibl) )

## Configurations: 
### (This section needs to be completed)
- On my system, it takes about 30 minutes to run 1 packer build and 20 minutes for the Terraform apply. (Total = 1h20m) 
- So from about 1h to 2h (depending on your system) to get the Rancher and the Bastion Up and Running on the vSphere. 
- The 2 ovf Image created by Packer are about 3Go each.

***Recommended :*** 

- 2 seperate copies of Sample.pkrvar.hcl; for the bastion and the other for Rancher.
- Also 2 seperate pressed.cfg files for each
- The Bastion server on a different Network than the Rancher server
- Minimum values for each VM:
    - CPU = 4
    - RAM = 4Go 
    - HDD = 40Go

***Required :***

- "ssh_user" and "ssh_pwd" must be the same as in the pressed.cfg file
- You need to have a Content_Library already created on your vCenter.
- Don't touch the the following 2 variables:
    - disk_thin_provisioned = false
    - disk_eagerly_scrub  = true
- Run the Packer build first
- "ovf_name" must be the output of the packer builds, Example: Base-Debian and/or Rancher-Base-Debian 

```
==> Builds finished. The artifacts of successful builds are:
--> vsphere-iso.build_image: Base-Debian
###########################################
==> Builds finished. The artifacts of successful builds are:
--> vsphere-iso.build_image: Rancher-Base-Debian
```

- Whatever VM config you decide to have for you final VM (after the Terraform apply). You'll  needs to replicated for the "Packer" build... I ran into trouble when my "Base" image had only 2 vCPU and I tried to create a VM with 4vCPU with the "clone api", I don't know why, but it only works when everything is the same, so i recommand to keeping the values as seen below... 

***Defaults VM Config: (both are the same)***
- CPU = 4
- RAM = 4Go 
- HDD = 40Go
- Video RAM = 4Mo
- Controller type = lsilogic-sas
- firmware = bios

***Planed Featured:***

- A small python script with a graphical interface: 
    - "inputs" to get all the needed data to create the config files (with ansible templating and Jinga2).
    - A button "Create" that will run all the steps from A to Z.
    - A button "Get temporary Password from Rancher" 
    - A button "Connect" to launch a browser and connect to the Rancher web interface.
- A Second small python Script to create any VM. (It is already possible by replicating one of the modules and changing a few things in the Deploy.tf, but you have to know what you are doing to make it work, this second script will make it easyer for those who don't know how :-)

## Accessing Rancher Web Interface

- In a web browser: https://<The_Rancher_ip>/ example: https://192.168.0.101/

- In a terminal on the Rancher Server you need to run this command to get the temporary password, replace <container-id> with the actual id (to find the id do: docker ps): 

```
docker logs <container-id>  2>&1 | grep "Bootstrap password:"
```

- Change the password to what you want and "Voilà" it is done!


## Contributing

* [DevOps Engineer] = Eric QUERCIA
    * https://github.com/RicoQ
    * https://www.linkedin.com/in/eric-quercia/

## License

* [VMware vSphere 7 Standard](https://store-fr.vmware.com/vmware-vsphere-standard-5655042100.html)
