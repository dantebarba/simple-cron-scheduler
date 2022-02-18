# Simple Cron Scheduler (SCS)

A simple framework for building and running containerized cron jobs.

## Usage

1. Use this image as base for your cron script.
   
```dockerfile
FROM dantebarba/simple-cron-scheduler:latest

# install your libraries here. Remember this is alpine
apk add -y curl

# add your own script to the mix...
ADD script.sh
RUN chmod +x script.sh

# define your schedule
ENV CRON "0 * * * *"
# define the script output log file
ENV LOG "/var/log/script.log"
# define the script to run (full path)
ENV SCRIPT "/app/script.sh"
# define the arguments for the script
ENV ARGS "arg1 arg2"

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
```

2. You can map the script from a volume too

```bash
docker run dantebarba/simple-cron-scheduler:latest -v /my/home/script.sh:/app/script.sh
```

3. logs are published in /var/log/crond.log.



