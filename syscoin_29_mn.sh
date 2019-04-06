#!/bin/bash
# Only run as a root user
if [ "$(sudo id -u)" != "0" ]; then
    echo "This script may only be run as root or with user with sudo privileges."
    exit 1
fi
#
#Open Syscoin Port
ufw allow 8369/tcp
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
PRIV_KEY_03=5JQxqs3VvmCLCfeWgpgEUZSf3LeGQoJLbwNC4n7eCuTowjWSpSV
PRIV_KEY_04=5K3ovoFMg4aJbm7K3isfWcuEfSbEeCUgabMCSKsppJH4sGqB6N9
PRIV_KEY_05=5JHKyNMGpkjvBYkCmUJKg9eoq98GL5boFTaRLoEA1JHpofykjZ4
PRIV_KEY_06=5JLyHTvioZx6XBcb962kSv3u2JeSCX7N45FrbgdRvUf2g9iGana
PRIV_KEY_07=5J1MLQXGJcTLBLtA18kGN8idAm2BQvd6mohFyMxbqipVr3v6d7o
PRIV_KEY_08=5KGCRbocpGN24QAT8N1gRAvNhiSAE2m51UR7FwkhkYE3huYRTsm
PRIV_KEY_09=5J1KDfzKJEbYUwPMbTfoUrAtY4QWd5bhiZ1eQ45LNJWE7YPFg6r
PRIV_KEY_10=5J1P3iM3jYoxrwnDXsmhBNdKrxypLSgdmXfJ8pQJXRkNBGvuFBc
PRIV_KEY_11=5K8KCK64kNSAziaD3kCPDFM8t1ReWMfRgW5E9TAjGZgZ38CzuAn
PRIV_KEY_12=5JD3zqkmyS5B8F4etqTELyaJMTQ6zRXJtN3J35myXzyqw1pLVyV
PRIV_KEY_13=5Jr89bgjsSb2ZN3ixrzPjdkGRm3ohi8e68haJtAvw8KqdYbwwKd
PRIV_KEY_14=5HtnjZ3wtiMYjr9w25KBoW6vxnCr3c6bco3zB8TKi4hVmaoywnB
PRIV_KEY_15=5Jxc1eZCEBJNYMA57u1cXJvspSCr2fpXkPp3ia6dPsAsvwYwm95
PRIV_KEY_16=5J5P2hxE4fFa8nH1xshs9t2GhLpWbzAZPwubaSuCfKja3Sc5WbS
PRIV_KEY_17=5J793GEZ5VgaNB64bfmmhWASyyQG8TcsPWt9wukQtxCBKz81bv7
PRIV_KEY_18=5KYhRkkd1pGjPewJNpG6r8iQ5AFPphGkFEez8265z8MtWw8jhuf
PRIV_KEY_19=5JTxM64i9ydZskGnRwkUnmKQmXzXiGecz3ysFdM4q6oBEzXiRpc
PRIV_KEY_20=5KRUSkGD2Q1zeYXPqoJmqW24kQ6iFVUSnSAWYSNZcM4GnKjaFhC
PRIV_KEY_21=5JQWrrYPx7cwK7bf8q8KBUpS42zDCSyaqD1fxxPYuWv2CeMSegK
PRIV_KEY_22=5KLh5y1v1pkocmi8y5dwNi9eA4MZk6XeJVZe8xY6DZesGcta8Zz
PRIV_KEY_23=5JBk6BQY2NJ2WBebUTE4T3chDwfhV2xKZpv3fMfNosvC8RRKM4L
PRIV_KEY_24=5JRdqjWdGwMd5LVgqaDmn7K1gpvZGrVMCMEmJvtRAi4siX12bLu
PRIV_KEY_25=5Jo2sFzjfdFXdezUSqPnJaSP1N9E8eJpx1q5dBKKrnMQSwbR5MS
PRIV_KEY_26=5Hude6QkHzwtrFr2JnnvCXGxd5WZyy578XNnzv3G5fsQR1xz4cW
PRIV_KEY_27=5HvzLoQwnz8Ee59SaMYr9nfp6FCj646qiUgg47wjhF1CYdJMnJM
PRIV_KEY_28=5K86GxvDqLYpvHQt9EfxsrZ47UJhqeMeW7bwcPqVPHsLywryCm1
PRIV_KEY_29=5Hq9DKY86MxgqCaw8N4cQH4VztqbohRKnaCvf49CvvCbvi2iKs4
#
for num in {1..29}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
port=$((num * 2 + 8369))
#
echo "Creating n syscoin system users with no-login access:"
sudo adduser --system --home /home/syscoin_$nn syscoin_$nn
#
eval pk='$'PRIV_KEY_"$nn"
#
#
cd /home/syscoin_$nn
sudo mkdir /home/syscoin_$nn/.syscoincore
sudo touch /home/syscoin_$nn/.syscoincore/syscoin.conf
# rpc config
echo "rpcuser=syscoinuser" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "rpcpassword=asdfasd156kjhjio" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "rpcallowip=127.0.0.1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "rpcport=$((port - 1))" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "rpcbind=127.0.0.1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "bind=$(hostname  -I | cut -f1 -d' ')" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
# syscoind config
echo "listen=1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "server=1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "daemon=1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "maxconnections=24" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addressindex=1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "debug=0" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
# masternode config
echo "masternode=1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "masternodeprivkey=$pk" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):8369" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "port=$port" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=103.14.141.221" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=103.14.142.195" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=104.238.173.55" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=104.238.186.192" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=107.191.63.93" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=108.61.199.33" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=108.61.204.103" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=116.202.16.159" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=122.128.107.138" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=139.99.194.16" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=144.202.31.107" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=144.202.49.76" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=144.202.83.243" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=146.71.76.123" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=149.28.134.72" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=149.28.32.53" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=149.28.34.216" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=149.28.50.200" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=159.65.7.111" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=159.69.120.45" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=166.171.122.239" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=176.223.128.146" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=176.223.130.249" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=176.223.130.31" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=176.9.192.221" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=178.238.239.73" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=18.191.188.29" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=18.191.232.254" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=18.216.43.104" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=195.201.122.132" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=195.201.128.90" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=195.201.22.207" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=207.148.102.107" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=207.148.109.48" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=207.148.69.152" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=209.250.229.171" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=209.250.236.70" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=212.47.235.74" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=217.163.11.114" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=217.163.29.130" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=221.156.133.70" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=31.13.191.173" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=34.221.173.61" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=35.161.78.205" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=35.180.105.1" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.32.173.239" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.32.184.218" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.32.216.83" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.32.236.190" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.32.237.123" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.32.50.150" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.32.58.59" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.63.40.53" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.76.1.169" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.76.134.234" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.76.20.154" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.76.38.218" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.76.46.132" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.76.60.231" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.76.93.132" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.77.187.110" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.77.66.123" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=45.77.89.25" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=5.189.142.149" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=5.45.111.243" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=51.15.241.90" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=51.158.79.104" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=52.199.145.92" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=63.211.111.242" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=78.47.154.39" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=78.47.177.106" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=78.47.177.107" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=80.240.18.9" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=80.240.31.122" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=82.211.25.129" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=88.99.12.13" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=94.16.116.11" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=94.16.116.15" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=94.16.121.182" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=95.179.129.97" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
echo "addnode=95.179.183.191" >> /home/syscoin_$nn/.syscoincore/syscoin.conf
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
for num in {1..29}; do
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
