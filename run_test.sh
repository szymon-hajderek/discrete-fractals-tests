#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  printf "ERROR: Invalid arguments passed to run_test.sh\n" >&2
  printf "USAGE: run_test.sh <progam> <test_name>\n" >&2
  exit 1
fi

prog="$1"
test_name="$2"

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

if [ ! -f "$SCRIPT_DIR/tests/${test_name}.stdin" ]; then
  printf "ERROR: MISSING .stdin FILE\n" >&2
  exit 1
fi

if [ ! -f "$SCRIPT_DIR/tests/${test_name}.n" ]; then
  printf "ERROR: MISSING .n FILE\n" >&2
  exit 1
fi

# Read the exact text into $n
IFS= read -r -d '' n < "$SCRIPT_DIR/tests/${test_name}.n"

stats_file=$(mktemp)
/usr/bin/time -q -f "%e %M" -o "$stats_file" "$prog" "$n" < "$SCRIPT_DIR/tests/${test_name}.stdin"
exit_code=$?

read elapsed_sec peak_kb < "$stats_file"
echo -n "Time: $elapsed_sec s | Mem:  $peak_kb KiB" >&2

if [[ $exit_code != 0 ]]; then
  echo " | PROGRAM FAILED WITH EXIT CODE: $exit_code\n" >&2
else
  echo ""
fi