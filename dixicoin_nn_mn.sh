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
echo -e ${YELLOW}"Welcome to the Dixicoin Automated Install, During this Process Please Hit Enter or Input What is Asked."${NC}
echo ""
pause
#
sudo apt-get -y update 
sudo apt-get -y upgrade
sudo apt-get -y install software-properties-common 
sudo apt-get -y install build-essential
sudo add-apt-repository ppa:bitcoin/bitcoin 
sudo apt-get -y update
sudo apt-get -y install libzmq3-dev >/dev/null 2>&1
sudo apt-get -y install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" make software-properties-common \
build-essential libtool autotools-dev autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev \ 
libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git wget curl libdb4.8-dev bsdmainutils libdb4.8++-dev \
libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev  libdb5.3++ unzip libzmq5 >/dev/null 2>&1

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
#
PRIV_KEY_01=
PRIV_KEY_02=
PRIV_KEY_03=
PRIV_KEY_04=
PRIV_KEY_05=
PRIV_KEY_06=
PRIV_KEY_07=
PRIV_KEY_08=
PRIV_KEY_09=
PRIV_KEY_10=
#
for num in {1..10}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
port=$((nn * 2 + 61150))
#
echo "Creating dixicoin system users with no-login access:"
sudo adduser --system --home /home/dixicoin_$nn dixicoin_$nn
#
eval pk='$'PRIV_KEY_"$nn"
#
echo "Creating n Dixicoin system users with no-login access:"
sudo adduser --system --home /home/dixicoin_$nn dixicoin_$nn
#
cd /home/dixicoin_$nn
sudo mkdir /home/dixicoin_$nn/.dixicoin
sudo touch /home/dixicoin_$nn/.dixicoin/dixicoin.conf 
echo "rpcuser=dixicoinuser" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "rpcpassword=ajsfiwejdsfa1562fsjeiw" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
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
echo "masternodeprivkey=$pk" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):61150" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=119.27.163.238" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=159.69.16.114" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=83.243.67.227" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=209.250.236.197" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=140.82.56.214" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=207.246.81.73" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=178.128.87.245" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=212.35.183.73" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=185.57.82.27" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
echo "addnode=178.128.217.156" >> /home/dixicoin_$nn/.dixicoin/dixicoin.conf
#
dixicoind -datadir=/home/dixicoin_$nn/.dixicoin -daemon -reindex
echo -e ${YELLOW}"Syncing of Masternode $nn has begun..."${NC}
done
#
echo -e ${YELLOW}"Syncing Masternodes..."${NC}
sleep 5
#
for num in {1..10}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
sleep 10
until dixicoin-cli -datadir=/home/dixicoin_$nn/.dixicoin mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Masternode $nn is fully synced!"${NC}
done
#
echo ""
echo -e ${GREEN}"Congrats! Your Dixicoin Masternodes are now installed and started. Please wait from 20-30 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "The END. You can close now the SSH terminal session"
echo "$(date)";
