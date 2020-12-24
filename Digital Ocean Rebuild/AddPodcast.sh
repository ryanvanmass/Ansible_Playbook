#!/bin/bash
### Collect Podcast Information ###
echo "What is the Podcast Name?"
read PodcastName

echo "What is the RSS Feed for the Podcast?"
read RSSFeed

### Create Podcast Folder ###
mkdir /home/ryan/Podcasts/$PodcastName
mkdir /home/ryan/Podcasts/$PodcastName/.upodder

### Copy upodder template files to Podcast Folder and Configures them###
cp /home/ryan/Podcasts/.Template/* /home/ryan/Podcasts/$PodcastName/.upodder

echo $RSSFeed >> /home/ryan/Podcasts/$PodcastName/.upodder/subscriptions

### Creates Automation.sh file ###
echo "#!/bin/bash" >> /home/ryan/Podcasts/$PodcastName/Automation.sh

echo "### Runs upodder ###" >> /home/ryan/Podcasts/$PodcastName/Automation.sh
echo "upodder -b /mnt/Host/.upodder -p /mnt/Host" >> /home/ryan/Podcasts/$PodcastName/Automation.sh
echo " " >> /home/ryan/Podcasts/$PodcastName/Automation.sh

### Create Podman Cron Job ###
crontab -l | { cat; echo "# $PodcastName"; } | crontab -
crontab -l | { cat; echo "0 0-23 * * * podman run --volume /home/ryan/Podcasts/$PodcastName:/mnt/Host --rm localhost/upodder:v3 sh /mnt/Host/Automation.sh"; } | crontab -
crontab -l | { cat; echo "0 0-23 * * * mkdir -p /media/ryan/PodcastSync/$PodcastName && mv /home/ryan/Podcasts/$PodcastName/*.mp3* /media/ryan/PodcastSync/$PodcastName"; } | crontab -
crontab -l | { cat; echo " "; } | crontab -