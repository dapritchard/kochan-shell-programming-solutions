#/bin/bash

# Modify the waitfor program to also print the tty number that the user logs on
# to. That is, the output should say
#
#     sandy logged onto tty13
#
# if sandy logs on to tty13.

# The waitfor program on page 182-183

mailopt=FALSE
interval=60

# process command options

while getopts mt: option
do
    case "$option" in
	m)  mailopt=TRUE;;
	t)  interval=$OPTARG;;
	\?) echo "Usage: waitfor [-m] [-t n] user"
	    echo " -m means to be informed by mail"
	    echo " -t means check every n secs."
	    exit 1;;
    esac
done

# Make sure a user name was specified

if [ "$OPTIND" -gt "$#" ]
then
    echo "Missing user name!"
    exit 2
fi

shiftcount=$((OPTIND - 1))
shift $shiftcount
user=$1

#
# Check for user logging on
#

until who | grep "^$user " > /dev/null
do
    sleep $interval
done

#
# When we reach this point, the user has logged on
#

tty=$(who | grep $user | sed 's/^[^[:space:]]* *\([^[:space:]]*\).*$/\1/')

if [ "$mailopt" = FALSE ]
then
    echo "$user logged onto $tty"
else
    runner=$(who am i | cut -c1-8)
    echo "$user logged onto $tty" | mail $runner
fi
