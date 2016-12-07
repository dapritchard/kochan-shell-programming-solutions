#!/bin/bash

typeset -i decnum

for octnum
do
    case "$octnum" in

	''|*[!0-7]*)
	    echo "error: invalid number $octnum" >&2
	    exit 1;;

	*) decnum=0$octnum  # see page 306 for this syntax
	   echo "$octnum --> $decnum"
    esac
done
