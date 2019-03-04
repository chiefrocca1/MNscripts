#!/bin/bash
#Stop all Zoomba Masternodes
for num in {1..10}; do
   nn=$(printf "%02d" $num)
# Use $nn for your purposes

OUTPUT=$(zoomba-cli -datadir=/home/zoomba_$nn/.zoomba getinfo 2>&1)
if [[ "$OUTPUT" == *"error: couldn't connect to server"* ]]
 then
   echo "Masternode $nn is not running..."
 else
   sudo su -c "zoomba-cli -datadir=/home/zoomba_$nn/.zoomba stop"
fi
done
