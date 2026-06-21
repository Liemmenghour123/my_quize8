#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"${ROOT_DIR}/autograder/check_structure.sh"
"${ROOT_DIR}/autograder/problem1.sh"
"${ROOT_DIR}/autograder/problem2.sh"
"${ROOT_DIR}/autograder/problem3.sh"
"${ROOT_DIR}/autograder/problem4_7.sh"

echo "PASS: all autograding checks passed"
