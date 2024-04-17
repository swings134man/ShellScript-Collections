#!/bin/bash

# This Is For Bash Shell
# Temp Dir Move To Tomcat Source Directory -> Dev Only

echo "Start Deploy File Transfer - DEV"

source_dir="/var/www/smn"

# Find The War File
file_info=$(find /data/attach/smnapp-dev/deploy/ -type f -exec stat --format='%Y %n' {} \; | sort -nr | head -n 1)
file_path=$(echo $file_info | cut -d ' ' -f 2-)
file_name=$(echo $file_info | awk -F/ '{print $NF}')

# 1. Copy the file
cp $file_path $source_dir/


# Check if the copy was successful
# if failed, abort the script
if [ $? -eq 0 ]; then
    echo "File copied successfully."

    # 2. unzip the file
    # !!! If you want to unzip the file. You can use this command. !!!
    unzip $source_dir/$file_name -d $source_dir/

    # 3. Deleted Zip File
    rm -rf $source_dir/$file_name
    echo "zip file deleted ON /smn/~"

    # 3. war file move
    # if exists
    if [ -d $source_dir/mobile-web ]; then
        mv $source_dir/mobile-web/target/smnapp-mobile-web-dev.war $source_dir/
        echo "mobile war file moved."

        rm -rf $source_dir/mobil-web
        echo "mobile war folder deleted."
    else
        echo "mobile-web directory is not found."
    fi

    if [ -d $source_dir/cms ]; then
        mv $source_dir/cms/backend/target/smnapp-cms-dev.war $source_dir/
        echo "cms war file moved."

        rm -rf $source_dir/cms
        echo "cms war folder deleted."
    else
        echo "cms directory is not found."
    fi

    sleep 1

    echo "Complete Deploy File Transfer."
else
    echo "File copy failed. Aborting."
fi