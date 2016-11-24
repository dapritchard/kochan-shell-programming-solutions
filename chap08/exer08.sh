#!/bin/bash

# Modify wgrep to take a variable number of filenames as arguments. Precede each
# output line with the name of the file in which the match occurs (as grep
# does).

# Usage: wgrep [-w winsize] pattern filename...

# Determine window size $winsize; default is 1
winsize=1
while getopts w: option
do
    case "$option" in

	w)  winsize=$OPTARG
	    # Ensure that an integer argument is passed to -w
	    case $winsize in

		# Checks for empty value or anything not a digit
		''|*[!0-9]*) 
		    echo "non-integer argument for -w"
		    exit 1;;

		*)
		    # noop
		    :;;
	    esac;;

	\?) echo 'invalid option!'
	    echo 'usage: wgrep [-w winsize] pattern filename...'
	    exit 1;;
    esac
done

# Check at least one argument provided for pattern and filename
if [ "$OPTIND" -ge "$#" ]
then
    echo "missing file name or pattern!"
    echo 'usage: wgrep [-w winsize] pattern filename...'
    exit 2
fi

# If necesary move argument position past -w winsize args; save pattern to
# $pattern; move argument position to first filename argument
shiftcount=$((OPTIND - 1))
shift $shiftcount
pattern=$1
shift 1

# Check filename arguments for validity
for filename in "$@"
do
    if ! [ -f $filename ]
    then
	echo "file $filename not found"
	exit 1
    fi
done

# Each iteration of loop prints the window around each match of pattern found
# for a given argument of filename
for filename in "$@"
do
    # Number of lines in the file
    filelen=$(wc -l "$filename" | cut -d ' ' -f1)

    # Obtain the line numbers on which matches are found
    matches=$(grep -n "$pattern" "$filename" | cut -d ':' -f1)
    if [ ! -n "$matches" ]
    then
	continue
    fi

    # Print file banner header
    echo "==================== begin file $filename"
    echo ""

    # Each iteration through the loop prints the line before the $linum line, the
    # line itself, and the line after.  This is accomplished in each iteration by
    # using head to restrict the data to the first $linum + 1 lines, and then using
    # tail to slice off the last 3 lines.  Note that consecutive line matches will
    # result in overlapping data.
    for linum in $matches
    do
	# If a match is made near the end of the file, then we may need to adjust
	# the parameter given to tail accordingly
	n_diff=$(($filelen - $linum))
	if [ $winsize -le $n_diff ]
	then
	    taillen=$((2 * $winsize + 1))
	else
	    taillen=$(($winsize + 1 + $n_diff))
	fi

	echo '<-- start -->'
	head -$(($linum + $winsize)) $filename | tail -$taillen
	echo '<--  end  -->'
	echo ''
    done

    # Print file banner tail
    echo "==================== end file $filename"
    echo ""
    echo ""

done # end print matches in file loop
