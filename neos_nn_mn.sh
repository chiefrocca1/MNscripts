#!/bin/bash
# Only run as a root user
if [ "$(sudo id -u)" != "0" ]; then
    echo "This script may only be run as root or with user with sudo privileges."
    exit 1
fi
#
#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'
#
pause(){
  echo ""
  read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}
#
#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${NC}
  exit 1
fi
#
echo -e ${YELLOW}"Welcome to the Neos Automated Install, During this Process Please Hit Enter or Input What is Asked."${NC}
echo ""
pause
#
sudo apt-get -y update 
sudo apt-get -y upgrade
sudo apt-get -y install software-properties-common 
sudo apt-get -y install build-essential  
sudo apt-get -y install libtool autotools-dev autoconf automake  
sudo apt-get -y install libssl-dev 
sudo apt-get -y install libevent-dev 
sudo apt-get -y install libboost-all-dev 
sudo apt-get -y install libminiupnpc-dev
sudo apt-get -y install git
sudo apt-get -y install software-properties-common
sudo apt-get -y install python-software-properties
sudo apt-get -y install g++
sudo apt-get -y install pkg-config  
sudo add-apt-repository ppa:bitcoin/bitcoin 
sudo apt-get -y update 
sudo apt-get -y install libdb4.8-dev 
sudo apt-get -y install libdb4.8++-dev 
#sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5 
#sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
#sudo apt-get -y install libqrencode-dev bsdmainutils 
#
echo "Installing Fail2ban and Ufw(Firewall)"
sudo apt-get -y install fail2ban ufw
service fail2ban restart
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 44473/tcp
yes | ufw enable
sudo apt -y install git 
#
cd /var 
sudo touch swap.img 
sudo chmod 600 swap.img 
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 
sudo mkswap /var/swap.img 
sudo swapon /var/swap.img 
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~ 
#
sudo git clone https://github.com/neoscoin/neos.git 
sudo chmod -R 755 ~/neos 
cd ~/neos/ 
sudo ./autogen.sh 
sudo ./configure --disable-tests --disable-gui-tests 
sudo make 
sudo make install -y
#
for num in {1..10}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
port=$((num * 2 + 44473))
#
echo "Creating Neos system users with no-login access:"
sudo adduser --system --home /home/neos_$nn neos_$nn
#
masternode_private_key(){
  read -e -p "Please Enter Your Masternodes Private Key for node $nn:" MASTERNODE_PRIVATE_KEY
  if [ "$MASTERNODE_PRIVATE_KEY" = "" ]; then
    if [ "$masternodeprivkey" != "" ]; then
      MASTERNODE_PRIVATE_KEY="$privkey"
    else
      echo "You must enter a masternode private key!";
      masternode_private_key
    fi
  fi
}
#
masternode_private_key
#echo -e ${GREEN}"Please Enter Your Masternodes Private Key for node $nn:"${NC}
#read privkey
#
cd /home/neos_$nn
sudo mkdir /home/neos_$nn/.neos
sudo touch /home/neos_$nn/.neos/neos.conf 
echo "rpcuser=neosuser" >> /home/neos_$nn/.neos/neos.conf
echo "rpcpassword=ajsfiweja1562fsjeiw" >> /home/neos_$nn/.neos/neos.conf
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
echo "masternodeprivkey=$privkey" >> /home/neos_$nn/.neos/neos.conf
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
#
neosd -datadir=/home/neos_$nn/.neos
done
#
echo -e ${YELLOW}"Syncing Masternodes..."${NC}
sleep 5
#
for num in {1..10}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
sleep 10
until neos-cli -datadir=/home/neos_$nn/.neos mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Masternode $nn is fully synced!"${NC}
done
#
echo ""
echo -e ${GREEN}"Congrats! Your Zoomba coin Masternodes are now installed and started. Please wait from 20-30 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "The END. You can close now the SSH terminal session";
