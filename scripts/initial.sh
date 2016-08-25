#!/bin/bash
echo "Initializing firewall"
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 25/tcp
sudo ufw show added
sudo ufw enable
echo "Initializing timezone"
sudo dpkg-reconfigure tzdata
sudo echo "Initializing update"
sudo apt-get update
sudo apt-get -y install ntp
echo "all done"
