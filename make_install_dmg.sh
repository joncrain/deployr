#!/bin/sh

# Builds a disk image for installers

INSTALLER="$1"
FILE=$(/usr/bin/basename $INSTALLER)
FILENAME=${FILE%.*}
FILEFINAL=$(echo ${FILENAME//[^a-zA-Z0-9]/_})

THISDIR=$(/usr/bin/dirname ${0})
DMGNAME="${THISDIR}/$FILEFINAL.dmg"
if [[ -e "${DMGNAME}" ]] ; then
    /bin/rm "${DMGNAME}"
fi
/usr/bin/hdiutil create -srcfolder "$1" "${DMGNAME}"