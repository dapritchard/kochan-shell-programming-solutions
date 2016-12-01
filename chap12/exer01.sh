#!/bin/bash

# Using eval, write a program called recho that prints its arguments in reverse order. So
#
#     recho one two three
#
# should produce
#
#     three two one
#
# Assume that more than nine arguments can be passed to the program.

k=$#

while [ $k -ge 1 ]
do
    # Note that one set of quotation marks are escaped so that they're left
    # around to enclose the string in the second evaluation
    eval printf "\"[\${$k}]    \""
    k=$((k - 1))
done

echo
