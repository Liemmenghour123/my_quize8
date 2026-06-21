#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

fail() {
    echo "FAIL problem1: $*" >&2
    exit 1
}

[[ -f "1/vendor/lib/libscorecalc.so" ]] || fail "missing 1/vendor/lib/libscorecalc.so"

mkdir -p reports
./1/vendor/bin/score-report 1/data/scores.txt 80 > reports/dynamic-library-check.txt

expected="$(mktemp)"
cat > "${expected}" <<'EXPECTED'
dynamic score report
limit: 80
student count: 5
matched count: 2
sum of scores <= 80: 148
average of scores <= 80: 74.00
EXPECTED

diff -u "${expected}" reports/dynamic-library-check.txt || fail "unexpected dynamic-library-check.txt"
echo "PASS problem1"
