#!/bin/sh

# Builds a disk image containing Mojave installer.

THISDIR=$(/usr/bin/dirname ${0})
DMGNAME="${THISDIR}/mojave.dmg"
if [[ -e "${DMGNAME}" ]] ; then
    /bin/rm "${DMGNAME}"
fi
/usr/bin/hdiutil create -srcfolder "${THISDIR}/mojave" "${DMGNAME}"