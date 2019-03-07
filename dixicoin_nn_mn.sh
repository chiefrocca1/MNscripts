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

echo -e ${YELLOW}"Welcome to the Dixicoin Automated Install, During this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install a Dixicoin Masternode? type y/n followed by [ENTER]:"${NC}
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
sudo apt-get -y install pkg-config  
sudo add-apt-repository ppa:bitcoin/bitcoin 
sudo apt-get update 
sudo apt-get -y install libdb4.8-dev 
sudo apt-get -y install libdb4.8++-dev 
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5 
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils 

echo "Installing Fail2ban and Ufw(Firewall)"
sudo apt-get -y install fail2ban ufw
service fail2ban restart
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 61150/tcp
yes | ufw enable
sudo apt install git

sudo apt install git 

cd /var 
sudo touch swap.img 
sudo chmod 600 swap.img 
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 
sudo mkswap /var/swap.img 
sudo swapon /var/swap.img 
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~ 

sudo git clone https://github.com/dixicoin-dxc/dixicoin 
sudo chmod -R 755 ~/dixicoin 
cd dixicoin
sudo ./autogen.sh 
sudo ./configure --disable-tests --disable-gui-tests 
sudo make 
sudo make install

for num in {1..10}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
port=$((nn * 2 + 61150))

echo -e ${GREEN}"Please Enter Your Masternodes Private Key for node $nn:"${NC}
read PRIV_KEY_$nn

echo "Creating n Dixicoin system users with no-login access:"
sudo adduser --system --home /home/dixicoin_$nn dixicoin_$nn

cd /home/dixicoin_$nn
sudo mkdir /home/dixicoin_$nn/.dixicoin
sudo touch /home/dixicoin_$nn/.dixicoin/dixicoin.conf 
echo "rpcuser=user"shuf -i 100000-10000000 -n 1 >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "rpcpassword=pass"shuf -i 100000-10000000 -n 1 >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "rpcallowip=127.0.0.1" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "rpcport=$((port - 1))" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "bind=$(hostname  -I | cut -f1 -d' ')" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "daemon=1" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "server=1" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "port=$port" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "listen=0" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "masternode=1" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "logtimestamps=1" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "maxconnections=250" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "masternodeprivkey=$PRIV_KEY_$nn" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):61150" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=108.61.206.254" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=139.99.194.25" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=140.82.37.36" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=149.28.236.13" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=149.28.98.180" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=167.99.94.49" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=192.210.213.180" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=196.52.39.2" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=202.182.126.66" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=206.189.218.100" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=207.246.95.9" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=209.250.233.198" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=45.32.250.250" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=45.76.19.244" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=45.77.52.55" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=45.79.162.189" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=66.42.85.90" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=70.175.112.249" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=80.211.40.186" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=95.179.160.214" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=217.69.4.225" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=45.63.97.39" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=136.0.9.13" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=140.82.23.12" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=80.211.184.163" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=196.52.39.2" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=173.239.219.13" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=149.28.236.13" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf

dixicoind -datadir=/home/dixicoin_$nn/.dixicoin -daemon -reindex
echo "Syncing Masternode $nn ...";
done

sleep 10

for num in {1..10}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
sleep 10
until dixicoin-cli -datadir=/home/dixicoin_$nn/.dixicoin mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Masternode $nn is fully synced!"${NC}
done

echo ""
echo -e ${GREEN}"Congrats! Your Dixicoin coin Masternodes are now installed and started. Please wait from 20-30 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "The END. You can close now the SSH terminal session";

fi