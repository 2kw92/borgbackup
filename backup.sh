
#!/usr/bin/env bash

##
## Задание переменных окружения для Borg
##

## пароль репозитория Borg можно указать в переменной
## окружения, чтобы не вводить его при каждом запуске
export BORG_PASSPHRASE="admin"

##
## Задание переменных окружения
##

BACKUP_USER="borg"
BACKUP_SERVER=192.168.11.101
REPOSITORY_DIR="/var/backup"
LOG=/var/log/borg/backup.log


REPOSITORY="${BACKUP_USER}@${BACKUP_SERVER}:${REPOSITORY_DIR}"

##
## Вывод в файл журнала
##

exec > >(tee -a -i ${LOG}) 2>&1


echo "###### Backup started: $(date) ######"

echo "Transfer files ..."
borg create -v --stats                   \
    $REPOSITORY::'Mybackup-{now:%Y-%m-%d_%H:%M}'  \
    /etc                                 

echo "Clean old backup ..."
borg prune -v --show-rc --list $REPOSITORY --keep-daily=90 --keep-monthly=9 --keep-yearly 1

echo "###### Backup ended: $(date) ######"
