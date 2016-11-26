#!/bin/bash

# Modify rolo from this chapter so that a person running the program can keep
# his or her phone book file in any directory and not just in the home
# directory. This can be done by requiring that the user set an exported
# variable called PHONEBOOK to the name of the phone book file before executing
# rolo. Check to make sure that this variable is set to a valid file. If the
# variable is not set, have the program assume that the phone book file is in
# the user's home directory as before.
#
# Here are some examples:
#
#     $ PHONEBOOK=/users/steve/personal lu Gregory
#     Gregory	973-555-0370
#     $ PHONEBOOK=/users/pat/phonebook lu Toritos
#     El Toritos	973-555-2236
#
# In the preceding example, we assume that the user steve has been granted read
# access to pat's phone book file.

#
# Verify that $PHONEBOOK is the name of a valid file
#

. ./set_phb_loc

#
# Setting $PHB_STANDALONE to non-null value signals to add, lu, and rem that
# they do not need to check for validity of file specified by $PHONEBOOK during
# the use of rolo
#

PHB_STANDALONE=FALSE
export PHB_STANDALONE

#
# If arguments are supplied, then do a lookup
#

if [ "$#" -ne 0 ]
then
    ./lu "$@"
    exit
fi

#
# Loop until user exits program
#

exitbool=FALSE
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

    case "$choice" in

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
