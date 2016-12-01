#!/bin/bash

# Modify shar to include in the archive the character count for each file and
# commands to compare the count of each extracted file against the count of the
# original file. If a discrepancy occurs, an error should be noted, as in
#
#     add: expected 345 characters, extracted 343.


# Ensure that every file exists
for file
do
    if [ ! -e "$file" ]
    then
	echo "error: file $file not found" >&2
	exit 1
    fi
done

echo '#!/bin/bash'
echo
echo '# ``````````````````````````` #'
echo '# To restore, type sh archive #'
echo '# ........................... #'
echo

for file
do
    if [ -d "$file" ]
    then
	cat <<-THE-END-OF-DATA
	
	if [ ! -d "$file" ]
	then
	    mkdir "$file"
	fi
	
	THE-END-OF-DATA

	# case: nonempty subdirectory.  Recursively call program with
	# subdirectory files
	if [ -n "$(ls -A "$file")" ]
	then
	    ./exer02.sh "$file"/*
	fi
    else
	
	cat <<-THE-END-OF-DATA
	
	# case: the file is in a subdirectory.  Create the subdirectory if it
	# does not yet exist.
	if [ "${file%/*}" != "$file" ]
	then
	    mkdir -p "${file%/*}"
	fi
	
	THE-END-OF-DATA

	echo
	echo "echo Extracting $file"
	echo "cat > $file <<\THE-END-OF-DATA"
	cat $file
	echo "THE-END-OF-DATA"

	# Store the md5 checksum for the archived file
	md5sum "$file" >> /tmp/shar$$
    fi
done


echo 'echo'
echo 'echo "Checking file md5 checksums:"'
echo 'echo "----------------------------"'
echo 'md5sum -c <<\THE-END-OF-DATA'
cat /tmp/shar$$
echo "THE-END-OF-DATA"
