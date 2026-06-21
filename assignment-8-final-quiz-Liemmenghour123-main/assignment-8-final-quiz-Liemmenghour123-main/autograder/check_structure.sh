#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
    echo "FAIL: $*" >&2
    exit 1
}

require_file() {
    local path="$1"
    [[ -f "${ROOT_DIR}/${path}" ]] || fail "missing file: ${path}"
}

require_dir() {
    local path="$1"
    [[ -d "${ROOT_DIR}/${path}" ]] || fail "missing directory: ${path}"
}

require_executable() {
    local path="$1"
    require_file "${path}"
    [[ -x "${ROOT_DIR}/${path}" ]] || fail "not executable: ${path}"
}

require_dir "1"
require_dir "2"
require_dir "3"
require_dir "4-7"
require_dir ".github/workflows"
require_dir ".github/classroom"
require_dir "autograder"

require_file "1/README.md"
require_file "1/vendor/bin/score-report"
require_file "1/include/scorecalc.h"
require_file "1/src/scorecalc.c"
require_file "1/src/score_report_main.c"
require_file "1/data/scores.txt"
require_file "2/README.md"
require_file "2/env-report"
require_file "data/scores.txt"
require_file "3/README.md"
require_file "3/starter/feature-list.md"
require_file "3/tools/prepare_merge_problem.sh"
require_file "4-7/CMakeLists.txt"
require_file "4-7/include/score.h"
require_file "4-7/src/score.c"
require_file "4-7/src/main.c"
require_file "4-7/sample/CMakeLists.txt"
require_file "4-7/sample/hello_test.cc"
require_file "4-7/tests/CMakeLists.txt"
require_file "4-7/tests/test_score.cpp"
require_file "4-7/data/scores.txt"
require_file "4-7/data/scores-equal.txt"
require_file "4-7/data/scores-no-match.txt"
require_file "4-7/data/scores-empty.txt"
require_file ".github/workflows/classroom.yml"
require_file ".github/classroom/autograding.json"

require_executable "autograder/check_structure.sh"
require_executable "autograder/run_all.sh"
require_executable "autograder/problem1.sh"
require_executable "autograder/problem2.sh"
require_executable "autograder/problem3.sh"
require_executable "autograder/problem4_7.sh"

if find "${ROOT_DIR}" -mindepth 2 -path '*/.git' -type d -print -quit | grep -q .; then
    fail "nested .git directory found"
fi

echo "PASS: template structure is valid"
