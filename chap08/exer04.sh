#!/bin/bash

# Add a -n option to mon that inverts the monitoring function. So
#
#     waitfor -n sandy
#
# checks for sandy logging off the system, and
#
#     waitfor -n -f /tmp/dataout &
#
# periodically checks for the removal of the specified file.

fileopt=FALSE
mailopt=FALSE
invert=FALSE

interval=60
filename=
user=
inv_pref=

# Process command-line options
while getopts mnt:f: option
do
    case "$option" in
	f)  fileopt=TRUE
	    filename=$OPTARG;;

	m)  mailopt=TRUE;;

	n)  invert=TRUE
	    inv_pref=!;;

	t)  interval=$OPTARG;;

	\?) echo "Usage: waitfor [-m] [-n] [-f filename] [-t n] [user]"
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
until eval $inv_pref $condition
do
    sleep $interval
done

# Construct the message $msg to send to the user
if [ "$fileopt" = FALSE ]
then
    # Obtain terminal number
    tty=$(who | grep dpritch | sed 's/^[^[:space:]]* *\([^[:space:]]*\).*$/\1/')

    if [ "$invert" = FALSE ]
    then
	msg="$user logged onto $tty"
    else
	msg="$user logged off of $tty"
    fi
else
    if [ "$invert" = FALSE ]
    then
	msg="file $filename exists"
    else
	msg="file $filename doesn't exist"
    fi
fi

# Write message to stdout or send as an email
if [ "$mailopt" = FALSE ]
then
    echo $msg
else
    runner=$(who am i | cut -c1-8)
    echo $msg | mail $runner
fi
