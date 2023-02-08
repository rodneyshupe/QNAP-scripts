#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

external_drive=$(df -h 2>>/dev/null | grep '[0-9]T.*%.*/external/' --max-count=1 | grep --only-matching '% .*' | sed 's/% //')

if [ ! -z $external_drive ]; then
    echo "Backing up to $external_drive"
    sudo rsync --archive -Xht --itemize-changes --modify-window=1 --delete /share/CACHEDEV1_DATA/appdata/*   $external_drive/appdata/
    sudo rsync --archive -Xht --itemize-changes --modify-window=1 --delete /share/CACHEDEV1_DATA/storage/*   $external_drive/storage/
    sudo rsync --archive -Xht --itemize-changes --modify-window=1 --delete /share/CACHEDEV1_DATA/downloads/* $external_drive/downloads/
    sudo rsync --archive -Xht --itemize-changes --modify-window=1 --delete /share/CACHEDEV1_DATA/media/*     $external_drive/media/
else
    echo "Can not file external drive"
    exit 404
fi
