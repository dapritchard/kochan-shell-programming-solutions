#!/bin/bash

# The program ison from this chapter has a shortcoming as shown in the following
# example:
#
#     $ ison ed
#     fred     tty03    Sep  4 14:53
#
# The output indicates that fred is logged on, while we were checking to see
# whether ed was logged on.  Modify ison to correct this problem.

# ison is found on page 122.  Usage:
#
#     ison dpritch

who | grep -i "^$1 "
