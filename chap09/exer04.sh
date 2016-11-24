#!/bin/bash

# Modify mycp to prompt for arguments if none are supplied. A typical execution
# of the modified version should look like this:
#
#     $ mycp
#     Source file name? voucher
#     Destination file name? voucher.sv
#
# Make sure that the program allows one or both of the files to be specified
# with filename substitution characters.

numargs=$#  # save this for later use
numfrom=-1
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
# If only one arg, or if more than two args and last arg is not a directory,
# then issue an error message
#

if [ "$numargs" -eq 1 -o "$numargs" -gt 2 -a ! -d "$to" ]
then
    echo "Usage: mycp SOURCE DEST"
    echo "       mycp SOURCE... DIRECTORY"
    exit 1
fi

#
# If zero args, then prompt the user for arguments
#

if [ "$numargs" -eq 0 ]
then

    # Read source files
    from=' '
    while [ -n "$from" ]
    do
	printf 'enter source file (press enter to end):  '
	read from
	filelist="$filelist $from"

	# Strip leading whitepace
	from=$(printf "$from" | sed "s/^[ \t]*//")
	# Increment count of source files
	: $((numfrom += 1))
    done
    
    # Check that at least one source file given
    if [ $numfrom -eq 0 ]
    then
	echo "error: require at least one source file to be specified"
	exit 1
    fi

    # Read destination file
    printf 'enter destination file:  '
    read to
    to=$(printf "$to" | sed "s/^[ \t]*//")
    if [ ! -n $to ]
    then
	echo "error: invalid argument to destination file"
	exit 1
    fi
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
	printf "$tofile already exists; overwrite (yes/no)?  "
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
