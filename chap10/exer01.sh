#!/bin/bash

# Write a program called myrm that takes as arguments the names of files to be
# removed. If the global variable MAXFILES is set, take it as the maximum number
# of files to remove without question. If the variable is not set, use 10 as the
# maximum. If the number of files to be removed exceeds this count, ask the user
# for confirmation before removing the files:
#
#     $ ls | wc -l
#     25
#     $ myrm *
#     Remove 25 files (y/n)? n
#     files not removed
#     $ MAXFILES=100 myrm *
#     $ ls
#     $
#
# If MAXFILES is set to zero, the check should be suppressed.

filelist=""
rmlist=""
missinglist=""
n_remove=0

# Check that at least one argument provided to program
if [ $# -eq 0 ]
then
    echo "usage: myrm FILE..."
    exit 1
fi

# If no value is exported for $MAXFILES, then the default value is set to 10
if [ ! -n "$MAXFILES" ]
then
    MAXFILES=10
else
    # Check that a valid (i.e. a nonegative integer value) is provided for
    # $MAXFILES
    case $MAXFILES in
	''|*[!0-9]*) 
	    echo "error: non-positive integer value provided for MAXFILES"
	    exit 1;;
    esac
fi

# Process the arguments, storing in filelist
while [ "$#" -gt 0 ]
do
    filelist="$filelist $1"
    shift
done

# Sequence through each file in $filelist
for delname in $filelist
do
    # Ensure that $delname exists
    if [ -f "$delname" ]
    then
	rmlist="$rmlist $delname"
	n_remove=$((n_remove + 1))
    else
	missinglist="$missinglist $delname"
    fi
done

# Check if there are missing files; if so, then prompt user whether to continue
# deleting the remaining
if [ -n "$missinglist" ]
then
    echo "The following files do not exist: $missinglist"

    if [ -n "$rmlist" ]
    then
	printf "Should the remaining files be removed (yes/no)?  "
	read answer

	if [ "_$answer" != _yes ]
	then
	    echo "Files not removed"
	    exit 0
	fi
    else
	echo "No remaining files to remove"
	exit 0
    fi
fi

# Perform the removal
if [ $n_remove -eq 0 ]
then
    echo "error: program should not reach this point"
    exit 1
    # Recall that setting $MAXFILES to 0 is a special instruction with the
    # behavior that $MAXFILES is ignored (i.e. treated as infinity)
elif [ $n_remove -gt $MAXFILES -a $MAXFILES -gt 0 ]
then
    echo "error: number of programs to delete is larger than MAXFILES"
    exit 1
else
    # Success: perform removal
    rm $rmlist
fi
