#!/usr/bin/env bash
set -eux
export BUILDTYPE=Release
export GYP_GENERATORS=make
export GYP_DEFINES="clang=1 mac_sdk=10.6 fastbuild=1"
chromium_dir="${HOME}/chromium"

jobs="$(((2*$(sysctl -n hw.ncpu))+1))"
cd "${chromium_dir}"
"${chromium_dir}/src/build/gyp_chromium"
make -j $jobs chrome