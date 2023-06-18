#!/bin/bash

printf "\n ### Installing requirements ###\n"
sudo apt-get update --fix-missing && sudo apt-get -y upgrade
sudo apt-get -y install sshpass python3-pip gnupg software-properties-common ca-certificates curl wget lsb-release

printf "\n\n ################################################################### \n\n"
printf "\n ### Installing Ansible ###\n"
python3 -m pip install --user ansible

printf "\n\n ################################################################### \n\n"
printf "\n### Installing Terraform ###\n"
printf "\n# Install the HashiCorp GPG key\n"
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

printf "\n# Verify the key's fingerprint\n"
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

printf "\n# Add the official HashiCorp repository\n"
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

printf "\n# Update and install\n"
sudo apt-get update && sudo apt-get install -y terraform

printf "\n# Install the autocomplete package\n"
terraform -install-autocomplete

printf "\n\n ################################################################### \n\n"
printf "\n### Installing Packer ###\n"
printf "\n# Add the HashiCorp GPG key\n"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

printf "\n# Update and install\n"
sudo apt-get update && sudo apt-get install -y packer

printf "\n\n ################################################################### \n\n"
printf "\n### Installing Docker ###\n"
printf "\n# Add Docker’s official GPG key\n"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

printf "\n#set up the docker repository\n"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

printf "\n# Update and install\n"
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

printf "\n\n ################################################################### \n\n"
printf "\n### Installing kubectl Binary ###\n"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

printf "\n### Validate the kubectl Binary ###\n"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

printf "\n### Installing kubectl ###\n"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

printf "\n\n\t\t ####################\n\t\t #       DONE       #\n\t\t ####################\n\n\n"
