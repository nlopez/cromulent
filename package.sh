#!/usr/bin/env bash
set -eux

src="${HOME}/chromium/src/out/Release/Chromium.app/"
title="Chromium"
applicationName="${title}.app"
size="100m"
tmp="$(mktemp -d /tmp/$(basename $0).XXXXXXXX)"
dmg_tmp="${tmp}/${title}.dmg"
dmg="${HOME}/Dropbox/Public/Chromium-$(svn info /Users/nlopez/chromium/src/ | egrep "^Revision" | awk '{print $2}').dmg"

hdiutil create -srcfolder "${src}" -volname "${title}" -fs HFS+ \
	-fsargs "-c c=64,a=16,e=16" -format UDRW -size "${size}" \
	"${dmg_tmp}"

attach_output=$(hdiutil attach -readwrite -noverify -noautoopen "${dmg_tmp}")
device=$(echo "${attach_output}" | egrep "^/dev/" | sed 1q | awk '{print $1}')
mount=$(echo "${attach_output}" | sed -n "2p" | awk '{print $3}')

ln -s /Applications "${mount}/Applications"
cp ./ChromiumDS_Store "${mount}/.DS_Store"
chmod -Rf go-w "${mount}" || true
sync
hdiutil detach ${device}
hdiutil convert "${dmg_tmp}" -format UDZO -imagekey zlib-level=9 -o "${dmg}"
rm -rf ${tmp}
