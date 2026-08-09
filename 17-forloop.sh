#!/bin/bash


USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGFOLDER="/var/log/Install"
SCRIPTNAME=$( echo $0| cut -d "." -f1 )
LOGFILE="$LOGFOLDER/$SCRIPTNAME.log" # /var/log/Install/16-logs.log

mkdir -p $LOGFOLDER
echo "Script started executed at: $(date)" | tee -a $LOGFILE



if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege" | tee -a $LOGFILE
    exit 1 # failure is other than 0
fi

VALIDATE(){ # functions receive inputs through args just like shell script args
    if [ $1 -ne 0 ]; then
        echo -e "Installing $2 ... $R FAILURE $N"  | tee -a $LOGFILE
        exit 1
    else
        echo -e "Installing $2 ... $G SUCCESS $N" | tee -a $LOGFILE
    fi
}

# for i in {1..10}; do
#     echo " $i"
# done

for package in $@  #package consists inputs given on runtime.
do
    # check package is already installed or not
    dnf list installed $package &>>$LOG_FILE

    # if exit status is 0, already installed. -ne 0 need to install it
    if [ $? -ne 0 ]; then
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "$package already installed ... $Y SKIPPING $N"
    fi
done