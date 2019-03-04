#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${NC}
  exit 1
fi

echo -e ${YELLOW}"Welcome to the Neos Automated Install, During this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install a Neos Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE


if [[ $AGREE =~ "y" ]] ; then

for num in {1..10}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes

echo -e ${GREEN}"Please Enter Your Masternodes Private Key for node $nn:"${NC}
read PRIV_KEY_$nn
#read -p "Enter Your Private Key for Masternode $nn: " PRIV_KEY_$nn

Done

sudo apt-get -y update 
sudo apt-get -y upgrade
sudo apt-get -y install software-properties-common 
sudo apt-get -y install build-essential  
sudo apt-get -y install libtool autotools-dev autoconf automake  
sudo apt-get -y install libssl-dev 
sudo apt-get -y install libevent-dev 
sudo apt-get -y install libboost-all-dev 
sudo apt-get install libminiupnpc-dev
sudo apt-get install git
sudo apt-get install software-properties-common
sudo apt-get install python-software-properties
sudo apt-get install g++
sudo apt-get -y install pkg-config  
sudo add-apt-repository ppa:bitcoin/bitcoin 
sudo apt-get update 
sudo apt-get -y install libdb4.8-dev 
sudo apt-get -y install libdb4.8++-dev 
#sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5 
#sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
#sudo apt-get -y install libqrencode-dev bsdmainutils 

echo "Installing Fail2ban and Ufw(Firewall)"
sudo apt-get -y install fail2ban ufw
service fail2ban restart
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 44473/tcp
yes | ufw enable
sudo apt install git 

cd /var 
sudo touch swap.img 
sudo chmod 600 swap.img 
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 
sudo mkswap /var/swap.img 
sudo swapon /var/swap.img 
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~ 

sudo git clone https://github.com/neoscoin/neos.git 
sudo chmod -R 755 ~/neos 
cd ~/neos/ 
sudo ./autogen.sh 
sudo ./configure --disable-tests --disable-gui-tests 
sudo make 
sudo make install -y

for num in {1..10}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
port=$((nn * 2 + 44473))

echo -e ${GREEN}"Please Enter Your Masternodes Private Key for node $nn:"${NC}
read PRIV_KEY_$nn

echo "Creating n Neos system users with no-login access:"
sudo adduser --system --home /home/neos_$nn neos_$nn

cd /home/neos_$nn
sudo mkdir /home/neos_$nn/.neos
sudo touch /home/neos_$nn/.neos/neos.conf 
echo "rpcuser=user"shuf -i 100000-10000000 -n 1 >> /home/neos_$nn/.neos/neos.conf
echo "rpcpassword=pass"shuf -i 100000-10000000 -n 1 >> /home/neos_$nn/.neos/neos.conf
echo "rpcallowip=127.0.0.1" >> /home/neos_$nn/.neos/neos.conf
echo "rpcport=$((port - 1))" >> /home/neos_$nn/.neos/neos.conf
echo "bind=$(hostname  -I | cut -f1 -d' ')" >> /home/neos_$nn/.neos/neos.conf
echo "daemon=1" >> /home/neos_$nn/.neos/neos.conf
echo "server=1" >> /home/neos_$nn/.neos/neos.conf
echo "port=$port" >> /home/neos_$nn/.neos/neos.conf
echo "listen=0" >> /home/neos_$nn/.neos/neos.conf
echo "masternode=1" >> /home/neos_$nn/.neos/neos.conf
echo "logtimestamps=1" >> /home/neos_$nn/.neos/neos.conf
echo "maxconnections=250" >> /home/neos_$nn/.neos/neos.conf
echo "masternodeprivkey=$PRIV_KEY_$nn" >> /home/neos_$nn/.neos/neos.conf
echo "externalip=$(hostname  -I | cut -f1 -d' ')" >> /home/neos_$nn/.neos/neos.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):44473" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=149.56.70.224" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=158.69.95.57" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=167.114.117.178" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=194.59.251.74" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=221.156.137.1" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=221.156.137.241" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=221.156.137.4" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=23.108.108.67" >> /home/neos_$nn/.neos/neos.conf
echo "addnode=54.36.172.184" >> /home/neos_$nn/.neos/neos.conf

neosd -datadir=/home/neos_$nn/.neos

echo "Syncing Masternode $nn ...";
done

sleep 10

for num in {1..10}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
sleep 10
until neos-cli -datadir=/home/neos_$nn/.neos mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Masternode $nn is fully synced!"${NC}
done

echo ""
echo -e ${GREEN}"Congrats! Your Zoomba coin Masternodes are now installed and started. Please wait from 20-30 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "The END. You can close now the SSH terminal session";

echo -e ${GREEN}"Congrats! Your $nn Masternode is now installed and has started. Please wait from 10-60 minutes in order to give the masternode enough time to sync, then start the node from your Windows wallet."${NC}

done

fi