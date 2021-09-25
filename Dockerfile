FROM ubuntu:20.04

RUN apt update -y && apt install cron -y 

CMD [ "/usr/sbin/cron", "-f" ]

RUN groupadd -g 999 bkp 

RUN useradd bkpuser -u 999 -g 999 -m -s /bin/bash 

COPY bkp-util/* /home/bkpuser/

RUN mkdir -p /data/bkps

RUN chown -R bkpuser:999 /data/bkps

USER bkpuser

ENV BACKUP_INTERVAL=5

WORKDIR /data

ENTRYPOINT /home/bkpuser/cron-conf.sh


