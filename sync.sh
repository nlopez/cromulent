#!/usr/bin/env bash
cwd="$(dirname ${0})"
source "${cwd}/preflight.sh"
jobs=16

do_sync_init(){
  sed '/safesync_url/d' "${cwd}/gclient-conf-init" > "${CHROMIUM_ROOT}/.gclient"
  cd "${CHROMIUM_ROOT}"
  gclient sync --jobs=$jobs
}

do_sync(){
  cp "${cwd}/gclient-conf" "${CHROMIUM_ROOT}/.gclient"
  cd "${CHROMIUM_ROOT}"
  gclient sync --jobs=$jobs
}

if [[ ! -d "${CHROMIUM_ROOT}" ]]; then
  mkdir -p "${CHROMIUM_ROOT}"
  do_sync_init
else
  do_sync
fi
