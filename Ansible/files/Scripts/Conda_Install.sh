#!/bin/bash

# function to intall conda
function conda() {
   # Install required packages
   sudo apt-get install -y python3 wget nano git python3-pip

   # Download Anaconda
   # see https://repo.anaconda.com/archive/ (for updates)
   wget -O /tmp/Anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh

   # Install Anaconda
   bash /tmp/Anaconda3.sh
}
printf "\n #####################\n #  Installing Conda  # \n #####################\n\n"

conda

echo -e "\n\n ######################################################################################### \n"
echo -e "\n !!! Attention !!!! = You need to Exit the terminal for the Conda Environment to take effect"
echo -e "\n\n ######################################################################################### \n\n"
# Exit
exit
