#!/bin/bash

cd testdir

x=*
y=?
z='one
two
three'
now=$(date)
symbol='>'

printf '\nPress enter to execute:  echo *** error ***'
read user_input
echo *** error ***

printf "\nPress enter to execute:  echo 'Is 5 * 4 > 18 ?'"
read user_input
echo 'Is 5 * 4 > 18 ?'

printf '\nPress enter to execute:  echo $x'
read user_input
echo $x

printf '\nPress enter to execute:  echo What is your name?'
read user_input
echo What is your name?

printf '\nPress enter to execute:  echo $y'
read user_input
echo $y

printf '\nPress enter to execute:  echo Would you like to play a game?'
read user_input
echo Would you like to play a game?

printf '\nPress enter to execute:  echo "$y"'
read user_input
echo "$y"

printf '\nPress enter to execute:  echo \*\*\*'
read user_input
echo \*\*\*

printf '\nPress enter to execute:  echo $z | wc -l'
read user_input
echo $z | wc -l

printf '\nPress enter to execute:  echo \$$symbol'
read user_input
echo echo \$$symbol

printf '\nPress enter to execute:  echo "$z" | wc -l'
read user_input
echo "$z" | wc -l

printf '\nPress enter to execute:  echo $\$symbol'
read user_input
echo $\$symbol

printf "\nPress enter to execute:  echo '\$z' I wc -l"
read user_input
echo '$z' I wc -l

printf '\nPress enter to execute:  echo "\\"'
read user_input
echo '*** Not run because this leaves an open quote ***'

printf '\nPress enter to execute:  echo _$now_'
read user_input
echo _$now_

printf '\nPress enter to execute:  echo "\\\\"'
read user_input
echo "\\"

printf '\nPress enter to execute:  echo hello $symbol out'
read user_input
echo hello $symbol out

printf '\nPress enter to execute:  echo \\\\'
read user_input
echo \\

printf '\nPress enter to execute:  echo "\\""'
read user_input
echo "\""

printf "\nPress enter to execute:  echo I don\'t understand"
read user_input
echo '*** Not run because this leaves an open quote ***\n'
