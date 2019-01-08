#!/bin/bash

if [[ $EUID != 0 ]] ; then
    echo "deployr: Please run this as root, or via sudo."
    exit -1
fi
	read -p "This will completely erase the internal drives. Are you sure you want to do this ('yes' to erase, any other key to quit)? " ERASETARGET

	if [ ${ERASETARGET} != 'yes' ]; then
		exit -1
	fi

version=$(sw_vers -productVersion | cut -c4-5)

case ${version} in 
	14 ) 
		diskutil resetFusion ;;
	13|12|11 )
		disks=( $(diskutil list internal | grep /dev | awk '{print $1}'))
		for disk in ${disks[*]};
		do
			ssd_check=$(diskutil info "$disk" | grep "Solid State" | awk '{print $3}')
			if [ $ssd_check == 'Yes' ] ; then
				ssd="$disk"
			elif [ $ssd_check == 'No' ] ; then
				internal="$disk"
			fi
            if [ -n "$ssd" ] && [ -n "$internal" ]; then
                break
            fi
		done
		echo Internal HDD is "$internal"
		echo Internal SSD is "$ssd"

        diskutil cs create Macintosh\ HD "$internal" "$ssd"
        logicalvolumegroup=$(diskutil cs list | grep "Logical Volume Group" | awk '{print $5}')
        diskutil cs createVolume "$logicalvolumegroup" jhfs+ Macintosh\ HD 100%
        ;;
    * ) 
        break ;;
esac
