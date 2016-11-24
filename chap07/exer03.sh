#!/bin/bash

# Write a program called mysed that applies the sed script given as the first
# argument against the file given as the second. If the sed succeeds (that is,
# exit status of zero), replace the original file with the modified one. So
#
# mysed '1,10d' text
#
# will use sed to delete the first 10 lines from text, and, if successful, will
# replace text with the modified file.

if [ $# -ne 2 ]
then
    echo 'error: must have exactly 2 arguments' >&2
    exit 1
fi

# Note: error handling handled by sed
if $(sed "$1" "$2" > /tmp/mysed)
then
    mv /tmp/mysed $2
fi
