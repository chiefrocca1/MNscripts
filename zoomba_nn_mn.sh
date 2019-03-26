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
#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${NC}
  exit 1
fi
#
#echo -e ${YELLOW}"Welcome to the Zoomba Automated Install, During this Process Please Hit Enter or Input What is Asked."${NC}
#echo ""
#pause
#
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
sudo apt-get -y update 
sudo apt-get -y install libdb4.8-dev 
sudo apt-get -y install libdb4.8++-dev 
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5 
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
#
echo "Installing Fail2ban and Ufw(Firewall)"
sudo apt-get -y install fail2ban ufw
service fail2ban restart
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 5530/tcp
yes | ufw enable
#
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
#sudo git clone https://github.com/zoombacoin/zoomba 
#sudo chmod -R 755 ~/zoomba 
#cd zoomba 
#sudo ./autogen.sh 
#sudo ./configure
#sudo make
#sudo make install
#
wget https://github.com/zoombacoin/zoomba/releases/download/1.0.1/Zoomba_1.0.1_Linux.zip
unzip Zoomba_1.0.1_Linux.zip
sudo mv zoombad zoomba-qt zoomba-cli /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/zoomba*
#
PRIV_KEY_001=87hNmVhmDYNK39vXN1bfuLGQbE2Rb7mRbxP4Jp2gE2cqBRD4xPz
PRIV_KEY_002=88aigA9zHH1m2gPV8MeH4HZf4rpsWi6swNpyUS66NsGV3JP8d4J
PRIV_KEY_003=87DWLqfcgNM1jHYKbMGns6vfB2ZukNMeJrkhm3LDNLptjq51zY2
PRIV_KEY_004=87HeHABujz73xTX5ZaiH4dJnvr81rSjRQ3DA2N3Ab82HE9bDLax
PRIV_KEY_005=88xkkaHPHonSi9jbHYBQ4gPYpBNJAoL8JesjFWr2Mgj6xd7Af43
PRIV_KEY_006=88GYMQyqpH5rohwrubMLR4wKnD8udBYi55Y3wUyTHJU6gScVuvT
PRIV_KEY_007=87Lhn2sTuZKszUnmBGoMdvbw57NEASfK5g7d1B6gMSAo111EU9b
PRIV_KEY_008=87KdpRLcf55sTtxVpGguMj7p9UyWEKDLH9xrv48sMzjNsUDzAJy
PRIV_KEY_009=88x2Wr8pw2ZwiNSpafQPv4YabnQGZpy96jB7oZq7YttrD8B1Cqr
PRIV_KEY_010=88v6sDRtH4r6ndXPxVKrGqy6HhyPXGEsByVhYiLEJcMjGJ3DoVv
#
for num in {1..10}; do
   nn=$(printf "%03d" $num)
# Use $nn for your purposes
port=$((num * 2 + 5530))
#
echo "Creating n Zoomba system users with no-login access:"
sudo adduser --system --home /home/zoomba_$nn zoomba_$nn
#
eval pk='$'PRIV_KEY_"$nn"
#
#
cd /home/zoomba_$nn
sudo mkdir /home/zoomba_$nn/.zoomba
sudo touch /home/zoomba_$nn/.zoomba/zoomba.conf 
echo "rpcuser=zoombauser" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "rpcpassword=asdfasd1563fkjio" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "rpcallowip=127.0.0.1" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "rpcport=$((port - 1))" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "bind=$(hostname  -I | cut -f1 -d' ')" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "daemon=1" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "server=1" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "port=$port" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "listen=0" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "masternode=1" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "logtimestamps=1" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "maxconnections=250" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "masternodeprivkey=$pk" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):5530" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=108.61.206.254" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=139.99.194.25" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=140.82.37.36" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=149.28.236.13" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=149.28.98.180" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=167.99.94.49" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=192.210.213.180" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=196.52.39.2" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=202.182.126.66" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=206.189.218.100" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=207.246.95.9" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=209.250.233.198" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=45.32.250.250" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=45.76.19.244" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=45.77.52.55" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=45.79.162.189" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=66.42.85.90" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=70.175.112.249" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=80.211.40.186" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=95.179.160.214" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=217.69.4.225" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=45.63.97.39" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=136.0.9.13" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=140.82.23.12" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=80.211.184.163" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=196.52.39.2" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=173.239.219.13" >> /home/zoomba_$nn/.zoomba/zoomba.conf
echo "addnode=149.28.236.13" >> /home/zoomba_$nn/.zoomba/zoomba.conf
#
zoombad -datadir=/home/zoomba_$nn/.zoomba -daemon -reindex
echo -e ${YELLOW}"Syncing of Masternode $nn has begun..."${NC}
done
#
echo -e ${YELLOW}"Syncing Masternodes..."${NC}
sleep 5
#
for num in {1..10}; do
   nn=$(printf "%03d" $num)
# Use $nn for your purposes
sleep 10
until zoomba-cli -datadir=/home/zoomba_$nn/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Masternode $nn is fully synced!"${NC}
done
#
echo ""
echo -e ${GREEN}"Congrats! Your Zoomba coin Masternodes are now installed and started. Please wait from 20-30 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "The END. You can close now the SSH terminal session"
echo "$(date)";
