#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

echo "Removing generated tests (keeping *manual)..."
echo "--------------------------------------------------"

find "$SCRIPT_DIR/tests" -maxdepth 1 -type f \
  \( -name "*.n" -o -name "*.stdin" \) \
  ! -name "*manual.n" \
  ! -name "*manual.stdin" \
  -delete

echo "Done cleaning tests."