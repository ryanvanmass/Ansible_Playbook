#!/bin/bash
echo "Playlist Name:"
read PlaylistName

echo "Playlist URL:"
read PlaylistURL

mkdir -p /media/root/FileSync/Video/$PlaylistName

echo "ExecStart=docker run --rm -v \"/media/root/FileSync/Video/$PlaylistName:/home/youtube/output\" youtubedl $PlaylistURL" >> /etc/systemd/system/docker_video.service

systemctl daemeon-reload