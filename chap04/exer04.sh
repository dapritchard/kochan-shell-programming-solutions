#!/bin/bash

# Display a sorted list of the logged-in users
who | cut -d' ' -f1 | sort -u
