#!/bin/bash

# Add a -f option to waitfor to have it periodically check for the existence of
# a file (ordinary file or directory) instead of for a user logging on. So
# typing
#
#     waitfor -f /usr/spool/uucppublic/steve/newmemo &
#
# should cause mon to periodically check for the existence of the indicated file
# and inform you when it does (by displaying a message or by mail if the -m
# option is also selected).

fileopt=FALSE
mailopt=FALSE

interval=60
filename=
user=

# Process command-line options
while getopts mt:f: option
do
    case "$option" in
	f)  fileopt=TRUE
	    filename=$OPTARG;;

	m)  mailopt=TRUE;;

	t)  interval=$OPTARG;;

	\?) echo "Usage: waitfor [-m] [-f filename] [-t n] [user]"
	    echo " -m means to be informed by mail"
	    echo " -f means to check for a file filename"
	    echo " -t means check every n secs."
	    exit 1;;
    esac
done

# Case: waitfor looks for a user (as opposed to a file)
if [ "$fileopt" = "FALSE" ]
then
    # Save user name to $user
    if [ "$OPTIND" -gt "$#" ]
    then
	echo "Missing user name!"
	exit 2
    else
	shiftcount=$((OPTIND - 1))
	shift $shiftcount
	user=$1
    fi
fi

# Set $condition to either (i) check for when a user logs in, or (ii) check if
# file named $filename exists
if [ "$fileopt" = FALSE ]
then
    condition='who | grep "^$user " > /dev/null'
else
    condition="[ -f $filename ]"
fi

# Sleep until $condition is met
until eval $condition
do
    sleep $interval
done

# Construct the message $msg to send to the user
if [ "$fileopt" = FALSE ]
then
    # Obtain terminal number
    tty=$(who | grep dpritch | sed 's/^[^[:space:]]* *\([^[:space:]]*\).*$/\1/')
    msg="$user logged onto $tty"
else
    msg="file $filename exists"
fi

# Write message to stdout or send as an email
if [ "$mailopt" = FALSE ]
then
    echo $msg
else
    runner=$(who am i | cut -c1-8)
    echo $msg | mail $runner
fi
