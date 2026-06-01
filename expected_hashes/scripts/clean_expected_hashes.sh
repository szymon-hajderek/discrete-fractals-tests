#!/usr/bin/env bash
# Note - this file is used only for generating the correrct hashes.
# If your intention is just to test your solution using somebody's tests,
# you do not need it at all.

prog="$1"
HASHES_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/.."

for hash_file in "${HASHES_DIR}/"*.hash; do
  [ -e "$hash_file" ] || { echo "No .hash files found."; break; }
  rm "$hash_file"
done