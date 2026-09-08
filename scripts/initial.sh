#!/bin/bash
set -euo pipefail

echo "Initializing firewall"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 25/tcp
sudo ufw show added
sudo ufw --force enable

echo "Initializing timezone"
sudo dpkg-reconfigure tzdata

echo "Initializing update"
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install chrony

echo "all done"
