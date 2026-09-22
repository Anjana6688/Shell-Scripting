#!/bin/bash

filename="18-script1.sh"

# -r prevents backslash escapes from being interpreted
# IFS= prevents leading/trailing whitespace from being trimmed
while IFS= read -r line; do
    echo "$line"
done < "$filename"