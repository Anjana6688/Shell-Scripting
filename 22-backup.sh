#!/bin/bash

# Its a backup script for applcation logs. It will create a backup of the application logs and store it in a backup directory.
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DESTINATION_DIR=$2
LOGFOLDER="/var/log/Install"
SCRIPTNAME=$( echo $0| cut -d "." -f1 )
LOGFILE="$LOGFOLDER/$SCRIPTNAME.log" # /var/log/Install/16-logs.log
SOURCE_DIR=/home/ec2-user/backup
DESTINATION_DIR=/home/ec2-user/backup-archive
mkdir -p $LOGFOLDER
echo "Script started executed at: $(date)" | tee -a $LOGFILE    

if [ $USERID -ne 0 ]; then
echo -e "ERROR:: script should be run as a root user"
exit 1 #failure other than zero
fi

# check Source directory exist or not
if [ ! -d "$SOURCE_DIR" ]; then
echo -e "ERROR:: $SOURCE_DIR directory does not exist" | tee -a $LOGFILE
exit 1
fi 

if [ ! -d "$DESTINATION_DIR" ]; then
echo -e "ERROR:: $DESTINATION_DIR directory does not exist" | tee -a $LOGFILE
exit 1
fi  



# function to check number of arguments passed to the script
USAGE() {
echo -e "$R USAGE: :  $0 <source_directory> <distination_directory> [optional, default 14 days] $N"
exit 1
}

if [ $# -lt 2 ]; then # $# is a special variable which holds the number of arguments passed to the script
USAGE
fi 

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

   if [ -z "$FILES" ]; then # z checks if the variable is empty or not
   echo -e "INFO:: No files found to backup" | tee -a $LOGFILE
   exit 0
   fi

  if [ ! -z "$FILES" ]; then # z checks if the variable is empty or not
   echo -e "INFO:: Files found to backup" | tee -a $LOGFILE
   TIMESTAMP=$(date +%F-%H-%M-%S)
   ZIP_FILE_NAME="backup-$TIMESTAMP.zip"
   find $SOURCE_DIR -name "*.log" -type f -mtime +14 | zip -@ -j $DESTINATION_DIR/$ZIP_FILE_NAME
  
   

   exit 0
   fi

