#!/bin/bash

# Modify rolo so that the menu is redisplayed after each selection is made and
# processed. To allow the user to get out of this, add another selection to the
# menu to exit from the program.

#
# If arguments are supplied, then do a lookup
#

if [ "$#" -ne 0 ]
then
    ./lu "$@"
    exit
fi

exitbool=FALSE

#
# Loop until user exits program
#

until [ "$exitbool" = TRUE ]
do

    #
    # Display menu
    #

    printf '
------------------
Would you like to:
------------------
0. Exit program
1. Look someone up
2. Add someone to the phone book
3. Remove someone from the phone book
Please select one of the above (0-3): '

    #
    # Read and process selection
    #

    read choice
    echo

    case "$choice"
	in

	0) exitbool=TRUE;;

	1) printf "Enter name to look up: "
	    read name
	    ./lu "$name";;

	2) printf "Enter name to be added: "
	    read name
	    printf "Enter number: "
	    read number
	    ./add "$name" "$number";;

	3) printf "Enter name to be removed: "
	    read name
	    ./rem "$name";;

	*) echo "Bad choice";;

    esac
done
