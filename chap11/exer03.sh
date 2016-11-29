#!/bin/bash

# Using the fact that the shell construct ${#var} gives the number of characters
# stored in var, rewrite wc in the shell. Be sure to use integer arithmetic!
# (Notes: Change your IFS variable to just a newline character so that leading
# whitespace characters on input are preserved, and also use the -r option to
# the shell's read command so that terminating backslash characters on the input
# are ignored.)

cctr=0  # character counter
wctr=0  # word counter
lctr=0  # line counter

whitesp="$IFS"
newline='
'          # Just a newline

# Set $IFS to just a newline so that leading or trailing spaces aren't lost when
# reading each line
IFS="$newline"

while read -r line
do
    # Reset the positional paramters according to the data in $line and obtain
    # the number of parameters by $#.  Need to reset $IFS so as to properly
    # split words.
    IFS="$whitesp"
    set -- $line
    wctr=$((wctr + $#))

    # Add the number of characters in $line plus 1 for the newline; see page 244
    # for the ${#variable} construct
    cctr=$((cctr + ${#line} + 1))
    echo "line:$line"
    echo "nchars:${#line}"

    # Each iteration adds 1 line
    lctr=$((lctr + 1))

    # Set $IFS to just a newline so that leading or trailing spaces aren't lost
    # when reading each line
    IFS="$newline"
done

echo "	$lctr	$wctr	$cctr"
