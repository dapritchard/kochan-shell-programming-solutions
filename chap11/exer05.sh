#!/bin/bash

# Write a function called leftmatch that works similarly to the rightmatch function developed in
# Exercise 4. Its two arguments should be as follows:
#
#     leftmatch pattern value
#
# Here are some example uses:
#
#     $ leftmatch /usr/spool/ /usr/spool/uucppublic
#     uucppublic
#     $ leftmatch s. s.main.c
#     main.c


# Check that exactly 2 arguments were provided
if [ $# -ne 2 ]
then
    echo "usage: leftmatch pattern value"
    exit 1
fi

echo ${2#$1}

