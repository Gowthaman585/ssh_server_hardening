#!/bin/bash

#USER WARN!!
echo "This will completely remove the ufw and formal iptables from this system (Y/n) :"
read -r permission

#Checking the status of user permission
if [[ "$permission" == "y" || "$permission" == "Y" ]];
then
	echo "Proceeding firewall changes..."

	#remove iptables and utility-firewall
	sudo apt purge ufw -y
	sudo apt purge iptables -y
	sudo apt --fix-broken install -y
	sudo apt autoremove -y

	#installing required persistent iptables : helps to autoreboot firewalls  on boot
	sudo apt install iptables-persistent -y

	#Verifying proper installation of iptables-persistent
	sudo iptables --version

	#Flushing any defaults chains or rules in iptables
	sudo iptables -F
	sudo iptables -X
else
	echo "User permission denied"
	echo "-----------------------"
fi
