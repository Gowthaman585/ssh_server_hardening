#!/bin/bash

#Rules for INPUT chain to allow already connected client trafiic packet
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#Rules to allow localhost traffic  
sudo iptables -A INPUT -i lo -j ACCEPT

#Drop any other incomming packets
sudo iptables -A INPUT -j DROP
