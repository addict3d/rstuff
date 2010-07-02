#!/bin/bash
#
# rsync script to check for changes, 
# 
# usage: ./rcheck.sh local remote
#

if [ ! $1 ]
then
    #echo usage
    echo -e "\n##### Usage #####\n"
    echo "rcheck.sh /path/to/directory user@host:/path/to/directory"
    echo -e "\nor\n"
    echo "rcheck.sh /path/to/specific/file user@host:/path/to/file"
    echo -e "\n\nYou can pass the remote or the local path first, order doesnt matter."


else #use rsync

source=$1 	#source specification
dest=$2		#destination specification

#did user provide a trailing slash?
source=`echo "${source}" | sed -e "s/\/*$//"`

# dest=`echo "${dest}" | sed -e "s/\/*$//"`

#rsync call sent to "output" for processing
rsync --checksum --itemize-changes --dry-run $source/* $dest > output

if [ -s $output ]
then
   
   echo "Files Changed:"
   #print second field of rsync output, which is the file names
   awk '{print $2 "\t changed"}' output

   #cleanup
   rm output
else
   echo "No Changes."
fi


fi
