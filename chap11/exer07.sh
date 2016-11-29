#!/bin/bash

# Modify the substring, leftmatch, and rightmatch functions developed in the
# previous exercises to take options that allow you to remove the largest
# possible matches of the specified pattern from the left or right side of the
# specified value.

gr_opt=
while getopts g option
do
    case "$option" in
	
	g)  gr_opt=-g;;

	\?) echo "usage: substring [-l] lpattern value rpattern"
	    exit 1;;
    esac
done


# Check that exactly 3 arguments were provided.  $OPTIND points to 1 past the
# index of the last option (starting from 1), so we need there to be 2 more args
# after the current one
if [ $(($# - OPTIND)) -ne 2 ]
then
    echo "usage: [-g] substring lpattern value rpattern"
    exit 1
fi

# If necessary, shift the arguments past any option flags
shiftcount=$((OPTIND - 1))
shift $shiftcount

# Associate names with positional params for clarity
lpattern="$1"
value="$2"
rpattern="$3"

# Calculate the substring taken from the left and from the right
subs_l=$(./leftmatch $gr_opt "$lpattern" "$value")
subs_r=$(./rightmatch $gr_opt "$value" "$rpattern")

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
    echo "$(./rightmatch $gr_opt "$subs_l" "$rpattern")"
fi
