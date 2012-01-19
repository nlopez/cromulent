#!/usr/bin/env bash
set -eux
export BUILDTYPE=Release
export GYP_GENERATORS=make
export GYP_DEFINES="clang=1 mac_sdk=10.6 fastbuild=1"
jobs="$(((2*$(sysctl -n hw.ncpu))+1))"
src_dir="/Users/nlopez/chromium/src"
cd "${src_dir}"
rm -rf ./out
gclient sync --jobs 16
./build/gyp_chromium
make -j $jobs chrome
