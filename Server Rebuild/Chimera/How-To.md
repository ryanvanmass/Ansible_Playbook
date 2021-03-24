# How it Works
## Download and Configure Podman
Installs Podman and Cockpit as well as the intigration package

## upodder Setup
1. Downloads my customer upodder image from docker
2. Creates the `/root/Podcasts` Directory that will store all the upodder container configuration
3. Tranfers the `AddPodcast.sh` file to the destination server
4. Creates the `/root/Podcasts/.Template` Directory that will store all the template configuration
5. transfers the template configuration files to the destination server
6. Sets teh SELinux Policy to Permissive to allow Podman to make changes to the file system

## Podman Cleanup Service Setup
Transfers the preconfigured Podman Cleanup service to the destination service and starts the timer to trigger it

## Create NFS mount point
Configures the mount point for the NFS Share configured on the DeathStar

# How to use (Manual Configuration)
## System
1. Run Chimaera Ansible Playbook

## Adding Podcasts
1. run the following command
```
sh /root/Podcasts/AddPodcast.sh
```