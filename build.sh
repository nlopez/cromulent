#!/usr/bin/env bash
set -eux
export BUILDTYPE=Release
export GYP_GENERATORS=make
export GYP_DEFINES="clang=1 mac_sdk=10.6 fastbuild=1"
jobs="$(((2*$(sysctl -n hw.ncpu))+1))"
chromium_dir="${HOME}/chromium"
chromium_dir_src="${chromium_dir}/src"
if [[ ! -e "${chromium_dir}" ]]; then 
	mkdir -p ${chromium_dir}
	cp -v ./gclient-conf ${chromium_dir}/.gclient
fi
cd "${chromium_dir}"
if [[ -e ./src/out ]]; then rm -rf ./src/out; fi
gclient sync --jobs 16
./src/build/gyp_chromium
make -j $jobs chrome
