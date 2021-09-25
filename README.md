## Overview 
The goal is to add a backup service, that can be configured via environment variables. Using a mongo database running containerized for example. 


## The goal
Build a image `backup-manager` to task create scheduled backups or reset the database from previously created backups. It is configurable with these environment variables:

- `MONGO_ROOT_USERNAME`: User to create backups with
- `MONGO_ROOT_PASSWORD`: Password of user to create backups with
- `MONGO_HOST`: Hostname to access postgres
- `RESET`: if value is `true`, use the latest created backup to reset the database once
- `BACKUP_INTERVAL`: number, defining the interval in minutes between the creation of backups

- `docker build -t backup-manager:local .` build image used in docker-compose 

## How to set up your environment
- Create the directories for the persistent storage: `mkdir -p /tmp/backup_local /tmp/mongo_data`
- Run the docker-compose.yaml
- Fill the database by running the `fill_ironman.sh` script after the mongo container became available


## Running
 - Edit docker-compose.yaml to define RESET env-variable: true of false
 - RESET true: Backup-manager will up restore to latest backup found and terminate.
 - RESET false: Backup-manager will up and according to BACKUP_INTERVAL (minutos) will generate backups (retain last 15 bkps)
 - Another option to restore MongoDB is after running with RESET=false, edit RESET to `true` and run:  `docker-compose start backup-manager`
 - EXTRA: If for some reason in your environment CRON does not start (strange results with play-with-docker.com) run: `docker exec -u root devops_backup_manager service cron start`


## Sources 
https://docs.mongodb.com/manual/core/backups/
https://docs.docker.com/engine/reference/commandline/compose/
https://docs.docker.com/engine/reference/commandline/image_build/

