#!/usr/bin/env bash
set -eux

src="${HOME}/chromium/src/out/Release/Chromium.app/"
title="Chromium"
applicationName="${title}.app"
size="100m"
tmp="$(mktemp -d /tmp/$(basename $0).XXXXXXXX)"
dmg_tmp="${tmp}/${title}.dmg"
dmg="${HOME}/Dropbox/Public/Chromium-$(svn info ${HOME}/chromium/src/ | egrep "^Revision" | awk '{print $2}').dmg"

# The magic numbers in fsargs are recommended by the hdiutil man page to
# "minimize gaps at the front of the filesystem,
# allowing resize to squeeze more space from the filesystem"
hdiutil create -srcfolder "${src}" -volname "${title}" -fs HFS+ \
	-fsargs "-c c=64,a=16,e=16" -format UDRW -size "${size}" \
	"${dmg_tmp}"

# Use a randomly generated mount point name to ensure we don't unexpectedly clobber anything
attach_output=$(hdiutil attach -readwrite -noverify -noautoopen -mountrandom /Volumes "${dmg_tmp}")
device=$(echo "${attach_output}" | egrep "^/dev/" | sed -n "1p" | awk '{print $1}')
mount=$(echo "${attach_output}" | sed -n "2p" | awk '{print $3}')

rsync -av $(dirname "${0}")/VolumeOverlay/ ${mount}/
chmod -Rf go-w "${mount}" || true
sync
hdiutil detach ${device}
hdiutil convert "${dmg_tmp}" -format UDZO -imagekey zlib-level=9 -o "${dmg}"
rm -rf ${tmp}
