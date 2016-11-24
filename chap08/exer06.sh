#!/bin/bash

# Write a shell program called wgrep that searches a file for a given pattern,
# just as grep does.  For each line in the file that matches, print a "window"
# around the matching line. That is, print the line preceding the match, the
# matching line, and the line following the match. Be sure to properly handle
# the special cases where the pattern matches the first line of the file and
# where the pattern matches the last line of the file.

# Usage: wgrep pattern filename
pattern=$1
filename=$2

# Check user input for validity
if [ $# -ne 2 ]
then
    echo 'usage: wgrep pattern filename'
    exit 1
elif ! [ -f $filename ]
then
    echo "file $filename not found"
    exit 1
fi

# Number of lines in the file
filelen=$(wc -l "$filename" | cut -d ' ' -f1)

# Obtain the line numbers on which matches are found
matches=$(grep -n "$pattern" "$filename" | cut -d ':' -f1)

# Each iteration through the loop prints the line before the $linum line, the
# line itself, and the line after.  This is accomplished in each iteration by
# using head to restrict the data to the first $linum + 1 lines, and then using
# tail to slice off the last 3 lines.  Note that consecutive line matches will
# result in overlapping data.
for linum in $matches
do
    # If a match is made on the last line then we only want a window of size 2
    # instead of size 3
    n_diff=$(($filelen - $linum))
    if [ 1 -le $n_diff ]
    then
	taillen=3
    else
	taillen=2
    fi

    echo '<-- start -->'
    head -$(($linum + 1)) "$filename" | tail -$taillen
    echo '<--  end  -->'
    echo ''
done
