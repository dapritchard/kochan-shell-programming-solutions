#!/bin/bash

# What happens to mycp if one or more of the files to be copied doesn't exist?
# Can you make any suggestions to better handle the situation?

# If one or more of the files to be copied doesn't exist then the call to cp
# will fail.  As an alternative, the program will record which files don't exist
# and ask if you would like to proceed.

numargs=$#  # save this for later use
filelist=
copylist=
missinglist=

#
# Process the arguments, storing all but the last in filelist
#

while [ "$#" -gt 1 ]
do
    filelist="$filelist $1"
    shift
done

to="$1"

#
# If less than two args, or if more than two args and last arg
# is not a directory, then issue an error message
#

if [ "$numargs" -lt 2 -o "$numargs" -gt 2 -a ! -d "$to" ]
then
    echo "Usage: mycp file1 file2"
    echo "       mycp file(s) dir"
    exit 1
fi

#
# Sequence through each file in filelist
#

for from in $filelist
do

    #
    # Ensure that $from exists
    #

    if [ ! -f "$from" ]
    then
	missinglist="$missinglist $from"
	continue
    fi

    #
    # See if destination file is a directory
    #

    if [ -d "$to" ]
    then
	tofile="$to/$(basename $from)"
    else
	tofile="$to"
    fi

    #
    # Add file to copylist if file doesn't already exist or if user says it's
    # okay to overwrite
    #

    if [ -e "$tofile" ]
    then
	printf "$tofile already exists; overwrite (yes/no)? "
	read answer

	if [ "$answer" = yes ]
	then
	    copylist="$copylist $from"
	fi
    else
	copylist="$copylist $from"
    fi
done

#
# Check if there are missing files; if so, then prompt user whether to continue
# copying the remaining
#

if [ -n "$missinglist" ]
then
    echo "The following files do not exist: $missinglist"

    if [ -n "$copylist" ]
    then
	printf "Should the remaining files be copied (yes/no)?  "
	read answer

	if [ ! "$answer" = yes ]
	then
	    echo "Files not copied"
	    exit 0
	fi
    else
	echo "No remaining files to copy"
	exit 0
    fi
fi

#
# Now do the copy -- first make sure there's something to copy.  This is
# defensive programming: once we are here then we are assured that copylist is
# non-NULL.
#

if [ -n "$copylist" ]
then
    cp $copylist $to
    # proceed with the copy
fi
