#!/bin/bash

# Write a program called t that displays the time of day in a.m. or
# p.m. notation rather than in 24-hour clock time. Here's an example showing t
# run at night:
#
#     $ date
#     Wed Aug 28 19:34:01 EDT 2002
#     $ t
#     7:21 pm
#
# Use the shell's built-in integer arithmetic to convert from 24-hour clock
# time. Then rewrite the program to use a case command instead. Rewrite it again
# to perform arithmetic with the expr command.

# Presumably in the given example, the program should return 7:34?
#
# This version uses the case construct.

time=$(date | cut -c12-16)
hour=$(echo $time | cut -c1-2)
min=$(echo $time | cut -c4-5)


case $hour  in
    " 0") 
	echo "12:$min am";;

    " [:digit]:") 
	# Add 0 for side effect of stripping leading blank, e.g. " 7"
	echo "$((hour + 0)):$min am";;

    1[01])
	echo "$hour:$min am";;

    12)
	echo "12:$min pm";;

    *)
	echo "$((hour - 12)):$min pm";;
esac
