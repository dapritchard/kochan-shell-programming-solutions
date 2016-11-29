#!/bin/bash

# Write a function called substring that uses the leftmatch and rightmatch
# functions developed in Exercises 4 and 5 to remove a pattern from the left and
# right side of a value. It should take three arguments as shown:
#
#     $ substring /usr/ /usr/spool/uucppublic /uucppublic
#     spool
#     $ substring s. s.main.c .c
#     main
#     $ substring s. s.main.c .o
#     main.c
#     $ substring x. s.main.c .o
#     s.main.c


# Check that exactly 3 arguments were provided
if [ $# -ne 3 ]
then
    echo "usage: substring lpattern value rpattern"
    exit 1
fi

# Associate names with positional params for clarity
lpattern="$1"
value="$2"
rpattern="$3"

# Calculate the substring taken from the left and from the right
subs_l=$(./exer05.sh "$lpattern" "$value")
subs_r=$(./exer04.sh "$value" "$rpattern")

# Find the number of characters in the left substring, right substring, and the
# original value
nchar_l=${#subs_l}
nchar_r=${#subs_r}
nchar_v=${#value}

# Check if removing the left and right substring cumulatively obliterates
# $value: if yes then echo a blank line; if no then echo $value after removing
# the left and right substring
if [ $((nchar_l + nchar_r)) -le $nchar_v ]
then
    echo
else
    echo "$(./exer04.sh "$subs_l" "$rpattern")"
fi
