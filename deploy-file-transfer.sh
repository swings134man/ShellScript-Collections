#!/bin/bash

# This Is For Bash Shell
# Temp Dir Move To Tomcat Source Directory -> PROD Only

# This is For WAS1. You Need To Fix the Code For WAS2
# FIXME: Fix WAS2 IP Address

echo "Start Deploy File Transfer"

source_dir="/var/www/smn"

# Find The War File
file_info=$(find /data/upload/sapp/deploy/ -type f -exec stat --format='%Y %n' {} \; | sort -nr | head -n 1)
file_path=$(echo $file_info | cut -d ' ' -f 2-)
file_name=$(echo $file_info | awk -F/ '{print $NF}')


# 1. Copy the file
cp $file_path $source_dir/

# if failed, abort the script
if [ $? -eq 0 ]; then
    echo "File copied successfully."

    # 3. unzip the file
    unzip $source_dir/$file_name -d $source_dir/

    # 4. Deleted Zip File
    rm -rf $source_dir/$file_name
    echo "zip file deleted ON /smn/~"

    # 5. war file move
    if [ -d $source_dir/mobile-web ]; then
        mv $source_dir/mobile-web/target/smnapp-mobile-web-prod.war $source_dir/
        echo "mobile war file moved."

        # Copy WAS2
        scp $source_dir/smnapp-mobile-web-prod.war tomcat@{IP}:$source_dir/

        echo ""
        echo "FO.war File Copy to WAS2"

        slepp 5
        echo ""

        rm -rf $source_dir/mobil-web
        echo "mobile war folder deleted."
    else
        echo "mobile-web directory is not found."
    fi

    if [ -d $source_dir/cms ]; then
        mv $source_dir/cms/backend/target/smnapp-cms-prod.war $source_dir/
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