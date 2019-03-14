#!/bin/bash

if [[ $EUID != 0 ]] ; then
    echo "deployr: Please run this as root, or via sudo."
    exit -1
fi
	read -p "This will completely erase the internal drive. Are you sure you want to do this ('yes' to erase, any other key to quit)? " ERASETARGET

	if [ ${ERASETARGET} != 'yes' ]; then
		exit -1
	fi

convertDisk=$(diskutil list internal | grep -B 2 "APFS Container Scheme" | grep /dev | awk '{print $1}')

echo Converting $convertDisk to HFS

diskutil apfs deleteContainer "$convertDisk"

diskutil unmountDisk force /Volumes/Untitled

diskutil eraseDisk JHFS+ "Macintosh HD" /dev/disk0

exit