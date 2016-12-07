#!/bin/bash

# Using only shell built-in commands, write a function that prints all filenames
# in a specified directory hierarchy. Its output should be similar to the output
# of the find command:
#
#     $ myfind /users/pat
#     /users/pat
#     /users/pat/bin
#     /users/pat/bin/ksh
#     /users/pat/bin/lf
#     /users/pat/bin/pic
#     /users/pat/chapt1
#     /users/pat/chapt1/intro
#     /users/pat/rje
#     /users/pat/rje/file1


# echo "nonempty" if $path is a nonempty directory, echo empty otherwise (even
# if $path is not a valid filename).  
#
# NOTE: dot files are ignored.
# NOTE: "$(ls -A "$path")" would be easier if we were allowed to use ls

is_empty () {
    typeset filenames=$(echo "$path"/*)
    # Note: the second test catches the special case when the only file in the
    # directory has name *
    if [ "$filenames" = "$path/*" -a ! -e "$path/*" ]
    then
	echo "empty"
    else
	echo "nonempty"
    fi
}


# Iterate through the pathnames in "$@" and write each one to stdout.  If the
# path is actually a nonempty subdirectory, then recursively call function with
# the files in the subdirectory.
#
# NOTE: dot files are ignored

write_pathnames () {

    for path
    do
	if [ ! -e "$path" ]
	then
	    echo "error: $path does not exist" >&2
	    exit
	fi

	echo "$path"
	# if [ -d "$path" ]
	if [ -d "$path" -a $(is_empty) = "nonempty" ]
	then
	    write_pathnames "$path"/*
	fi
    done
}


# call function
write_pathnames "$@"
