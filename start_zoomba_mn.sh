#!/bin/bash
#Start all Zoomba Masternodes
for num in {1..10}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes

OUTPUT=$(zoomba-cli -datadir=/home/zoomba_$nn/.zoomba getinfo 2>&1)
if [[ "$OUTPUT" == *"error: couldn't connect to server"* ]]
 then
   echo "Running zoombad..."
   sudo su -c "zoombad -datadir=/home/zoomba_$nn/.zoomba -daemon"
 else
   echo "Do Nothing"
fi
done