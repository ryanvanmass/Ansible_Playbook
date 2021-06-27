#!/bin/bash
#Collect Basic User information
echo "Who will be using this instance"
read EndUser

echo "Choosen Password"
read Password

Port=$(</home/$User/port.txt)

# Copy Template to new Instance
cp -r ~/Template ~/$EndUser/

# Builds VS Code Config File
echo "bind-addr: 0.0.0.0:8080" >> ~/$EndUser/config.yml
echo "auth: password" >> ~/$EndUser/config.yml
echo "password: $Password" >> ~/$EndUser/config.yml
echo "cert: false" >> ~/$EndUser/config.yml

# Build Docker Instance image
docker build -t $EndUser ~/$EndUser/Dockerfile

# Starts Docker Instance
docker run -d -p $Port:8080 --name $EndUser -v /mnt:/mnt $EndUser 