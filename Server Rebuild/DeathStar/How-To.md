# How it works
## Downloading Scripts for Setting up OpenVPN and PiHole
Downloads the setup and configuration scripts for OpenVPN and Pihole

## Set SELinux Policy
Sets the SELinux Policy to permisive mode so that PiHole will run

## Configure NFS
Configures and NFS Share to be utilized for Transferring Podcasts from the Chimaera to Slave1

# How to use (Manual Configuration)
## Ansible
1. Install Ansible
```
dnf install ansible
```
2. Generate SSH Keys
```
ssh-keygen
```
3. Copy Anasible Server Public key to `~/.ssh/authorized_keys` file on destination servers
4. Add Destination Servers ip to `/etc/ansible/hosts`

## OpenVPN
Guide: https://docs.pi-hole.net/guides/vpn/installation/
1. Execute Setup Script
```
sh /root/openvpn-install.sh
```
2. Select UDP
3. Use Port 1194
4. select Google for DNS
5. name the first client the hostname of the server

## Pihole
1. reboot for configuration change to take effect
2. Run the following `touch /etc/sysconfig/network-scripts/ifcfg-tun0`
3. Download and Execute Setup Script
```
curl -sSL https://install.pi-hole.net | PIHOLE_SKIP_OS_CHECK=true sudo -E bash
```
4. select tun0
5. Select Google
6. accept defualt
7. accept Defualt
8. set the IP address as 10.8.0.1 and the gateway to be the public ip of the server
9. Accept Defaults
10. Accept Defaults
11. Accept Defaults
12. Accept Defaults
13. edit `/etc/openvpn/server/server.conf`to reflect the following
```
push "dhcp-option DNS 10.8.0.1"
#push "dhcp-option DNS 8.8.8.8"
```
14. Login to web portal and change password

## Podcast_Sync
1. Edit `/etc/systemd/system/Podcast_Sync.service` to update the IP addess of the rsync command to the VPN IP of the Slave1