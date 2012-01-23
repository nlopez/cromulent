#!/usr/bin/env bash
set -eux
chromium_dir="${HOME}/chromium"
chromium_dir_src="${chromium_dir}/src"

do_initial_sync(){
	cp -v "$(dirname ${0})/gclient-conf-init" "${chromium_dir}/.gclient"
	cd "${chromium_dir}"
	gclient sync --jobs 16
}

do_sync(){
	cp -v "$(dirname ${0})/gclient-conf" "${chromium_dir}/.gclient"
	cd "${chromium_dir}"
	gclient sync --jobs 16
}

if [[ ! -e "${chromium_dir}" ]]; then 
	mkdir -p "${chromium_dir}"
	do_initial_sync
else
	do_sync
fi
