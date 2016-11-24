#!/bin/bash

# Write a program called collect that runs in the background and counts the
# number of users logged in at the end of each interval and also the number of
# processes run during that interval.  Allow the interval to be specified with a
# -t option (see the previous exercise), with the default 10 minutes. Use the
# fact that the special shell variable $! is set to the process number of the
# last command executed in the background and that
#
#     : &
#
# runs a null command in the background. Also make sure that the program
# correctly handles the case where the process number loops back around to 1
# after the maximum is reached.
#
# So
#
#     collect -t 900 > stats &
#
# should start up collect to gather the desired statistics every 15 minutes and
# write them into the file stats.


# I don't understand why I would use the $! variable and the : $ command so I am
# ignoring this direction.  Also I am ignoring the direction to test for
# overflow.

interval=600

# Process command-line options
while getopts t: option
do
    case "$option" in

	t)  interval=$OPTARG;;

	\?) echo "Usage: collect [-t n]"
	    echo " -t means check every n secs."
	    exit 1;;
    esac
done

# Infinite loop; terminate manually
while :
do
    echo "$(date)"
    echo "$(ps | wc -l) processes"
    echo "$(who | wc -l) users"
    echo ""

    sleep $interval
done
