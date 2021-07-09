# Slave1
## Role
Primary File Server

## Services
* NFS
* Samba
* Rclone
* Cockpit
* Hugo Server
* ZFS

## Setup and Prep to run the Playbook
### Drive Mount
1. Add the following lines to `/etc/fstab`

```
#Main Network Drive
UUID="C8BA10BDBA10A9C8" /mnt/NetworkShares      auto    defualts        0       2
#Back Up Drive
UUID="DA783ECE783EA961" /mnt/BackUp     auto    defualts        0       2
```

### File Shares
1. Copy your `smb.conf` and `cockpit-file-sharing.exports` to the Config_Files on the ansible server
2. Run the Playbook

##Change Log
* Trasition from Traditional SMB Config to Cockpit-File-Sharing
* Trasition from Traditional NFS Config to Cockpit-File-Sharing
* Add ZFS Config
* Add ZFS Manger Cockpit Module
* Add Cockpit-File-Sharing Module
* Add Cockpit-Navigator
* Build Podman Image for Hugo (Hugo is not packaged for EPEL8)
* Add Cron Job to Load ZFS Module at boot
* Add Task to build Hugo Container