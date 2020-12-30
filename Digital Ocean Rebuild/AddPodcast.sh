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

### Create Podman Cron Job ###
crontab -l | { cat; echo "# $PodcastName"; } | crontab -
crontab -l | { cat; echo "0 0-23 * * * podman run --volume /root/Podcasts/$PodcastName:/mnt/Host --rm docker.io/ryanvanmass/do_upodder:v1 sh /mnt/Host/Automation.sh"; } | crontab -
crontab -l | { cat; echo "0 0-23 * * * mkdir -p /media/root/PodcastSync/$PodcastName && mv /root/Podcasts/$PodcastName/*.mp3* /media/root/PodcastSync/$PodcastName"; } | crontab -
crontab -l | { cat; echo " "; } | crontab -