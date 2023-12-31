#!/bin/bash

printf "\n #####################\n #   Running New_Install.sh    # \n #####################\n\n"
# Setting sudo privileges: (I like to be the all-mighty on my system! How about you?)
# The pressed file during the Packer install shoudld already have taken care of this
# I'm leaving the following line commented as a reminder   
#echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

# Update & Upgrade
sudo apt-get update --fix-missing && sudo apt-get -y upgrade && sudo apt-get install -y aptitude

# Add the following to ~/.bashrc
echo 'source ~/.aliases' >> ~/.bashrc
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
echo 'export PATH=$HOME/bin:/usr/local/bin:$PATH' >> ~/.bashrc
echo 'export EDITOR=nano' >> ~/.bashrc

# Add the following to ~/.aliases
cat > ~/.aliases << END
## Custom Aliases

# Aptitude
alias Apt='sudo aptitude'
alias Upgrade='Apt upgrade -y'
alias Update='Apt update'
alias UPGRADE='Update && Upgrade'
alias Install='Apt install -y'
alias Search='Apt search'
alias Purge='Apt purge --auto-remove'
alias Remove='Apt remove'

# System
alias Sys='sudo systemctl'
alias Enable='Sys enable'
alias Start='Sys start'
alias Stop='Sys stop'
alias Reload='Sys daemon-reload'
alias Restart='Sys restart'
alias Status='Sys status'
alias Service='sudo service'
alias ifconfig='sudo ifconfig'
alias iptables='sudo iptables'
alias Source='sudo source'
alias Shutdown='sudo shutdown -fh now'
alias Reboot='sudo reboot -f'
alias Python='sudo python'

# Common
alias cd..='cd ..'
alias Dir='ls -1aF'
alias LS='ls -lah'
alias Less='sudo less'
alias Find='sudo find / -name'
alias Grep='sudo grep'
alias Cat='sudo cat'
alias Tail='sudo tail -f'
alias RM='sudo rm'
alias CP='sudo cp'
alias MV='sudo mv'

# chmod & chown
alias chmod='sudo chmod'
alias Chmod='chmod'
alias CMX='chmod +x'
alias chown='sudo chown'
alias Chown='chown'
alias COU='chown $USER:$USER'
alias COR='chown root:root'

# Utilities
alias Nano='sudo nano'
alias Git='sudo git'
alias python='python3'
alias k='kubctl'
END

# source ~/.bashrc && Install some cool tools
source ~/.bashrc
sudo apt-get install -y ifupdown ufw htop net-tools ncdu wget ltrace python2.7 curl nano pkg-config git python3 python3-venv screen python3-pip
