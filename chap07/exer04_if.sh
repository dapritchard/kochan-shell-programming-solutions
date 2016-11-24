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

# This is the if command version

if [ $# -ne 1 ]
then
    echo 'error: must have exactly 1 argument' >&2
    exit 1
fi


# Note: leading underscore added to insure that arguments containing only
# whitespace don't cause an error
if [ "_$1" = _y -o     \
    "_$1" = _yes -o    \
    "_$1" = _Yes -o    \
    "_$1" = _YES -o    \
    "_$1" = _Y ]
then
    exit 0
else
    exit 1
fi
