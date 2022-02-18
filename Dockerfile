FROM alpine

WORKDIR /app

RUN apk add --no-cache sed dcron -q

ADD script.sh .
RUN chmod +x script.sh

ADD cron.sh /usr/bin/cron.sh
RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/script.log

# define your schedule
ENV CRON "0 * * * *"
# define the script output log file
ENV LOG "/var/log/script.log"
# define the script to run (full path)
ENV SCRIPT "/app/script.sh"
# define the arguments for the script
ENV ARGS "arg1 arg2"

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
