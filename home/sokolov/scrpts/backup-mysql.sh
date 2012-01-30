#!/bin/bash

# settings
DB_HOST='localhost'
DB_LOGIN='login'
DB_PSSWD='pass'
DB_NAME='dbname'

# create folder if not exist
STORAGE_PATH='/var/backups/mysql/'

mysqldump -u $DB_LOGIN -h $DB_HOST -p$DB_PSSWD $DB_NAME | gzip -9 > "$STORAGE_PATH/$DB_NAME_`date +%s`.sql.gz"
