#!/bin/bash

STORAGE_PATH="/var/backups/files/`date +%s`/"

mkdir -p $STORAGE_PATH

backupDir() {
    ARCHIVE_NAME=$1
    BACKUP_PATH=$2
    tar -pczf $STORAGE_PATH$ARCHIVE_NAME.tar.gz $BACKUP_PATH
}

backupDir archive_name1 htdocs/folder1
backupDir archive_name2 htdocs/folder2
