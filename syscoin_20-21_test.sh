#!/bin/bash
#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'
#
# Only run as a root user
 sudo apt install -y git
 sudo apt install -y tar
 sudo apt install -y netstat
 sudo apt install -y nano
# build tools
 sudo apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common
# boost
 sudo apt install -y libboost-all-dev
# bdb 4.8
 sudo add-apt-repository -y ppa:bitcoin/bitcoin
 sudo apt update -y
 sudo apt install -y libdb4.8-dev libdb4.8++-dev
# zmq
 sudo apt install -y libzmq3-dev
#
#Open Syscoin Port
 sudo apt-get -y install fail2ban ufw
 service fail2ban restart
 ufw default deny incoming
 ufw default allow outgoing
 ufw allow ssh
 ufw allow 8369/tcp
 yes | ufw enable
#
#Set IPTables
iptables -t nat -A OUTPUT -s 173.249.1.13 -d 23.80.142.6 -j DNAT --to-destination 127.0.0.1
iptables -t nat -A OUTPUT -s 173.249.1.13 -d 23.81.67.118 -j DNAT --to-destination 127.0.0.1
#
 wget https://github.com/syscoin/syscoin/releases/download/3.2.0.0/syscoincore-3.2.0.0-x86_64-linux-gnu.tar.gz
 tar xvzf syscoincore-3.2.0.0-x86_64-linux-gnu.tar.gz
 cd syscoincore-3.2.0.0/bin
 sudo mv syscoind syscoin-qt syscoin-cli /usr/local/bin
 sudo chmod 755 -R  /usr/local/bin/syscoin*
#
 cd
 git clone https://github.com/syscoin/syscoin.git
 sudo chmod -R 755 ~/syscoin 
 cd ~/syscoin/ 
 sudo ./autogen.sh
 sudo ./configure --disable-tests --disable-gui-tests --without-gui
 sudo make -j$(nproc) -pipe
 sudo make install -y
#
#INSTALL SENTINEL
  cd
  if [ ! -d ~/sentinel ]; then
    git clone https://github.com/syscoin/sentinel.git
  else
    cd sentinel
    git fetch
    git checkout master --quiet
    git pull
  fi
#INSTALL VirtualEnv
  cd ~/sentinel
  # install virtualenv
  sudo apt-get install -y python-virtualenv virtualenv
  # setup virtualenv
  virtualenv venv
  venv/bin/pip install -r requirements.txt
#
PRIV_KEY_20=5KRUSkGD2Q1zeYXPqoJmqW24kQ6iFVUSnSAWYSNZcM4GnKjaFhC
PRIV_KEY_21=5JQWrrYPx7cwK7bf8q8KBUpS42zDCSyaqD1fxxPYuWv2CeMSegK
#
PROXY_20=23.80.142.6
PROXY_21=23.81.67.118
#
for num in {20..21}
do
nn=$(printf "%02d" $num)
# Use $nn for your purposes
 port=$((num -20 + 8369))
 rpcport=$((num + 9000))
#
 eval pk='$'PRIV_KEY_"$nn"
 eval proxy='$'PROXY_"$nn"
#
#tor_addr=$(cat /var/lib/tor/syscoin_${nn}/hostname)
#cd /home/syscoin_$nn/.syscoincore
#rm syscoin.conf
#
#cd /home/syscoin_$nn
 sudo adduser --system --home /home/syscoin_$nn syscoin_$nn
 sudo mkdir /home/syscoin_$nn/.syscoincore
 sudo touch /home/syscoin_$nn/.syscoincore/syscoin.conf
#
cat > "/home/syscoin_$nn/.syscoincore/syscoin.conf" << EOL
# rpc config
rpcuser=sysuser${nn}
rpcpassword=RtXccK5mFMc1IHUNxMHKG7KLoQR8sDzE
rpcallowip=127.0.0.1
rpcbind=127.0.0.1
rpcport=${rpcport}
# syscoind config
listen=1
server=1
daemon=1
maxconnections=24
addressindex=1
debug=0
# masternode config
masternode=1
masternodeprivkey=${pk}
masternodeaddr=173.249.1.13:8369
externalip=${proxy}:8369
port=${port}
EOL
#
# Sentinel config
SENTINEL_CONF=$(cat <<EOF
# syscoin conf location
syscoin_conf=/home/syscoin_$nn/.syscoincore/syscoin.conf
# db connection details
db_name=/home/syscoin_$nn/sentinel/database/sentinel.db
db_driver=sqlite
# network
network=mainnet
EOF
)
#
# Sentinel-Ping config
SENTINEL_PING=$(cat <<EOF
#!/bin/bash
~/sentinel/venv/bin/python /home/syscoin_$nn/sentinel/bin/sentinel.py 2>&1 >> /home/syscoin_$nn/sentinel/sentinel-cron.log
EOF
)
#
cd
sudo cp -r ~/sentinel /home/syscoin_$nn
# create sentinel conf file
rm /home/syscoin_$nn/sentinel/sentinel.conf
echo "$SENTINEL_CONF" >> /home/syscoin_$nn/sentinel/sentinel.conf
#
# create sentinel-ping
echo "$SENTINEL_PING" >> ~/sentinel-ping_$nn
sudo mv -f ~/sentinel-ping_$nn /usr/local/bin
sudo chmod +x /usr/local/bin/sentinel-ping_$nn
#
echo "*/10 * * * * /usr/local/bin/sentinel-ping_$nn" | sudo crontab -u syscoin_$nn -
#
syscoind -datadir=/home/syscoin_$nn/.syscoincore -daemon -reindex
echo -e ${YELLOW}"Syncing of Masternode $nn has begun..."${NC}
done
#
echo -e ${YELLOW}"Syncing Masternodes..."${NC}
sleep 5
#
for num in {20..21}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
sleep 10
until syscoin-cli -datadir=/home/syscoin_$nn/.syscoincore mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Masternode $nn is fully synced!"${NC}
bash /usr/local/bin/sentinel-ping_$nn
done
#
echo ""
echo -e ${GREEN}"Congrats! Your Syscoin coin Masternodes are now installed and started. Please wait from 20-30 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "The END. You can close now the SSH terminal session"
echo ""
echo "$(date)"
echo "";
