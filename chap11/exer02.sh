#!/bin/bash

# Rewrite the home program from Exercise 5 in Chapter 7 to use the set command
# and the IFS to extract the home directory from /etc/passwd. What happens to
# the program if one of the fields in the file is null, as in
#
#     steve:*:203:100::/users/steve:/usr/bin/ksh
#
# Here the fifth field is null (::).

# Check that exactly 1 argument was provided
if [ $# -ne 1 ]
then
    echo "usage: home username"
    exit 1
fi

# Search each line of /etc/passwd for a match to user provided name and check
# that there is exactly 1 match
userline="$(grep "$1" /etc/passwd)"
if [ $? -ne 0 ]
then
    echo "no match for user $1"
    exit 1
elif [ $(echo "$userline" | wc -l) -gt 1 ]
then
    echo "multiple matches for user $1"
    exit 1
fi

# Extract the 6th field for a colon-separated values format
IFS=':'
set $userline
echo "$6"
