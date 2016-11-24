#/bin/bash

# Write a program called suffix that renames a file by adding the characters
# given as the second argument to the end of the name of the file given as the
# first argument.

mv "$1" "$1$2"
