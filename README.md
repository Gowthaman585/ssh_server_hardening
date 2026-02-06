# Secure your ssh server with port knocking
## ==============================================
This project is about implementing port-knocking on your ssh-server.
This port-knocking helps to secure our server from formal direct login's unless
A secret port's tapping before trying to login to our server 

# Port knocking :
## =================
Everytime the client who wish to connect to the ssh sever, needs to knock a particular **series of ports**
After the successful knocking on the *series of ports* in particular time period 
The client **can now allowed** to connect to our server

# DISCLAIMER
## ============
Only test this project on a **lab/test** server.
This deletes all the *iptables* and their rules.

# Please keep this in mind the following set of combination are used in this project.
Server : Ubuntu 24.04.3 LTS
client : Ubuntu

# Project workflow
## =====================
### "prepare_iptables.sh"
This bash script tends to remove ufw and install iptables-persistent.
All firewall rules are written directly into the iptables.

### "set_knockd_service.sh"
This script checks for knockd.service to check the knockd installation on server
If it throws error like "knockd.service not found"
Install knockd 
*sudo apt install knockd*
Again run this script, this will create a **/etc/knockd.conf** 
File to edit the configurations  for this knockd-daemon.
Port 6000,7000,8000 are the sequence port chosen in this conf file. 
You can change at anytime by altering the /etc/knockd.conf.

### "set_iptable.sh"
This script intended to write up three different firewall rule's
The *first rule* is to allow traffic between already established connection of client to server
The *second rule* is to **allow packets** from loopback address for localhost communication
The *third rule* is to **DROP** any packets which is not matched from the INPUT chain.

### "kdaemon-rule.txt"
This is text file which is needed by the  **set_knockd_service.sh**
Because **set_knockd_service.sh** uses the conf rules form this text file to create the knockd.service
By simple copying from this text
You can change conf details in this text file and then re-execute it.

# ORDER TO EXECUTE
1- prepare_iptables.sh  
2- set_knockd_service.sh  
3- set_iptables.sh  

*After executing all the commands don't forget to start the knockd deamon before ssh daemon *
Use this command in order to start
sudo systemctl start knockd
sudo systemctl start ssh

# HOW TO CONNECT TO THE SERVER
After executing all the scripts, you strictly restricted to directly interact with the server
So you need to follow these two steps in-order to connect
whatever the client device you may need to install the same knockd to knock the server ports
*sudo apt install knockd -y*
After installing ensure it properly installed it by checking it binaries
*which knockd*
The next steps  is to knock the server ports and then try to connect  by using the command's below
**knockd <serve-ip> 6000 7000 8000**
**ssh -p 64222 <user-name>@<server-ip>
### Now successfule ssh hardening is activated by port knocking
