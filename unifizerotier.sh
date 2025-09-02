#!/bin/bash


#if [ -z "$1" ]; then
#  echo "Error: missing networkid of zerotier"
#  exit 1
#fi

mkdir -p /config/data/firstboot/install-packages
cd /config/data/firstboot/install-packages

read -p "What type of architecture is the device using? (Enter m (mips64) or a (aarch64))" architecture
if [[ $architecture == "m" ]]
   then 
       curl https://download.zerotier.com/dist/ubiquiti/zerotier-one_mips64.deb --output /config/data/firstboot/install-packages/zerotier-one.deb
elif [[ $architecture == "a" ]]
   then
       curl https://download.zerotier.com/dist/ubiquiti/zerotier-one_arm64.deb --output /config/data/firstboot/install-packages/zerotier-one.deb

else 
    echo "wrong answere: $architecture exiting now"
    exit 1
fi

mv zerotier-one.deb zerotier-one-xz.deb
ar -x zerotier-one-xz.deb
xz --decompress control.tar.xz
xz --decompress data.tar.xz
gzip control.tar
gzip data.tar
ar -r zerotier-one.deb debian-binary control.tar.gz data.tar.gz
sudo dpkg -i zerotier-one.deb

echo "join zerotier network with command: sudo zerotier-cli join <networkid>"
#echo "joining zerotier network: $1"
#sleep 15
#sudo zerotier-cli join $1
