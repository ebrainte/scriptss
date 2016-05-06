#!/bin/bash
if [ $# -le 1 ]
then
	echo "Usage: ./renamenic.sh oldnic newnic"
	echo "Example: ./renamenic.sh ens192 eth0"
	exit 1
fi

MACADDR="$(ifconfig -a | grep $1 | awk '{print $5}')"
LALA="$(echo $2 | cut -c 4-)"
echo "SUBSYSTEM==\"net\",ACTION==\"add\",ATTR{address}==\"$MACADDR\",NAME=\"$2\"" >> /etc/udev/rules.d/10-rename-network.rules
echo "[Match]
MACAddress=$MACADDR
[Link]
Name=$2" > /etc/systemd/network/1$LALA-$2.link
