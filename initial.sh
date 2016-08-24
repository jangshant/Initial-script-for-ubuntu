#!/bin/bash
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 25/tcp
ufw show added
ufw enable
dpkg-reconfigure tzdata
apt-get update
apt-get install ntp
