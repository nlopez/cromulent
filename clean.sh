#!/usr/bin/env bash
chromium_dir="${HOME}/chromium"
if [[ -e "${chromium_dir}/src/out" ]]; then
	rm -rf "${chromium_dir}/src/out";
	echo "removed ${chormium_dir}/src/out"
else
	echo "nothing to clean"
fi
exit 0
