#!/bin/bash
# Varaibles

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGFOLDER="/var/log/Install"
SCRIPTNAME= $( echo $0| cut -d "." -f1 )
LOGFILE="$LOGFOLDER/$ScRIPTNAME.log" # /var/log/Install/16-logs.log

mkdir -p $LOGFOLDER
echo "Script started executed at: $(date)" | tee -a $LOG_FILE



if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege" | tee -a $LOG_FILE
    exit 1 # failure is other than 0
fi

VALIDATE(){ # functions receive inputs through args just like shell script args
    if [ $1 -ne 0 ]; then
        echo -e "Installing $2 ... $R FAILURE $N" 
        exit 1
    else
        echo -e "Installing $2 ... $G SUCCESS $N"
    fi
}

dnf list installed mysql $>>$LOGFILE
# Install if it is not found
if [ $? -ne 0 ]; then
    dnf install mysql -y  $>>$LOGFILE 
    VALIDATE $? "MySQL"
else
    echo -e "MySQL already exist ... $Y SKIPPING $N"
fi

dnf list installed nginx $>>$LOGFILE
if [ $? -ne 0 ]; then
    dnf install nginx -y $>>$LOGFILE
    VALIDATE $? "Nginx"
else
    echo -e "Nginx already exist ... $Y SKIPPING $N"
fi

dnf list installed python3 $>>$LOGFILE
if [ $? -ne 0 ]; then
    dnf install python3 -y $>>$LOGFILE  
    VALIDATE $? "python3"
else
    echo -e "Python3 already exist ... $Y SKIPPING $N"
fi