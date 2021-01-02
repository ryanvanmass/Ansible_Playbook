#!/bin/bash
### Collect Podcast Information ###
echo "What is the Podcast Name?"
read PodcastName

echo "What is the RSS Feed for the Podcast?"
read RSSFeed

### Create Podcast Folder ###
mkdir /root/Podcasts/$PodcastName
mkdir /root/Podcasts/$PodcastName/.upodder

### Copy upodder template files to Podcast Folder and Configures them###
cp /root/Podcasts/.Template/* /root/Podcasts/$PodcastName/.upodder

echo $RSSFeed >> /root/Podcasts/$PodcastName/.upodder/subscriptions

### Creates Automation.sh file ###
echo "#!/bin/bash" >> /root/Podcasts/$PodcastName/Automation.sh

echo "### Runs upodder ###" >> /root/Podcasts/$PodcastName/Automation.sh
echo "upodder -b /mnt/Host/.upodder -p /mnt/Host" >> /root/Podcasts/$PodcastName/Automation.sh
echo " " >> /root/Podcasts/$PodcastName/Automation.sh

### Creates AutomationP2.sh ###
echo " #!/bin/bash" >> /root/Podcasts/$PodcastName/AutomationP2.sh
echo " mkdir -p /media/root/PodcastSync/$PodcastName" >> /root/Podcasts/$PodcastName/AutomationP2.sh
echo " mv /root/Podcasts/$PodcastName/*.mp3* /media/root/PodcastSync/AskNoah" >> /root/Podcasts/$PodcastName/AutomationP2.sh
echo " rm -rf /root/Podcasts/$PodcastName/*.mp3*" >> /root/Podcasts/$PodcastName/AutomationP2.sh

### Create Systemd Service File ###
echo "[Unit]" >> /etc/systemd/system/"Podman_$PodcastName.service"
echo "Description=AskNoahPodman" >> /etc/systemd/system/"Podman_$PodcastName.service"

echo " " >> /etc/systemd/system/"Podman_$PodcastName.service"

echo "[Service]" >> /etc/systemd/system/"Podman_$PodcastName.service"
echo "Type=oneshot" >> /etc/systemd/system/"Podman_$PodcastName.service"
echo "ExecStart=podman run --volume /root/Podcasts/AskNoah:/mnt/Host --rm docker.io/ryanvanmass/do_upodder:v1 sh /mnt/Host/Automation.sh" >> /etc/systemd/system/"Podman_$PodcastName.service"
echo "ExecStart= sh /root/Podcasts/AskNoah/AutomationP2.sh" >> /etc/systemd/system/"Podman_$PodcastName.service"
echo "WorkingDirectory=/" >> /etc/systemd/system/"Podman_$PodcastName.service"

### Create Systemd Timer File ###
echo "[Unit]" >> /etc/systemd/system/"Podman_$PodcastName.timer"
echo "Description=AskNoahPodman" >> /etc/systemd/system/"Podman_$PodcastName.timer"

echo " " >> /etc/systemd/system/"Podman_$PodcastName.timer"

echo "[Timer]" >> /etc/systemd/system/"Podman_$PodcastName.timer"
echo "OnCalendar=hourly" >> /etc/systemd/system/"Podman_$PodcastName.timer"
echo "Persistent=true" >> /etc/systemd/system/"Podman_$PodcastName.timer"

echo " " >> /etc/systemd/system/"Podman_$PodcastName.timer"

echo "[Install]" >> /etc/systemd/system/"Podman_$PodcastName.timer"
echo "WantedBy=timers.target" >> /etc/systemd/system/"Podman_$PodcastName.timer"

### Reload systemd daemeon and start the timer ###
systemctl daemon-reload
systemctl enable --now $PodcastName.timer


### Create Podman Cron Job ###
#crontab -l | { cat; echo "# $PodcastName"; } | crontab -
#crontab -l | { cat; echo "0 0-23 * * * podman run --volume /root/Podcasts/$PodcastName:/mnt/Host --rm docker.io/ryanvanmass/do_upodder:v1 sh /mnt/Host/Automation.sh"; } | crontab -
#crontab -l | { cat; echo "0 0-23 * * * mkdir -p /media/root/PodcastSync/$PodcastName && mv /root/Podcasts/$PodcastName/*.mp3* /media/root/PodcastSync/$PodcastName"; } | crontab -
#crontab -l | { cat; echo " "; } | crontab -