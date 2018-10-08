#!/bin/sh

# Builds a disk image containing High Sierra installer.

THISDIR=$(/usr/bin/dirname ${0})
DMGNAME="${THISDIR}/highsierra.dmg"
if [[ -e "${DMGNAME}" ]] ; then
    /bin/rm "${DMGNAME}"
fi
/usr/bin/hdiutil create -srcfolder "${THISDIR}/highsierra" "${DMGNAME}"