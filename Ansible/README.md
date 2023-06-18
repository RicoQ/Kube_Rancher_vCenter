<a href="https://www.ansible.com/">
    <img src=".ansible.png" alt="Ansible logo" title="Ansible" align="center" height="100" /> 
</a>


## Requirements
the following needs to be added to the ansible.cfg

```
[defaults] 
host_key_checking = False # <-- Until I start working with Vault
interpreter_python = /bin/python3
;remote_user=root
```

## README To Be Completed
So far I only have the build for Debian_11.6 available. The Playbooks can be used either with terraform, Packer or directly with Ansible. 

# Done:
* Image update (apt-get update & apt-get upgrade + somme usefull packages)
* Gitlab ee 15.5 install (I need write a proper gitlab.rb file)
* Docker install
* Minikube install (some buggs needs to be fixed)

# To be Done:

* Distribution:
    * Ubuntu 22.04 image 
    * Centos 8 image 

* Other projects:
    * Full cluster kuberetes (3 nodes) install & configurations
    * SonarQube install
    * Prometheus Stack Install (Prometjeus, Grafana, Infludb)
    * Gitlab ee version upgrade (fully automated)

* Kubernetes (and minikube) automatisation project: 
    * Kubernetes app deployment (scaling up to 3 "nginx randum app" with trafic and a Load balancer)
    * kubernetes monitoring deployment (prometheus) 


# Playbook Command Line:

```
ansible-playbook -i <inventory_file_path> -e "SERVICE=<service_name>" -e "VERSION=<service_version>" <path_to_playbook_yml_file>
```

* Exemple:
``` 
ansible-playbook -i ./hosts -e "SERVICE=Gitlab" -e "VERSION=15.5.0-ee.0" ./playbooks/main.yml
```

## Contributing

* [DevOps Engineer] = Eric QUERCIA
    * https://github.com/RicoQ
    * https://www.linkedin.com/in/eric-quercia/