#!/usr/bin/env bash
# Note - this file is used only for generating the correrct hashes.
# If your intention is just to test your solution using somebody's tests,
# you do not need it at all.

if [ "$#" -ne 1 ]; then
  echo "Expected exactly 1 argument, but got $#" >&2
  echo "Usage: $0 <hopefully_correct_solution>" >&2
  exit 1
fi

prog="$1"
HASHES_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/.."

make -C "$HASHES_DIR/.." calc_hash >/dev/null || {
  echo "Error: Failed to compile calc_hash." >&2
  exit 1
}

echo "Generating expected hashes using: '$prog'"
echo "--------------------------------------------------"

for test_stdin in "$HASHES_DIR/../tests/"*.stdin; do
  [ -e "$test_stdin" ] || { echo "No .stdin files found."; break; }
  
  test_name="${test_stdin##*/}"
  test_name="${test_name%.stdin}"
  
  echo -n "Generating hash for $test_name... "

  hash=$("$HASHES_DIR/../hashed_run_test.sh" "$prog" "$test_name")
  
  echo "$hash" > "$HASHES_DIR/${test_name}.hash"
  echo "Done."
done