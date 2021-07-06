# Slave1
## Services
* NFS
* Samba
* Rclone
* Cockpit
* Hugo Server

## Setup and Prep to run the Playbook
### Drive Mount
1. Add the following lines to `/etc/fstab`

```
#Main Network Drive
UUID="C8BA10BDBA10A9C8" /mnt/NetworkShares      auto    defualts        0       2
#Back Up Drive
UUID="DA783ECE783EA961" /mnt/BackUp     auto    defualts        0       2
```

### Static IP
Optional: To Connect to Wifi Run the following

```
	nmcli device wifi rescan
	nmcli device wifi list
	nmcli device wifi connect $Network password $Password
```

1. run the following command

```
	nmcli connection modify $Interface ipv4.method manual ipv4.address $IPAdress/24 ipv4.gateway $Gateway ipv4.dns 8.8.8.8
```

2. Restart NetworkManager

```
	systemctl restart NetworkManager
```

# File Shares
1. Copy your `smb.conf` and `cockpit-file-sharing.exports` to the Config_Files on the ansible server
