#!/bin/sh
set -e

printf "docker starting install\n"

script="$(curl -sS -o- "https://get.docker.com" 2>&1)"
if [ $? -ne 0 ]; then
  echo "Failed to download docker installation script: $script"
  exit 1
fi

output="$(bash <<< "$script" 2>&1)"
if [ $? -ne 0 ]; then
  echo "Failed to install docker: $output"
  exit 1
fi

# Get the OS name
os_name=$(cat /etc/*-release | grep '^ID=' | cut -d'=' -f2)

# Check if the OS is Fedora, AlmaLinux, or Rocky Linux
if [[ "$os_name" == "fedora" ]] || [[ "$os_name" == "almalinux" ]] || [[ "$os_name" == "rocky" ]]; then
  sudo systemctl enable --now docker 2>&1
fi

printf "🥳 docker has been installed\n\n"
