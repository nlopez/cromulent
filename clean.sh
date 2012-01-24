#!/usr/bin/env bash
cwd="$(dirname ${0})"
source "${cwd}/preflight.sh"
if [[ -e "${CHROMIUM_ROOT}/src/out" ]]; then
  rm -rf "${CHROMIUM_ROOT}/src/out";
  echo "removed ${CHROMIUM_ROOT}/src/out"
else
  echo "nothing to clean"
fi
exit 0
