#!/bin/bash

function Update() {
  printf "\n #####################   Update & Upgrade  #####################\n\n"
  sudo apt-get update --fix-missing && sudo apt-get -y upgrade
}

function Test() {
  printf "\n #####################   Testing Bash  #####################\n\n"
  ~/Scripts/Setup/Bash_Test.sh
}

function Prep() {
  printf "\n #####################\n #   Getting  Ready   # \n #####################\n\n"

  sudo apt-get update --fix-missing && sudo apt-get -y upgrade && sudo apt-get install -y lsb-release && apt-get clean all

  echo -e "\nCreating Folders\n"
  mkdir -p ~/Scripts/Setup

  echo -e "\nMoving all Scripts to the proper Folder\n"
  mv ~/*.sh ~/Scripts/Setup

  echo "Making all the Scripts Executable"
  sudo chmod +x ~/Scripts/Setup/*.sh
}

function run() {
  if [ $? -eq 0 ]; then
    for arg in "$@"; do
      if [ "$arg" == "-u" ]; then
        Update
      elif [ "$arg" == "-T" ]; then
        Test
      elif [ "$arg" == "-I" ]; then
        if [ -d ~/Scripts ] && [ -f ~/.aliases ]; then
          printf "\n ##############################\n # Install was already Run Once # \n ##############################\n\n"
          printf "\n ### Skipping New_Install\n\n "
        else
          if [ -d ~/Scripts ]; then
            printf "\n ### Skipping Prep\n\n "
            ~/Scripts/Setup/New_Install.sh
          else
            Prep
            ~/Scripts/Setup/New_Install.sh
          fi
        fi
      elif [ "$arg" == "-C" ]; then
        if [ -d ~/anaconda3 ] && [ -d ~/.conda ]; then
          printf "\n ##############################\n # Install was already Run Once # \n ##############################\n\n"
          printf "\n ### Skipping Conda_Install\n\n "
        else
          ~/Scripts/Setup/Conda_Install.sh
          exit 0
        fi
      elif [ "$arg" == "-L" ]; then
        List
      elif [ "$arg" == "-U" ]; then
        if [ -f ~/.aliases ]; then
          ~/Scripts/Setup/Utiles_Install.sh
        else
          printf "\n [--Install | -I] is required. And it is also recommended (but optional) to run [--Conda | -C] and exit the terminal Once, before installing the Utilities \n\n"
        fi
      fi
    done
  else
    echo -e "\n\n ### !!!! The bash Script encountered an error !!!! ### \n\n"
    echo -e "\n Fix the error and try again \n"
    exit 1
  fi
  exit 0
}

function List() {
  list=("ifupdown" "ufw" "htop" "net-tools" "ncdu" "wget" "ltrace" "python2.7" "curl" "nano" "pkg-config" "git" "python3" "python3-venv" "screen" "python3-pi")
  echo " "
  echo " ##################################### "
  echo "           List of Utilities           "
  echo " "
  for item in "${list[@]}"; do
    echo " $item "
  done
  echo " "
  echo " ##################################### "
}

# Function to handle command line arguments and initialize variables
init_var() {
  if [[ $# -eq 0 ]]; then
    echo " "
    echo "## Not enough arguments"
    echo " "
    help_msg
    exit 1
  elif [[ $# -gt 3 ]]; then
    echo " "
    echo "## Too many arguments"
    echo " "
    help_msg
    exit 1
  fi

  while [[ $# -gt 0 && $# -lt 4 ]]; do
    case "$1" in
      "--update" | "-u")
        update="-u"
        ;;
      "--test" | "-T")
        test="-T"
        ;;
      "--list" | "-L")
        list="-L"
        ;;
      "--install" | "-I")
        insta="-I"
        ;;
      "--conda" | "-C")
        conda="-C"
        ;;
      "--Utils" | "-U")
        utils="-U"
        ;;
      "--help" | "-H" | "-h")
        help_msg
        exit 0
        ;;
      *)
        echo " "
        echo "## Invalid argument: $1"
        echo " "
        help_msg
        exit 1
        ;;
    esac
    shift
  done

  run "$test" "$update" "$list" "$insta" "$conda" "$utils"
}

# Function to display help message
help_msg() {
  echo ""
  echo "Usage: Setup.sh [options]"
  echo ""
  echo "Options:"
  echo "     [--update  | -u]   = Command: sudo apt-get update --fix-missing && sudo apt-get -y upgrade"
  echo "     [--test  | -T]     = Run the Bash_Test.sh: A simple script that only does two 'printf' "
  echo "     [--install | -I]   = Install a few utilities and modify the .bashrc file"
  echo "     [--conda | -C]     = Install Conda"
  echo "     [--utils | -U]     = Install Ansible, Packer, Terraform & Docker"
  echo "     [--list | -L]      = Show the full list of the utilities being installed with [--install | -I]"
  echo "     [--help | -H | -h] = Shows this help text"
  echo ""
}

# Initialize variables and handle command line arguments
init_var "$@"
