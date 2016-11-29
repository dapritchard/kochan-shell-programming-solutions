#!/bin/bash

# Write a function called rightmatch that takes two arguments as shown:
#
#     rightmatch value pattern 
#
# where value is a sequence of one or more characters, and pattern is a shell
# pattern that is to be removed from the right side of value. The shortest
# matching pattern should be removed from value and the result written to
# standard output. Here is some sample output:
#
#     $ rightmatch test.c .c
#     test
#     $ rightmatch /usr/spool/uucppublic '/*'
#     /usr/spool
#     $ rightmatch /usr/spool/uucppublic o
#     /usr/spool/uucppublic
#
# The last example shows that the rightmatch function should simply echo its
# first argument if it does not end with the specified pattern.


# Check that exactly 2 arguments were provided
if [ $# -ne 2 ]
then
    echo "usage: rightmatch value pattern"
    exit 1
fi

echo ${1%$2}
