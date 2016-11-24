#!/bin/bash

# Modify the rem program used by rolo so that if multiple entries are found, the program will
# prompt the user for the entry to be removed.
# Here's a sample session:
#
#     $ rolo
#
#     ...
#
#     Please select one of the above (1-3): 3
#
#     Enter name to be removed: Susan
#
#     More than one match; please select the one to remove:
#
#     Susan Goldberg Remove (y/n)? n
#     Susan Topple Remove (y/n)? y

#
# If arguments are supplied, then do a lookup
#

if [ "$#" -ne 0 ]
then
    ./lu "$@"
    exit
fi

validchoice=""

#
# Loop until a valid selection is made
#

until [ -n "$validchoice" ]
do

    #
    # Display menu
    #

    printf '
Would you like to:
1. Look someone up
2. Add someone to the phone book
3. Remove someone from the phone book
Please select one of the above (1-3): '

    #
    # Read and process selection
    #

    read choice
    echo

    case "$choice"
	in

	1) printf "Enter name to look up: "
	    read name
	    ./lu "$name"
	    validchoice=TRUE;;

	2) printf "Enter name to be added: "
	    read name
	    printf "Enter number: "
	    read number
	    ./add "$name" "$number"
	    validchoice=TRUE;;

	3) printf "Enter name to be removed: "
	    read name
	    ./rem "$name"
	    validchoice=TRUE;;

	*) echo "Bad choice";;

    esac
done
