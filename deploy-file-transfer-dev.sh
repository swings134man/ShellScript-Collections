#!/bin/bash

# Made By Lucas Kang
# This Is For Bash Shell
# Temp Dir Move To Tomcat Source Directory -> Dev Only

# FIXME: You need to change the directory path

echo "Start Deploy File Transfer"

# Find The War File

# 1. Copy the file
cp /data/smn/file/artifact.zip /var/www/smn/


# Check if the copy was successful
# if failed, abort the script
if [ $? -eq 0 ]; then
    echo "File copied successfully."

    # 2. Remove all files in the source directory
    #rm -rf /data/smn/file/artifact.zip
    #echo "Source directory files deleted."

    # 3. unzip the file
    # !!! If you want to unzip the file. You can use this command. !!!
    unzip /var/www/smn/artifact.zip -d /var/www/smn/

    # 4. war file move
    # if exists
    if [ -d /var/www/smn/mobile-web ]; then
        mv /var/www/smn/mobile-web/target/smnapp-mobile-web-prod.war /var/www/smn/mobile-web/
        echo "mobile war file moved."

        rm -rf /var/www/smn/mobil-web
        echo "mobile war folder deleted."
    else
        echo "mobile-web directory is not found."
    fi

    if [ -d /var/www/smn/cms ]; then
        mv /var/www/smn/cms/backend/target/smnapp-cms-prod.war /var/www/smn/
        echo "cms war file moved."

        rm -rf /var/www/smn/cms
        echo "cms war folder deleted."
    else
        echo "cms directory is not found."
    fi

    sleep 1

    echo "Complete Deploy File Transfer."
else
    echo "File copy failed. Aborting."
fi