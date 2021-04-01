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
install_update_script(){
execution_path=/usr/share/godaddyDdns
  mkdir -p ${execution_path}
  curl -s https://raw.githubusercontent.com/YuVictorYan/GodaddyDdns/main/godaddy.sh> $execution_path/godaddyDdns.sh
  chmod +x $execution_path/godaddyDdns.sh
  echo "*/5 * * * * root ${execution_path}/godaddyDdns.sh >/var/log/godaddyDdns.log 2>&1"

}

create_config_file
install_update_script
