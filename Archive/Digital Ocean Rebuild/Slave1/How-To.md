# How it Works





# How to Use (Manual Configuration)
## Drive Mount
1. Add the following lines to ``/etc/fstab`
```
#Main Network Drive
UUID="C8BA10BDBA10A9C8" /mnt/NetworkShares      auto    defualts        0       2
#Back Up Drive
UUID="DA783ECE783EA961" /mnt/BackUp     auto    defualts        0       2
```

## Static IP
1. run the following command
```
nmcli connection modify $Interface ipv4.method manual ipv4.address $IPAdress/24 ipv4.gateway $Gateway ipv4.dns 8.8.8.8
```
2. Restart NetworkManager
```
systemctl restart NetworkManager
```
**Optional:** If connecting to Wifi run the following
```
nmcli device wifi connect $Network password $Password
```

## Playbook Prep
1. run the following command on a computer equipt with a web browser
```
rclone authorize "onedrive"
```
2. insure you know the local Ip network
3. run the playbook