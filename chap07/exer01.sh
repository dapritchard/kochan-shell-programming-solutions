#!/bin/bash

# Write a program called valid that prints "yes" if its argument is a valid
# shell variable name and "no" otherwise.
#
#     $ valid foo_bar
#     yes
#     $ valid 123
#     no
#
# (Hint: Define a regular expression for a valid variable name and then enlist
# the aid of grep or sed.)

# The definition of a valid variable name is found on page 97

if [ $# -ne 1 ]
then
    echo 'error: must have exactly 1 argument' >&2
    exit 1
fi


if echo "$1" | grep '^[[:alpha:]_][[:alnum:]_]*$' > /dev/null
then
    echo yes
else
    echo no
fi
