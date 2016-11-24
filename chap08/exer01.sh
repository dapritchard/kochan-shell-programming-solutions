#!/bin/bash

# Modify the prargs program to precede each argument by its number. So typing
#
#     prargs a 'b c' d
#
# should give the following output:
#
#     1: a
#     2: b c
#     3: d

# The prargs program is found on page 169

argnum=0

while [ "$#" -ne 0 ]
do
    echo "$((argnum += 1)): $1"
    shift
done
