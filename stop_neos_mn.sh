#!/bin/bash
#Start all Neos Masternodes
for num in {1..10}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes

OUTPUT=$(neos-cli -datadir=/home/neos_$nn/.neos getinfo 2>&1)
if [[ "$OUTPUT" == *"error: couldn't connect to server"* ]]
 then
   echo "Running neosd..."
   sudo su -c "neosd -datadir=/home/neos_$nn/.neos -daemon"
 else
   echo "Do Nothing"
fi
done