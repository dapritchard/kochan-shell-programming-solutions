#!/bin/bash

# Write a program called twice that takes a single integer argument and doubles
# its value:
#
#     $ twice 15
#     30
#     $ twice 0
#     0
#
# What happens if a noninteger value is typed? What if the argument is omitted?

# If a noninteger value is entered then it will return 0 if all of the
# characters are alphabetic; otherwise it will throw a syntax error.  If the
# argument is omitted then a syntax error is thrown.

echo $(($1 * 2))
