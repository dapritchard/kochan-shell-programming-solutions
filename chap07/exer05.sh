#!/bin/bash

# Use the date and who commands to write a program called conntime that prints
# the number of hours and minutes that a user has been logged on to the system
# (assume that this is less than 24 hours).

# Check that exactly 1 argument is passed
if [ $# -ne 1 ]
then
    echo 'error: must have exactly 1 argument' >&2
    exit 1
fi

# Save the line from who with the desired user's information to user_info;
# ensure that exactly 1 line is matched by grep
user_info=$(who | grep "$1")
if [ "_$user_info" = "_" ]
then
    echo 'error: argument had no matches' >&2
    exit 1
elif [ $(echo "$user_info" | wc -l) -ge 2 ]
then
    echo 'error: argument matches more than 1 name' >&2
    exit 1
fi

# Extract hours and minutes for login
log_hr=$(who | cut -c34-35)
log_min=$(who | cut -c37-38)

# Extract hours and minutes at current time
curr_hr=$(date | cut -c12-13)
curr_min=$(date | cut -c15-16)

# Calculate the difference between the current hour and login hour, and the
# current minute and login minute
diff_hr=$((curr_hr - log_hr))
diff_min=$((curr_min - log_min))

# If current minute is less than login minute then take one from the hours
# difference and add 60 the the minutes difference
if [ $diff_min -lt 0 ]
then
    : $((diff_hr -= 1))
    : $((diff_min += 60))
fi

# If the current time is less that the login time, then the login must have
# happened yesterday (since we assume that it happened within the last 24 hours,
# per the directions)
if [ $diff_hr -lt 0 ]
then
    : $((diff_hr += 24))
fi

printf "The amount of time since login is:  %d hours and %d minutes\n"  \
    $diff_hr                                                            \
    $(($diff_min + 0))
