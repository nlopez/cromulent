#!/usr/bin/env bash
cwd="$(dirname ${0})"
source "${cwd}/preflight.sh"
export BUILDTYPE=Release
export GYP_GENERATORS=make
export GYP_DEFINES="clang=1 mac_sdk=10.6 fastbuild=1"
jobs="$(((2*$(sysctl -n hw.ncpu))+1))"

cd "${CHROMIUM_ROOT}/src"
./build/gyp_chromium
make -j$jobs chrome
