#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

echo "Generating test inputs..."
echo "--------------------------------------------------"

for test_generator_script in "$SCRIPT_DIR/test_generators/"*.py; do
  
  [ -e "$test_generator_script" ] || { echo "No .py files found."; break; }
  
  # Extract the name (strip .py)
  test_name="${test_generator_script##*/}"
  test_name="${test_name%.py}"
  
  echo "Running generator: $test_name"
  
  # Run the full script path, and route output to the correct extensions
  python3 "$test_generator_script" gen_n > "$SCRIPT_DIR/tests/${test_name}.n"
  python3 "$test_generator_script" gen_stdin > "$SCRIPT_DIR/tests/${test_name}.stdin"

done

echo "Done generating tests."