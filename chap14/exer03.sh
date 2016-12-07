#!/bin/bash

CDHIST[0]=$PWD


# usage:
#
#     cdh -l          <-- show numbered directory history
#     cdh path        <-- cd to path
#     cdh -n          <-- cd to the n-th path in the directory history

cdh ()  {

    typeset -i cdlen i

    if [ $# -eq 0 ]                     # default to HOME with no arguments
    then
	set -- $HOME
    fi

    cdlen=${#CDHIST[*]}                 # number of elements in CDHIST

    # Note that there are five 'cd' cases corresponding to any input not a dash
    # followed by an sequence of integers: (i) a null string, (ii) any case that
    # has a non-integer or dash in it, (iii) any dash that follows an integer,
    # (iv) any integer not following a dash, and (v) a plain dash.
    case "$@" in

	-l)                             # print directory list
	    i=0
	    while ((i < cdlen))
	    do
		printf "%3d %s\n" $i "${CDHIST[i]}"
		((i = i + 1))
	    done
	    return ;;

	''|*[!-0-9]*|*[0-9]-*|[0-9]*|-) # cd to new dir
	    cd "$@" ;;

	*)                              # cd to dir in list
            # remove leading '-'
	    i=${1#-}
	    if [ $i -lt $cdlen ]
	    then
		cd "${CDHIST[i]}" 
	    else
		echo "error: index $i is out-of-bounds" >&2
	    fi ;;
    esac

    # If directory is already in history then we can exit without placing
    # directory in history again.  The upper bound is due to the case -n
    # statement only handling digits 0-99
    ((i = cdlen - 1))
    while ((0 <= i))
    do
	if [ "$PWD" = "${CDHIST[i]}" ]
	then
	    return 
	fi
	((i = i - 1))
    done

    # If we've made it here then directory is not yet it history; place it there
    CDHIST[cdlen]="$PWD"
}
