#!/bin/bash
# Install git
sudo apt install git -y

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Start Docker and add current user to Docker Group
systemctl enable --now docker
usermod -aG docker $USER

#Clones Github repo for VSCode Docker instance
git clone https://github.com/ryanvanmass/VSCode-Server ~/Template