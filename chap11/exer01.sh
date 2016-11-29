#!/bin/bash

# Given the following variable assignments (not shown), what will be the results
# of the following commands (not shown)?

echo 'Execute the following commands:
-------------------------------
EDITOR=/bin/vi
DB=
EDITFLAG=yes
PHONEBOOK=
'
EDITOR=/bin/vi
DB=
EDITFLAG=yes
PHONEBOOK=

printf 'Execute echo ${EDITOR}'
read ans
echo ${EDITOR}
echo

printf 'Execute echo ${DB:=/users/pat/db}'
read ans
echo ${DB:=/users/pat/db}
echo

printf 'Execute echo ${EDITOR:-/bin/ed}'
read ans
echo ${EDITOR:-/bin/ed}
echo

printf 'Execute echo ${PHONEBOOK:?}'
read ans
echo '** not executed; terminates program **'
echo

printf 'Execute echo ${DB:-/users/pat/db}'
read ans
echo ${DB:-/users/pat/db}
echo

printf 'Execute ed=${EDITFLAG:+${EDITOR:-/bin/ed}} ; echo $ed'
read ans
ed=${EDITFLAG:+${EDITOR:-/bin/ed}} ; echo $ed
echo
