#!/usr/bin/env bash

if [ -z "$CRON" ]
  then
    echo $(date -u) " INFO - No CRON setting found. Executing action now."
    $SCRIPT $ARGS 
  else
    # Setup cron schedule
    crontab -d
    echo "$CRON $SCRIPT $ARGS >> $LOG 2>&1" > /tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    # Start cron
    echo $(date -u) " INFO - Starting cron ..."
    touch /var/log/crond.log
    crond -b -l 0 -L /var/log/crond.log
    echo $(date -u) " INFO - cron started"
    tail -F /var/log/crond.log $LOG
  fi
fi
