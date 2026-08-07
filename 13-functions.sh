#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege"
    exit 1 # failure is other than 0
fi

# Functions
VALIDATE(){
if [ $1 -ne 0 ]; then
    echo "ERROR:: Installing $2 is failure"
    exit 1
else
    echo "Installing $2 is SUCCESS"
fi
}
dnf install mysql -y
VALIDATE $? mysql
#$? will store it in the $1 and mysql will store it in the $2


dnf install python3 -y
VALIDATE $? python3    

dnf install nginx -y
VALIDATE $? nginx
