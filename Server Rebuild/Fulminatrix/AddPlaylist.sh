#!/bin/bash
### Collect Playlist Information ###
echo "What is the Playlist Name?"
read PlaylistName

echo "What is the Playlist URL?"
read URL

### Create Playlist Folder ###
mkdir /root/Youtube-DL/$PlaylistName
chmod 777 /root/Youtube-DL/$PlaylistName

mkdir /root/Youtube-DL/$PlaylistName/Videos
chmod 777 /root/Youtube-DL/$PlaylistName/Videos

### Create Automation.sh File ###
echo "#!/bin/bash" >> /root/Youtube-DL/$PlaylistName/Automation.sh
echo "### Run Youtube-DL ###" >> /root/Youtube-DL/$PlaylistName/Automation.sh
echo "youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 -o '/mnt/Host/Videos/%(title)s.%(ext)s' $URL" >> /root/Youtube-DL/$PlaylistName/Automation.sh

### Create AutomationP2.sh File ###
echo "#!/bin/bash" >> /root/Youtube-DL/$PlaylistName/AutomationP2.sh
echo "mkdir -p /media/root/VideoSync/$PlaylistName" >> /root/Youtube-DL/$PlaylistName/AutomationP2.sh
echo "mv /root/Youtube-DL/$PlaylistName/*.mp4* /media/root/VideoSync/$PlaylistName" >> /root/Youtube-DL/$PlaylistName/AutomationP2.sh
echo "rm -rf /root/Youtube-DL/$PlaylistName/*.mp4*" >> /root/Youtube-DL/$PlaylistName/AutomationP2.sh

### Create Systemd Service File ###
echo "[Unit]" >> /etc/systemd/system/Podman_$PlaylistName.service
echo "Description=Podman_$PlaylistName"  >> /etc/systemd/system/Podman_$PlaylistName.service

echo " "  >> /etc/systemd/system/Podman_$PlaylistName.service

echo "[Service]"  >> /etc/systemd/system/Podman_$PlaylistName.service
echo "Type=oneshot"  >> /etc/systemd/system/Podman_$PlaylistName.service
echo "ExecStart= podman run --volume /root/Youtube-DL/$PlaylistName:/mnt/Host --rm docker.io/ryanvanmass/youtube-dl:v1 sh /mnt/Host/Automation.sh"  >> /etc/systemd/system/Podman_$PlaylistName.service
echo "ExecStart= sh /root/Youtube-DL/$PlaylistName/AutomationP2.sh"  >> /etc/systemd/system/Podman_$PlaylistName.service
echo "WorkingDirectory=/"  >> /etc/systemd/system/Podman_$PlaylistName.service

### Create Systemd Timer File ###
echo "[Unit]"  >> /etc/systemd/system/Podman_$PlaylistName.timer
echo "Description=Podman_$PlaylistName"  >> /etc/systemd/system/Podman_$PlaylistName.timer

echo " "  >> /etc/systemd/system/Podman_$PlaylistName.timer

echo "[Timer]"  >> /etc/systemd/system/Podman_$PlaylistName.timer
echo "OnCalendar=hourly"  >> /etc/systemd/system/Podman_$PlaylistName.timer
echo "Persistent=true"  >> /etc/systemd/system/Podman_$PlaylistName.timer

echo " "  >> /etc/systemd/system/Podman_$PlaylistName.timer

echo "[Install]"  >> /etc/systemd/system/Podman_$PlaylistName.timer
echo "WantedBy=timers.target"  >> /etc/systemd/system/Podman_$PlaylistName.timer

### Reload systemd daemeon and start the timer ###
systemctl daemon-reload
systemctl enable --now Podman_$PodcastName.timer