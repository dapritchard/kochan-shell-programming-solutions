#! /bin/bash

cd testdir

printf '\n$ ls\n'
ls
printf '\n'

printf "Press enter to execute:  echo *"
read user_input
echo *

printf "Press enter to execute:  echo *[!0-9]"
read user_input
echo *[!0-9]

printf "Press enter to execute:  echo m[a-df-z]*"
read user_input
echo m[a-df-z]*

printf "Press enter to execute:  echo [A-Z]*"
read user_input
echo [A-Z]*

printf "Press enter to execute:  jan*"
read user_input
echo jan*

printf "Press enter to execute:  echo *.*"
read user_input
echo *.*

printf "Press enter to execute:  echo ?????"
read user_input
echo ?????

printf "Press enter to execute:  echo *02"
read user_input
echo *02

printf "Press enter to execute:  echo jan?? feb?? mar??"
read user_input
echo jan?? feb?? mar??

printf "Press enter to execute:  echo [fjm][ae][bnr]*"
read user_input
echo [fjm][ae][bnr]*
