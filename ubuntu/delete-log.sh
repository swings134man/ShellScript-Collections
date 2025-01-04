#!/bin/bash

# This is For Tomcat JULI Log Delete cron Shell 

# 1st of Every Month, Find Files Order Than 30 days

# And Delete Files 

# Use Command !!
find /path/ -mtime +30 -exec rm -f {} \;



# After 

# This file Auth Changes 
# - chmod 755 {FileName}

# - crontab -e 

# - 0 0 1 * * /file path



