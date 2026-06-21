#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

fail() {
    echo "FAIL problem2: $*" >&2
    exit 1
}

[[ -f "2/final-env.sh" ]] || fail "missing 2/final-env.sh"

rm -f reports/env-result.txt
mkdir -p reports

set +u
. ./2/final-env.sh
set -u

[[ "${FINAL_QUIZ_MODE:-}" == "final" ]] || fail "FINAL_QUIZ_MODE must be final"
[[ "${FINAL_REPORT_NAME:-}" == "env-result" ]] || fail "FINAL_REPORT_NAME must be env-result"
[[ "${FINAL_SCORE_LIMIT:-}" == "80" ]] || fail "FINAL_SCORE_LIMIT must be 80"
[[ "${FINAL_DATA_FILE:-}" == "data/scores.txt" ]] || fail "FINAL_DATA_FILE must be data/scores.txt"

./2/env-report >/tmp/fquiz-env-report.stdout
[[ -f "reports/env-result.txt" ]] || fail "missing reports/env-result.txt"

expected="$(mktemp)"
cat > "${expected}" <<'EXPECTED'
env_status=ready
quiz_mode=final
report_name=env-result
score_limit=80
data_file=data/scores.txt
EXPECTED

diff -u "${expected}" reports/env-result.txt || fail "unexpected reports/env-result.txt"
echo "PASS problem2"
