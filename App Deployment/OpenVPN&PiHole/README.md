## System Requirements
**OS:** Ubuntu

**VPS:** DigitalOcean

### Services
* OpenVPN
* PiHole
* NFS

## Setup
### Ansible
1. Install Ansible
```
    apt install ansible
```
2. Generate SSH Keys
```
    ssh-keygen
```
3. Copy Ansible Server Public key to `~/.ssh/authorized_keys` file on destination servers
4. Add Destination Servers ip to `/etc/ansible/hosts`

### Playbook
Run the DeathStar Ansible Playbook
```
    ansible-playbook Deploy.yml
```

### OpenVPN
Guide: https://docs.pi-hole.net/guides/vpn/installation/
1. Execute Setup Script
```
sh /root/openvpn-install.sh
```
2. Select UDP
3. Use Port 1194
4. select Google for DNS
5. name the first client the hostname of the server

### Pihole
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

### File_Sync
Is a pre-configured Service that can be used as a template for syncing content between a NAS on your Local Network and your cloud deployment