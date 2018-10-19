#!/bin/sh

# Builds a disk image for installers
# Could use an error trap and only check for root if needed.

# Check if root
if [[ $EUID != 0 ]] ; then
    echo "deployr: Please run this as root, or via sudo."
    exit -1
fi

function Usage() {
cat <<-ENDOFMESSAGE

Usage: $(basename "$0")
    make_install_dmg.sh /path/to/installer

ENDOFMESSAGE
    exit 1
}

function Die() {
    echo "$@"
    Usage
    exit 1
}

function GetOpts() {
    if [ "$#" -ne 1 ]; then
      Die "\nYou must specify the path to the installer."
    fi
}

GetOpts "$@"

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