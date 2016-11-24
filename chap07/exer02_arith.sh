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
# This version uses integer arithmetic.

time=$(date | cut -c12-16)
hour=$(echo $time | cut -c1-2)
min=$(echo $time | cut -c4-5)


if [ $hour -eq 0 ]
then
    echo "12:$min am"
elif [ $hour -le 11 ]
then
    # Add 0 for side effect of stripping leading blank, e.g. " 7"
    echo "$((hour + 0)):$min am"
elif [ $hour -eq 12 ]
then
    echo "12:$min pm"
else
    echo "$((hour - 12)):$min pm"
fi
