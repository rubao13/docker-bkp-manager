#!/bin/bash
#
# Script to create directory backups.
# This script do:
#
#	1- create a tar.gz file from source directory
#	2- delete files with more then "n" days from directory
#


#
# define a string de uso do script
#
USAGE="\
usage: $folder-backup.sh [-o source_dir] [-d destination_dir] [-n num days]
       -o          source directory
       -d          destination directory
       -f          file name prefix
       -n          delete files with more then "n" days from directory

"

#
# sets variables
#
numdays="14";

#
# get parameters
#
while getopts o:d:f:n: OPTION
do
    case $OPTION in
    o)
        source_dir="$OPTARG"
        ;;
    d)
        destination_dir="$OPTARG"
        ;;
    f)
        fileprefix="$OPTARG"
        ;;
    n)
        numdays="$OPTARG"
        ;;
    *)
        echo "$USAGE"
        exit 1
    esac
done

#
# check parameters
#
if [[ -z ${source_dir} || -z ${destination_dir} || -z ${fileprefix} ]]
then
	echo "$USAGE"
	exit 1
fi

#
# create file name
#
filename=$fileprefix"_"`date +"%Y-%m-%d_%H_%M"`".tar.gz"
fullfilepath=$destination_dir"/"$filename


#
# check/create destination directory
#
if [[ ! -d ${destination_dir} ]]
then
	mkdir $destination_dir
fi

arr=$(echo $source_dir | tr "/" "\n")

for x in $arr
do
	if [[ ! -z ${x} ]]
	then
	    innerfolder=$x
	fi
done

#
# get diretory parent of source_dir
#
cd $source_dir
cd ..
source_parent_dir=$(pwd)

#
# create tar.gz 
#
tar -C $source_parent_dir -czf $fullfilepath $innerfolder
cd $destination_dir


#
# create link to this new tar.gz 
#
if [[ -L "latest-bkp" ]]
then
        rm "latest-bkp"
fi

ln -s $filename "latest-bkp"

#
# a MD5 from created file
#
md5sum $fullfilepath | awk '{print $1}' > latest-bkp-MD5

#
# remove old backups
#
eval "find "${destination_dir}" -maxdepth 1 -name '"${fileprefix}"*' -mtime +"${numdays}" -exec rm {} \;"


