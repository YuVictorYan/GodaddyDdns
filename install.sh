#!/bin/sh

#global variables

confPath=/etc/godaddyDdns
confName=$confPath/gd.conf

create_config_file(){
	echo creating configration path at $confPath ...
	sudo mkdir -p $confPath

	echo createing configration file for your API ...
	if [ ! -f $confName ]; then
		read -p 'API Secret is: ' secret
		read -p 'API Key is: ' key
		read -p 'Domain(e.g.:lyorz.com): ' domain
		read -p 'Domain name (e.g.:www): ' name
		echo $key:$secret>$confName
		echo $domain>>$confName
		echo $name>>$confName
	else
		echo config exist skip create configration file.
	fi

}


create_config_file

