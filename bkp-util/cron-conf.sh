#!/bin/bash


if [ $RESET == 'false' ];
then


# dynamically configures crontab 
   echo '*/'$BACKUP_INTERVAL '* * * * /home/bkpuser/backup-engine.sh >> /home/bkpuser/log.txt 2>&1' > /home/bkpuser/new_cron

   crontab /home/bkpuser/new_cron

   tail -f /etc/*release

fi

if [ $RESET == 'true' ]
then
  cd /data
  tar -xf bkps/latest-bkp
  
fi