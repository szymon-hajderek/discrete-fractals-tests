#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Error: Expected exactly 1 argument, but got $#." >&2
  echo "Usage: $0 <executable_path>" >&2
  echo "Example: $0 ./prog" >&2
  exit 1
fi

prog="$1"
SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

make -C "$SCRIPT_DIR" calc_hash >/dev/null || {
  echo "Error: Failed to compile calc_hash." >&2
  exit 1
}

echo "Running tests for: '$prog'"

for test_stdin in "$SCRIPT_DIR/tests/"*.stdin; do
  [ -e "$test_stdin" ] || { echo "No .stdin files found."; break; }

  test_name="${test_stdin##*/}"
  test_name="${test_name%.stdin}"

  printf "%-35s " "Test '$test_name':"
  
  hash=$("$SCRIPT_DIR/hashed_run_test.sh" "$prog" "$test_name")
  
  expected_file="${SCRIPT_DIR}/expected_hashes/${test_name}.hash"
  if [ ! -f "$expected_file" ]; then
     echo "MISSING EXPECTED HASH"
     continue
  fi

  expected_hash=$(cat "$expected_file")
  
  # Fixed the typo here: $"..." -> "$..."
  if [[ "$hash" != "$expected_hash" ]]; then
    echo "FAIL (Got $hash, expected $expected_hash)"
  else
    echo "OK"
  fi
done