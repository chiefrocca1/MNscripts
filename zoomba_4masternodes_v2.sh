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

echo -e ${YELLOW}"Welcome to the Zoomba Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install a Zoomba Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE


if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key:"${NC}
read privkey
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for second node:"${NC}
read privkey2
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for third node:"${NC}
read privkey3
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for fourth node:"${NC}
read privkey4
echo "Creating 4 Zoomba system users with no-login access:"
sudo adduser --system --home /home/zoomba zoomba
sudo adduser --system --home /home/zoomba2 zoomba2
sudo adduser --system --home /home/zoomba3 zoomba3
sudo adduser --system --home /home/zoomba4 zoomba4
sudo apt-get -y update 
sudo apt-get -y upgrade
sudo apt-get -y install software-properties-common 
sudo apt-get -y install build-essential  
sudo apt-get -y install libtool autotools-dev autoconf automake  
sudo apt-get -y install libssl-dev 
sudo apt-get -y install libevent-dev 
sudo apt-get -y install libboost-all-dev 
sudo apt-get -y install pkg-config  
sudo add-apt-repository ppa:bitcoin/bitcoin 
sudo apt-get update 
sudo apt-get -y install libdb4.8-dev 
sudo apt-get -y install libdb4.8++-dev 
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5 
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils 
sudo apt install git 
cd /var 
sudo touch swap.img 
sudo chmod 600 swap.img 
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 
sudo mkswap /var/swap.img 
sudo swapon /var/swap.img 
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~ 
sudo git clone https://github.com/zoombacoin/zoomba 
sudo chmod -R 755 ~/zoomba 
cd zoomba 
sudo ./autogen.sh 
sudo ./configure --disable-tests --disable-gui-tests 
sudo make 
sudo make install
cd /home/zoomba/ 
sudo mkdir /home/zoomba/.zoomba
sudo touch /home/zoomba/.zoomba/zoomba.conf 
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5530\n#bind=$(hostname  -I | cut -f1 -d' ')\ndaemon=1\nserver=1\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey\nexternalIP=$(hostname  -I | cut -f1 -d' '):5530\naddnode=149.28.236.13\naddnode=207.246.95.9\naddnode=149.28.98.180\naddnode=70.175.112.249\naddnode=45.79.162.189\naddnode=196.52.39.2\naddnode=45.32.250.250\naddnode=108.61.206.254\naddnode=139.99.194.25\naddnode=192.210.213.180\naddnode=209.250.233.198\naddnode=167.99.94.49\naddnode=45.76.19.244\naddnode=66.42.85.90\naddnode=140.82.37.36\naddnode=80.211.40.186\naddnode=202.182.126.66\naddnode=45.77.52.55\naddnode=206.189.218.100\naddnode=95.179.160.214" >> /home/zoomba/.zoomba/zoomba.conf
cd /home/zoomba2
sudo mkdir /home/zoomba2/.zoomba
sudo touch /home/zoomba2/.zoomba/zoomba.conf 
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5534\n#bind=$(hostname  -I | cut -f1 -d' ')\ndaemon=1\nserver=1\nport=5533\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey2\nexternalIP=$(hostname  -I | cut -f1 -d' '):5530\naddnode=149.28.236.13\naddnode=207.246.95.9\naddnode=149.28.98.180\naddnode=70.175.112.249\naddnode=45.79.162.189\naddnode=196.52.39.2\naddnode=45.32.250.250\naddnode=108.61.206.254\naddnode=139.99.194.25\naddnode=192.210.213.180\naddnode=209.250.233.198\naddnode=167.99.94.49\naddnode=45.76.19.244\naddnode=66.42.85.90\naddnode=140.82.37.36\naddnode=80.211.40.186\naddnode=202.182.126.66\naddnode=45.77.52.55\naddnode=206.189.218.100\naddnode=95.179.160.214" >> /home/zoomba2/.zoomba/zoomba.conf  
cd /home/zoomba3
sudo mkdir /home/zoomba3/.zoomba
sudo touch /home/zoomba3/.zoomba/zoomba.conf 
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5536\n#bind=[$(hostname  -I | cut -f2 -d ' ')]\ndaemon=1\nserver=1\nport=5535\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey3\nexternalIP=[$(hostname  -I | cut -f2 -d' ')]:5530\naddnode=149.28.236.13\naddnode=207.246.95.9\naddnode=149.28.98.180\naddnode=70.175.112.249\naddnode=45.79.162.189\naddnode=196.52.39.2\naddnode=45.32.250.250\naddnode=108.61.206.254\naddnode=139.99.194.25\naddnode=192.210.213.180\naddnode=209.250.233.198\naddnode=167.99.94.49\naddnode=45.76.19.244\naddnode=66.42.85.90\naddnode=140.82.37.36\naddnode=80.211.40.186\naddnode=202.182.126.66\naddnode=45.77.52.55\naddnode=206.189.218.100\naddnode=95.179.160.214" >> /home/zoomba3/.zoomba/zoomba.conf  
cd /home/zoomba4
sudo mkdir /home/zoomba4/.zoomba
sudo touch /home/zoomba4/.zoomba/zoomba.conf 
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5538\n#bind=[$(hostname  -I | cut -f2 -d' ')]\ndaemon=1\nserver=1\nport=5537\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey4\nexternalIP=[$(hostname  -I | cut -f2 -d' ')]:5530\naddnode=149.28.236.13\naddnode=207.246.95.9\naddnode=149.28.98.180\naddnode=70.175.112.249\naddnode=45.79.162.189\naddnode=196.52.39.2\naddnode=45.32.250.250\naddnode=108.61.206.254\naddnode=139.99.194.25\naddnode=192.210.213.180\naddnode=209.250.233.198\naddnode=167.99.94.49\naddnode=45.76.19.244\naddnode=66.42.85.90\naddnode=140.82.37.36\naddnode=80.211.40.186\naddnode=202.182.126.66\naddnode=45.77.52.55\naddnode=206.189.218.100\naddnode=95.179.160.214" >> /home/zoomba4/.zoomba/zoomba.conf  
zoombad -datadir=/home/zoomba/.zoomba -daemon -reindex
zoombad -datadir=/home/zoomba2/.zoomba -daemon -reindex
zoombad -datadir=/home/zoomba3/.zoomba -daemon -reindex
zoombad -datadir=/home/zoomba4/.zoomba -daemon -rein++dex
echo -e ${GREEN}"Congrats! Your Masternode is now installed and has started. Please wait from 10-60 minutes in order to give the masternode enough time to sync, then start the node from your Windows wallet."${NC}
fi
