#!/bin/bash


USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGFOLDER="/var/log/Install"
SCRIPTNAME=$( echo $0| cut -d "." -f1 )
LOGFILE="$LOGFOLDER/$SCRIPTNAME.log" # /var/log/Install/16-logs.log
SOURCE_DIR=/home/ec2-user/app-logs

mkdir -p $LOGFOLDER
echo "Script started executed at: $(date)" | tee -a $LOGFILE    

# check directory exist or not
if [ ! -d "$SOURCE_DIR" ]; then
echo -e "ERROR:: $SOURCE_DIR directory does not exist" | tee -a $LOGFILE
exit 1
fi  

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +7)

while IFS= read -r filepath; do

echo "Deleting file: $filepath" 
rm -f $filepath
echo "deleted file: $filepath"
    
done <<< "$FILES_TO_DELETE" # we are giving input 
