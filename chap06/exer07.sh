#!/bin/bash

# Write a program called unsuffix that removes the characters given as the
# second argument from the end of the name of the file given as the first
# argument. So

# unsuffix memo1.sv .sv

# should rename memo1.sv to memo1. Be sure that the characters are removed from
# the end, so

# unsuffix test1test test

# should result in test1test being renamed to test1. (Hint: Use sed and command
# substitution.)

newname=$(echo "$1" | sed "s/\($2$\)//")
mv "$1" "$newname"
