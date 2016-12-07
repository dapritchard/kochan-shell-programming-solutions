#!/bin/bash

CDHIST[0]=$PWD




# Take a pattern as $1 and try to match it using grep against the elements in
# $CDHIST.  If exactly 1 match is found, then cd to that directory, otherwise
# return 1.

cd_by_pattern () {

    typeset match_idx dir_pattern="${1#-}"
    typeset -i i cdlen=${#CDHIST[*]}

    # Step through $CDHIST and check each directory for a match with
    # $dir_pattern.  Whenever a match is found then append the index number to
    # $match_idx.
    ((i = 0))
    while ((i < cdlen))
    do
	if grep "$dir_pattern" <<< "${CDHIST[i]}" > /dev/null
	then
	    match_idx=$(echo "$match_idx $i")
	fi
	((i = i + 1))
    done
    
    # Set the positional parameters to the indices of the matches
    set -- $match_idx

    # Change directory if exactly 1 match is found, throw an error otherwise
    if [ $# -eq 0 ]
    then
	# case: no matches found; return 1
	echo "error: no matches found for $dir_pattern" >&2
	return 1
    elif [ $# -ge 2 ]
    then
	# case: mutliple matches found; print each match and return 1
	echo "error: multiple matches found for $dir_pattern" >&2
	for idx
	do
	    echo "${CDHIST[idx]}"
	done
	return 1
    else
	# case: exactly 1 match found; cd to it
	cd "${CDHIST[match_idx]}"
	return 0
    fi
    
}




# usage:
#
#     cdh -l          <-- show numbered directory history
#     cdh path        <-- cd to path
#     cdh -n          <-- cd to the n-th path in the directory history
#     cdh -pattern    <-- cd to the path in history that matches pattern, using
#                         grep

cdh ()  {

    typeset -i cdlen i 
    typeset match_idx

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

	''|*[!-0-9]*|*[0-9]-*|[0-9]*|-) # cd by path or pattern matching

	    case "$@" in
		-?*)                    # cd to new dir
		    cd_by_pattern "$@" 
		    return ;;

		*)                      # try to match pattern to history
		    cd "$@" ;;
	    esac ;;

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
