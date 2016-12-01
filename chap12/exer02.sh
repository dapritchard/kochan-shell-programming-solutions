#!/bin/bash

# Modify the shar program presented in this chapter to handle directories. shar
# should recognize input files from different directories and should make sure
# that the directories are created if necessary when the archive is
# unpacked. Also allow shar to be used to archive an entire directory.
#
#     $ ls rolo
#     lu
#     add
#     rem
#     rolo
#     $ shar rolo/lu rolo/add rolo/rem > rolosubs.shar
#     $ shar rolo > rolo.shar
#
# In the first case, shar was used to archive three files from the rolo
# directory. In the last case, shar was used to archive the entire rolo
# directory.


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
	
	# case: the file is in a subdirectory.  Check to see if the subdirectory
	# needs to be created
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
    fi
done
