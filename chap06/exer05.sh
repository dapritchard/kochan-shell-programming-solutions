#!/bin/bash

# Write a program called home that takes the name of a user as its single
# argument and prints that user's home directory. So
#
#     home steve
#
# would print
#
#     /users/steve
#
# if /users/steve is steve's home directory. (Hint: Recall that the home
# directory is the sixth field stored in the file /etc/passwd.)

echo $(grep "$1" /etc/passwd | cut -d : -f6)
