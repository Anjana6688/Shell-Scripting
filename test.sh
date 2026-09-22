#!/bin/bash
echo "This script is called: $0"
SCRIPTNAME=$( echo $0| cut -d "." -f1 )
echo "$SCRIPTNAME"
