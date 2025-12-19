# Secure your ssh server with port knocking

# This project is about implementing port-knocking on your ssh-server that allows only 
# connection from successfully knocked device ip-address and it will drop all other incoming packets.

# Port knocking :
	- The client needs to knock the server port in ['strictly'] specific port order of the server to establish a connection.
	- The knocking of successful port order of the server opens the ssh connection.
	- Unlike direct connection with the port 22 is completely restricted.

# --DISCLAIMER---
	* only test this project on a lab/test server.
	* this deletes all the iptables and their rules.

# Please keep this in mind the following set of combination are used in this project.
Server : Ubuntu 24.04.3 LTS
client : Ubuntu

# Project workflow

--- "prepare-iptables.sh"
		* Removing ufw and iptables permanently
		* Installing persistent-iptables to persist even when booting.
		* It will automatically flush the iptables for any default chain/rules

--- "cpy-rules-knockd.sh"
		* This script checks for knockd.service to check the knockd installation on server
	-- If it throws error like "knockd.service not found"
	-- Install knockd 
	-- Sudo apt install knockd
		* Again run this script, this will create a /etc/knockd.conf file to edit the conf file for this knockd-daemon.
	-- Don't make any change in the /usr/lib/systemd/system/knockd.service unless any critical situation, use the /etc/knockd.conf to config.
		* Port 6000,7000,8000 are the sequence port chosen in this conf file. you can change at anytime by altering the /etc/knockd.conf.

--- "iptables-rules.sh"
		* The first rule is to allow traffic between already established connection of client to server
		* The second rule is to allow packets from loopback address for localhost communication
		* The third rule is to DROP any packets which is not matched from the INPUT chain.

--- "kdaemon-rule.txt"
		* It's a text file where any changes you can make but ensure after changing again execute the script "cpy-rules-knockd.sh" to properly setup.
		* It contains the rules of sequence port order for knocking. After every successful knock only the particular ip-address is allowed to interact with the server, and that rule is inserted at top of the INPUT chain.

# ORDER TO EXECUTE
1- prepare-iptables.sh  
2- cpy-rules-knockd.sh  
3- iptables-rules.sh  

# After executing these commands please start the knockd daemon and restart ssh. Saving the iptables rules persistently leads to avoid continuous re-writing on every boot.
