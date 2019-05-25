#!/bin/bash
# Only run as a root user
sudo apt install -y git tar wget
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
#ufw allow 8369/tcp
#
#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'
#
wget https://github.com/syscoin/syscoin/releases/download/3.2.0.0/syscoincore-3.2.0.0-x86_64-linux-gnu.tar.gz
tar xvzf syscoincore-3.2.0.0-x86_64-linux-gnu.tar.gz
cd syscoincore-3.2.0.0/bin
sudo mv syscoind syscoin-qt syscoin-cli /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/syscoin*
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
PRIV_KEY_01=5HsdLGdQmmGkjXtt92ooDn6mh6NCDDafkfKXAHvN6aH21mavWmV
PRIV_KEY_02=5KENxWvkYiY7dkuC4hvfAEJDkPpgG6ZxemyfjkAzpL9HnFAPN6m
#PRIV_KEY_03=5JQxqs3VvmCLCfeWgpgEUZSf3LeGQoJLbwNC4n7eCuTowjWSpSV
#PRIV_KEY_04=5K3ovoFMg4aJbm7K3isfWcuEfSbEeCUgabMCSKsppJH4sGqB6N9
#PRIV_KEY_05=5JHKyNMGpkjvBYkCmUJKg9eoq98GL5boFTaRLoEA1JHpofykjZ4
#PRIV_KEY_06=5JLyHTvioZx6XBcb962kSv3u2JeSCX7N45FrbgdRvUf2g9iGana
#PRIV_KEY_07=5J1MLQXGJcTLBLtA18kGN8idAm2BQvd6mohFyMxbqipVr3v6d7o
#PRIV_KEY_08=5KGCRbocpGN24QAT8N1gRAvNhiSAE2m51UR7FwkhkYE3huYRTsm
#PRIV_KEY_09=5J1KDfzKJEbYUwPMbTfoUrAtY4QWd5bhiZ1eQ45LNJWE7YPFg6r
#PRIV_KEY_10=5J1P3iM3jYoxrwnDXsmhBNdKrxypLSgdmXfJ8pQJXRkNBGvuFBc
#PRIV_KEY_11=5K8KCK64kNSAziaD3kCPDFM8t1ReWMfRgW5E9TAjGZgZ38CzuAn
#PRIV_KEY_12=5JD3zqkmyS5B8F4etqTELyaJMTQ6zRXJtN3J35myXzyqw1pLVyV
#PRIV_KEY_13=5Jr89bgjsSb2ZN3ixrzPjdkGRm3ohi8e68haJtAvw8KqdYbwwKd
#PRIV_KEY_14=5HtnjZ3wtiMYjr9w25KBoW6vxnCr3c6bco3zB8TKi4hVmaoywnB
#PRIV_KEY_15=5Jxc1eZCEBJNYMA57u1cXJvspSCr2fpXkPp3ia6dPsAsvwYwm95
#PRIV_KEY_16=5J5P2hxE4fFa8nH1xshs9t2GhLpWbzAZPwubaSuCfKja3Sc5WbS
#PRIV_KEY_17=5J793GEZ5VgaNB64bfmmhWASyyQG8TcsPWt9wukQtxCBKz81bv7
#PRIV_KEY_18=5KYhRkkd1pGjPewJNpG6r8iQ5AFPphGkFEez8265z8MtWw8jhuf
#PRIV_KEY_19=5JTxM64i9ydZskGnRwkUnmKQmXzXiGecz3ysFdM4q6oBEzXiRpc
#PRIV_KEY_20=5KRUSkGD2Q1zeYXPqoJmqW24kQ6iFVUSnSAWYSNZcM4GnKjaFhC
#PRIV_KEY_21=5JQWrrYPx7cwK7bf8q8KBUpS42zDCSyaqD1fxxPYuWv2CeMSegK
#PRIV_KEY_22=5KLh5y1v1pkocmi8y5dwNi9eA4MZk6XeJVZe8xY6DZesGcta8Zz
#PRIV_KEY_23=5JBk6BQY2NJ2WBebUTE4T3chDwfhV2xKZpv3fMfNosvC8RRKM4L
#PRIV_KEY_24=5JRdqjWdGwMd5LVgqaDmn7K1gpvZGrVMCMEmJvtRAi4siX12bLu
#PRIV_KEY_25=5Jo2sFzjfdFXdezUSqPnJaSP1N9E8eJpx1q5dBKKrnMQSwbR5MS
#PRIV_KEY_26=5Hude6QkHzwtrFr2JnnvCXGxd5WZyy578XNnzv3G5fsQR1xz4cW
#PRIV_KEY_27=5HvzLoQwnz8Ee59SaMYr9nfp6FCj646qiUgg47wjhF1CYdJMnJM
#PRIV_KEY_28=5K86GxvDqLYpvHQt9EfxsrZ47UJhqeMeW7bwcPqVPHsLywryCm1
#PRIV_KEY_29=5Hq9DKY86MxgqCaw8N4cQH4VztqbohRKnaCvf49CvvCbvi2iKs4
#
for num in {1..2}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
port=$((num + 8000))
rpcport=$((num + 9000))
#
eval pk='$'PRIV_KEY_"$nn"

#tor_addr=$(cat /var/lib/tor/syscoin_${nn}/hostname)

cd /home/syscoin_$nn/.syscoincore
rm syscoin.conf

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
debug=1
# masternode config
masternode=1
masternodeprivkey=${pk}
#externalip=$(hostname  -I | cut -f1 -d' ')"
externalip=$(hostname  -I | cut -f1 -d' ')"
port=8369
EOL

Done
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
for num in {1..2}; do
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
