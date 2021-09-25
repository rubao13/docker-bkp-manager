#!/bin/bash
#
# Script triggered by crontab

#to debug if needed
#set -x 

echo "Backup Engine ON"

if [ $RESET == 'false' ];
then
   echo 'BKP START'

   date

   /home/bkpuser/folder-backup.sh -o /data/db -d /data/bkps/ -f bkp-mongodb -n 15


   echo 'BKP DONE'
fi

if [ $RESET == 'true' ]
then
   echo 'RESTORE START'

   date

   cd /data
   tar -xf bkps/latest-bkp


   echo 'RESTORE DONE'
   exit 1

fi
