#!/bin/bash

#checking the presence of knockd.service before attempting to copy into etc

knockd_path="/usr/lib/systemd/system/knockd.service"
target_path="kconfRule.txt"

if [ -f "$knockd_path" ];
then
 	sudo cp "$knockd_path" /etc/knockd.conf
	sudo cp "$target_path" /etc/knockd.conf
else
	echo "error : knockd.service not found"
	echo "Please enusre that you are downloaded knockd daemon."
	echo "Please install knockd daemon: [apt install knockd]"
fi

