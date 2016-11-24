#!/bin/bash

# Write a program called isyes that returns an exit status of 0 if its argument
# is "yes," and 1 otherwise. For purposes of this exercise, consider y, yes,
# Yes, YES, and Y all to be valid "yes" arguments:
#
#     $ isyes yes
#     $ echo $?
#     0
#     $ isyes no
#     $ echo $?
#     1
#
# Write the program using an if command and then rewrite it using a case
# command. This program can be useful when reading yes/no responses from the
# terminal (which you'll learn about in Chapter 10, "Reading and Printing
# Data").

# This is the case version

if [ $# -ne 1 ]
then
    echo 'error: must have exactly 1 argument' >&2
    exit 1
fi

case $1 in
    y)   exit 0;;
    yes) exit 0;;
    Yes) exit 0;;
    YES) exit 0;;
    Y)   exit 0;;
esac

# If we've made it here then the argument was not one of the recognized forms of
# yes
exit 1
