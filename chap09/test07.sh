#!/bin/bash

# Prevent script from overwriting an already existing phonebook file
if [ -f phonebook ]
then
    echo "A file named phonebook already exists; terminating"
    exit 0
fi

echo '
Adding:
-------
john	360-5830
frank	574-2217
frank	574-2217
chris	212-4957
christy	182-2484
'




# Add phonebook entries --------------------------------------------------------

echo '2
john
360-5830' | ./exer07.sh > /dev/null

echo '2
frank
574-2217' | ./exer07.sh > /dev/null

echo '2
frank
574-2217' | ./exer07.sh > /dev/null

echo '2
chris
212-4957' | ./exer07.sh > /dev/null

echo '2
christy
182-2484' | ./exer07.sh > /dev/null

echo "Current state of phonebook:"
echo "---------------------------"
cat phonebook

echo '
Press enter to continue...'
read dummyvar




# Look up entries --------------------------------------------------------------

echo '


Look up entries:
----------------'

echo '
Look up: john'
echo '1
john' | ./exer07.sh | grep john | sed 's/^.*\(john.*$\)/\1/'

echo '
Look up: chris'
echo '1
chris' | ./exer07.sh | grep chris | sed 's/^.*\(chris.*$\)/\1/'

echo '
Look up: asdf'
echo '1
asdf' | ./exer07.sh | grep asdf | sed 's/^.*\(asdf.*$\)/\1/'

echo '
Press enter to continue...'
read dummyvar




# Remove some entries ----------------------------------------------------------

echo '


Remove entries:
----------------'

echo '
phonebook after removing frank:'
echo '3
frank' | ./exer07.sh > /dev/null
cat phonebook

echo '
phonebook after removing asdf:'
echo '3
asdf' | ./exer07.sh > /dev/null
cat phonebook

echo '
phonebook after removing chris (y to chris and n to christy):'
echo '3
chris
y
n' | ./exer07.sh > /dev/null
cat phonebook

echo '
phonebook after removing christy:'
echo '3
christy' | ./exer07.sh > /dev/null
cat phonebook

echo '
phonebook after removing john:'
echo '3
john' | ./exer07.sh > /dev/null
cat phonebook

echo '
phonebook after removing steve:'
echo '3
steve' | ./exer07.sh > /dev/null
cat phonebook

echo '
Press enter to continue...'
read dummyvar




# Remove multiple matches ------------------------------------------------------

echo '

phonebook after re-adding chris and christy'

echo '2
chris
212-4957' | ./exer07.sh > /dev/null

echo '2
christy
182-2484' | ./exer07.sh > /dev/null

cat phonebook

echo '
phonebook after removing chris (n to chris and n to christy):'
echo '3
chris
n
n' | ./exer07.sh > /dev/null
cat phonebook

echo '
phonebook after removing chris (y to chris and y to christy):'
echo '3
chris
y
y' | ./exer07.sh > /dev/null

cat phonebook
echo ''


# Remove phonebook file --------------------------------------------------------

rm phonebook
