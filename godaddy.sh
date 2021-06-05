#!/bin/sh

key=`cat /etc/godaddyDdns/gd.conf|head -n 1`
name=`cat /etc/godaddyDdns/gd.conf|tail -n 1`
domain=`cat /etc/godaddyDdns/gd.conf|head -n 2|tail -n 1`
currentIP=`curl -s https://api.ipify.org`
cacheIP=`cat /tmp/godaddyCacheIP.txt`
if [ -z "$cacheIP" ] ; then
	cacheIP="None"
fi
echo current IP address is $currentIP
echo cache IP address is $cacheIP
if [ "$currentIP" != "$cacheIP" ] ; then
	echo Ip address change, calling API.
else
	echo Ip address has no change since last update, no update required.
	exit 1
fi


#dnsIP=`curl -kLsH"Authorization: sso-key ${key}" -H"Content-type: application/json" https://api.godaddy.com/v1/domains/${domain}/records/A/${name}|grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
#echo curl -kLsH"Authorization: sso-key ${key}" -H"Content-type: application/json" https://api.godaddy.com/v1/domains/${domain}/records/A/${name}|grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'

#echo dns ip address is $dnsIP
#if [ "${dnsIP}" -eq "${currentIP}" ] ; then
#	echo Ip address are same, no update required.
#else
echo calling API for change...
curl -kLsXPUT -H"Authorization: sso-key ${key}" -H"Content-type: application/json" https://api.godaddy.com/v1/domains/${domain}/records/A/${name} -d "[{\"data\":\"${currentIP}\",\"ttl\":600}]" 2>/dev/null
echo $currentIP>/tmp/godaddyCacheIP.txt
echo ipaddress updated.
#fi