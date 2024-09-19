#!/bin/bash

#variables
PORT=80
LOG=hpot.log
#data to display to an attcker
BANNER=`cat index.html` # notice these are ` and not '. The command will run incorrectly if latter

# create a temp lock file, to ensure only one instance of the HP is running
touch /tmp/hpot.hld
# Allosws for better Cntrl-c interuptts
trap "rm -f /tmp/hpot.hld; echo 'HoneyPot stopped'; exit " SIGINT

echo "" >> $LOG
#while loop starts and keeps the HP running. 
while [ -f /tmp/hpot.hld ]
 do
  echo "$BANNER" | ncat -lvnp $PORT 1>> $LOG 2>> $LOG
  # this section logs for your benefit
  echo "==ATTEMPTED CONNECTION TO PORT $PORT AT `date`==" >> $LOG # the humble `date` command is great one ain't it
  echo "" >> $LOG
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> $LOG # seperates the logged events. 
 done
