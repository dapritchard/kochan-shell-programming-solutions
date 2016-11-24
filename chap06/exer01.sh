#!/bin/bash

# Modify lu so that it ignored case when doing the lookup

# lu looks somebody up in the file "phonebook" (see pages 124-125).  Usage:
#
#     lu lookup_name
#

grep -i "$1" phonebook
