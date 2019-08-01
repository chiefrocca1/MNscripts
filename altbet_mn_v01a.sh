#!/bin/bash
#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'
#
#
PRIV_KEY_01=28NbR1YNJqq5DSGaASCQRtnMtiZshq2FjdkcQhKNhhB1oeRsSKZ
PRIV_KEY_02=28oV6LRq2Bcsao1akEjY3WYYbMsxfeit1Auhgg6isGbKh1vXw3t
PRIV_KEY_03=28kBQmSrxG6HW5cLpwZK8dauUmyCGcp1ozsqcc3HcaDvbAviT4B
PRIV_KEY_04=283fWWRrWhsVbn6k7k83nUEWQk4TUWYqEd1ckio993iiuKwdn7M
PRIV_KEY_05=27JZsoNXFtss3VG4tue9ZnwCqTymGELF6nisr1WC8juD1pxrCKA
PRIV_KEY_06=288L6CrJJQfMvwqNm3i6Whsr2yKgBBFVM2MAoxT5dMCsz9V9tE8
PRIV_KEY_07=28YGRxeVrMkJg51wcgXnjjYnLaoeE5FWJJFb958KBPnt2aujiTH
PRIV_KEY_08=28fgMvM9j742WS7G8M3x2BF4r6qfT3AXqLpS3VCbKX7Abh2p3sg
PRIV_KEY_09=28pCCmVoEBf8gEkh3ja9JhY3FaDEuZn9ETQSdjvFzD2u2bJUYHZ
PRIV_KEY_10=27mvpzQEodV2H8urrPCuGNgUyE2GWCesGqMczcwd76JmG8AdBgV
PRIV_KEY_11=27GB6o1pMDKNDRBRcsHuagFndY88CuTyrcVPYSEmsnK4MyK9ZAQ
PRIV_KEY_12=27cZXx7vti7JtQVxjVKzB4gRAUbyJFdcFxSK2gb7LpXDj4kCTVV
PRIV_KEY_13=27zjMynWqGPG3GtKigVvuMGeY6yrRWedUWsyp341hsSjCxHcwc2
PRIV_KEY_14=27ULZuCoNpcdVXdsFzUQasRsH9oaMCYRD4do8Skdhecn98u2DuN
PRIV_KEY_15=28wqfjfuGjoKksyq7RGucr2LHFByDQiNboupapqwC9mb5m8mKv9
PRIV_KEY_16=28yTR3gYrmu9yMnwCYW1LZSH9zqJG6hcCXucqMk9AnJAd1mvotP
PRIV_KEY_17=27smuzHBNZ5Vc92XTAmFK4XQU3UQUgnXyX8hug3VZDLpQ6P2QZN
PRIV_KEY_18=27HywmKwZkfD7TiCmZ8VwsGEN4mCMAhAPcqvfAf8JyjoNdAXkXF
PRIV_KEY_19=28vwYXS1YcnVSfYHzbt8kKw67CXJZJEZFzUQnMa1Abr71PUpHpv
PRIV_KEY_20=27W2LaQec4RUVJMhhG2F15JPA1FBL4NQpSJWpjqzDYCBVwTcru9
#
PROXY_01=172.241.236.174
PROXY_02=172.241.236.253
PROXY_03=198.71.85.119
PROXY_04=198.71.85.198
PROXY_05=198.71.85.248
PROXY_06=23.105.3.115
PROXY_07=23.105.3.193
PROXY_08=23.105.3.43
PROXY_09=23.105.4.173
PROXY_10=23.105.4.237
PROXY_11=23.105.4.93
PROXY_12=23.108.24.168
PROXY_13=23.108.24.86
PROXY_14=23.108.24.9
PROXY_15=23.80.141.229
PROXY_16=23.80.141.232
PROXY_17=23.80.141.87
PROXY_18=23.80.142.113
PROXY_19=23.80.142.170
PROXY_20=23.80.142.6
PROXY_21=23.81.67.118
PROXY_22=23.81.67.172
PROXY_23=23.81.67.59
PROXY_24=23.81.67.75
PROXY_25=23.82.104.11
PROXY_26=23.82.104.157
PROXY_27=23.82.104.3
PROXY_28=23.82.106.139
PROXY_29=23.82.106.205
PROXY_30=23.82.106.74
#
for num in {3..20}
do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
 port=$((num - 1 + 8322))
 rpcport=$((num + 9322))
#
 eval pk='$'PRIV_KEY_"$nn"
 eval proxy='$'PROXY_"$nn"
#
#cd /home/altbet_$nn
 sudo adduser --system --home /home/altbet_$nn altbet_$nn
 sudo mkdir /home/altbet_$nn/.altbet
 sudo touch /home/altbet_$nn/.altbet/altbet.conf
#
cat > "/home/altbet_$nn/.altbet/altbet.conf" << EOL
# rpc config
rpcuser=altbetuser${nn}
rpcpassword=RtXccK5mFMc1IHUNxMHKG7KLoQR8sDzE
rpcallowip=127.0.0.1
rpcbind=127.0.0.1
rpcport=${rpcport}
# altbetd config
listen=1
server=1
daemon=1
maxconnections=64
#addressindex=1
debug=0
# masternode config
masternode=1
masternodeprivkey=${pk}
masternodeaddr=24.99.223.29:8322
externalip=${proxy}:8322
port=${port}
#Altbet addnodes
addnode=173.249.42.253:8322
addnode=119.29.69.190:8322
addnode=176.9.175.163:8322
addnode=14.51.42.70:8322
addnode=45.77.51.174:8322
addnode=167.71.0.207:8322
addnode=95.179.155.105:8322
addnode=217.69.13.180:8322
addnode=46.4.178.73:8322
addnode=188.40.169.71:8322
addnode=81.222.228.66:8322
addnode=144.202.107.249:8322
addnode=8.9.36.49:8322
addnode=95.217.48.249:8322
addnode=140.82.1.78:8322
addnode=95.216.82.97:8322
EOL
altbetd_$nn -conf=/home/altbet_$nn/.altbet/altbet.conf -datadir=/home/altbet_$nn/.altbet -daemon -prune=100
echo -e ${YELLOW}"Syncing of Masternode $nn has begun..."${NC}
done
#
echo -e ${YELLOW}"Syncing Masternodes..."${NC}
sleep 5
#
for num in {3..20}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes
sleep 10
until altbet-cli -datadir=/home/altbet_$nn/.altbet mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Masternode $nn is fully synced!"${NC}
done
#
echo ""
echo -e ${GREEN}"Congrats! Your altbet coin Masternodes are now installed and started"${NC}
echo ""
echo "$(date)"
echo "";
