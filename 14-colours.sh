#!/bin/bash

# Define color variables
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
NC='\e[0m' # No Color

echo -e "$GREEN This is a success message $NC"

echo -e "$RED ERROR "$NC # we need to define NC atlast otherwise it will continues colours for next lines.