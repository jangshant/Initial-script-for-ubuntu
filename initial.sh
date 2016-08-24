#!/bin/bash
echo "Initializing firewall"
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 25/tcp
ufw show added
ufw enable
echo "Initializing timezone"
dpkg-reconfigure tzdata
echo "Initializing update"
apt-get update
apt-get install ntp
echo "all done"
