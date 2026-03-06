#!/usr/bin/env bash
set -euo pipefail

awk_path="$1"

# The resolved path should come from a multitool-managed repository.
if [[ "$awk_path" == *"multitool"* ]]; then
  echo "PASS: awk binary path contains 'multitool': $awk_path"
  exit 0
else
  echo "FAIL: awk binary path does not contain 'multitool': $awk_path"
  exit 1
fi
