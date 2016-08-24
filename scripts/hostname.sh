#!/bin/bash
echo "This wil run a script to change hostname of your computer"
echo "Enter first desired computer name followed by a domain"
echo " For example we enter server1 as  computer name, and w3wing.com as a domain, we get server1.w3wing.com"
echo "Please enter computer name: "
read input_variable1
echo "Please enter domain name: "
read input_variable2
echo "You entered: $input_variable1.$input_variable2"
sed -i "1s/.*/$input_variable1/"  /root/test
ip_address=$(/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
ipa="$ip_address"
sed -i "s/$ipa/#$ipa/g" /etc/hosts
echo "$ipa $input_variable1.$input_variable2">> /etc/hosts
