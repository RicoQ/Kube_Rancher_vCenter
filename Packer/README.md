<a href="https://www.packer.io/">
    <img src=".packer.png" alt="Packer logo" title="Packer" align="center" height="100" /> 
</a>


# README To Be Completed 
### (!!! There are few miner Details that I will have to add later - Right now there is juste anought to start. However, you may need to do some trial and error to get it working properly on your Infrastructure !!!)

#
This Build Creates a "Template" and adds it to the vCenter content_library. The Template can then be used by Terraform. Terraform will clone the template and create a VM from it.

* Done:
    * Debian 11.7 image build

* To be Done:
    * Debian 12 image build
    * ubuntu 22.04 image build
    * Centos 8 image build

# Prerequisites
* You need to have a Library already existing in the vCenter content_library (Default is Packer Library).
* You need to fill out the Sample.pkrvar.hcl
* If you use this Script "as is", without any changes, you need an FTP where you can store the "proceed.cfg" file. (other wise comment the "ftp vars" and uncomment the "http_dir var") 
* You also need the Image (.iso file) already uploaded on your esxi (default image path : [<datastore_name>] /images/ISO/Debian/<file>.iso) (you can use the "iso_url var" instead of "iso_path var" comment one and uncomment the other)
* "ssh_user", "ssh_pwd" and "ssh_root_pwd" must match what you put into the preceed.cfg file
* You need to have a vault server already up and running

# Build Command line:

```
packer build -var-file=./Var_Files/<file>.pkrvar.hcl .
```

### Exemple: 

```
packer build -var-file=./Var_Files/ubuntu.pkrvar.hcl .

```

## Contributing

* [DevOps Engineer] = Eric QUERCIA
    * https://github.com/RicoQ
    * https://www.linkedin.com/in/eric-quercia/