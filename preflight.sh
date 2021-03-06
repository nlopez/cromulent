#!/usr/bin/env bash
cwd="$(dirname ${0})"

# Make sure the binaries we need are available
binaries=( gclient make clang hdiutil )
for binary in ${binaries[@]}; do
  type "${binary}" 2>&1 > /dev/null
  test="${?}"
  if (( ${test} != 0 )); then
    echo "${binary} not found in your PATH. Cannot proceed." 1>&2
    exit 1
  fi
done

# Preferentially use a user's settings instead of our defaults
if [[ -f "${cwd}/cromulent.local" ]]; then
  conf_file="${cwd}/cromulent.local"
else
  conf_file="${cwd}/cromulent.conf"
fi

conf_file_short="$(basename ${conf_file})"
if [[ -f "${conf_file}" ]]; then
  source "${conf_file}"
  if [[ -z "${CHROMIUM_ROOT}" ]]; then
    echo "${conf_file_short} exists but CHROMIUM_ROOT is not defined"
    exit 1
  fi
  if [[ -z "${OUTPUT_DIR}" ]]; then
    echo "${conf_file_short} exists but OUTPUT_DIR is not defined"
    exit 1
  fi
else
  echo "${conf_file_short} does not exist"
  exit 1
fi

