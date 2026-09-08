#!/bin/bash
set -euo pipefail

echo $'This will run a script to change the hostname of your computer.\nEnter the desired computer name followed by a domain.\nFor example, if you enter server1 as the computer name and w3wing.com as the domain, you get server1.w3wing.com.\n'

read -r -p "Please enter computer name: " input_variable1
read -r -p "Please enter domain name: " input_variable2

if [[ -z "$input_variable1" || -z "$input_variable2" ]]; then
    echo "Error: computer name and domain name cannot be empty." >&2
    exit 1
fi

fqdn="${input_variable1}.${input_variable2}"
echo "You entered: $fqdn"

echo "Detecting primary network interface and IP address..."
default_iface=$(ip route show default | awk '/default/ {print $5; exit}')
if [[ -z "$default_iface" ]]; then
    echo "Error: could not determine the default network interface." >&2
    exit 1
fi

ip_address=$(ip -4 addr show "$default_iface" | awk '/inet /{print $2}' | cut -d/ -f1 | head -n1)
if [[ -z "$ip_address" ]]; then
    echo "Error: could not determine an IPv4 address for interface $default_iface." >&2
    exit 1
fi
echo "Using interface $default_iface with IP address $ip_address"

echo "Backing up /etc/hostname and /etc/hosts..."
sudo cp /etc/hostname /etc/hostname.bak
sudo cp /etc/hosts /etc/hosts.bak

echo "Setting hostname to $input_variable1..."
sudo hostnamectl set-hostname "$input_variable1"

echo "Updating /etc/hosts..."
sudo sed -i "\#^${ip_address}[[:space:]]#s/^/#/" /etc/hosts
{
    echo "$ip_address $fqdn $input_variable1"
    echo "127.0.0.1    localhost.localdomain localhost"
} | sudo tee --append /etc/hosts > /dev/null

echo "Done. Hostname set to $fqdn ($input_variable1)."
