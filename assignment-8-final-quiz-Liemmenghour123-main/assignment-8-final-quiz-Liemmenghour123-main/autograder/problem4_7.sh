#!/usr/bin/env bash
set -euo pipefail

CHECK="${1:-all}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_DIR="${ROOT_DIR}/4-7"
FIXTURE_BUGGY="${ROOT_DIR}/autograder/fixtures/score_buggy.c"
TMP_DIR="$(mktemp -d)"

trap 'rm -rf "${TMP_DIR}"' EXIT

fail() {
    echo "FAIL problem4-7: $*" >&2
    exit 1
}

require_file() {
    local path="$1"
    [[ -f "${PROJECT_DIR}/${path}" ]] || fail "missing ${path}"
}

require_base_files() {
    require_file "CMakeLists.txt"
    require_file "include/score.h"
    require_file "src/main.c"
    require_file "src/score.c"
    require_file "tests/CMakeLists.txt"
    require_file "tests/test_score.cpp"
}

configure_and_build() {
    local source_dir="$1"
    local build_dir="$2"

    cmake -S "${source_dir}" -B "${build_dir}" -DCMAKE_BUILD_TYPE=Debug
    cmake --build "${build_dir}"
}

check_cmake_project() {
    local build_dir="${TMP_DIR}/build-cmake"

    require_base_files
    configure_and_build "${PROJECT_DIR}" "${build_dir}"

    [[ -f "${build_dir}/libscore.a" ]] || fail "missing build artifact: libscore.a"
    [[ -x "${build_dir}/score-analyzer" ]] || fail "missing executable: score-analyzer"
    [[ -x "${build_dir}/tests/score_test" ]] || fail "missing executable: tests/score_test"

    echo "PASS problem4"
}

check_requirement_tests() {
    local buggy_dir="${TMP_DIR}/buggy-project"
    local build_dir="${TMP_DIR}/build-buggy"
    local buggy_ctest_status

    require_base_files
    [[ -f "${FIXTURE_BUGGY}" ]] || fail "missing autograder fixture: score_buggy.c"

    cp -a "${PROJECT_DIR}/." "${buggy_dir}/"
    cp "${FIXTURE_BUGGY}" "${buggy_dir}/src/score.c"
    configure_and_build "${buggy_dir}" "${build_dir}"

    set +e
    ctest --test-dir "${build_dir}" --output-on-failure
    buggy_ctest_status=$?
    set -e

    if [[ "${buggy_ctest_status}" -eq 0 ]]; then
        fail "student tests passed against the original defective score.c; tests must catch at least one defect"
    fi

    echo "PASS problem5"
}

check_gdb_session() {
    require_file "reports/gdb-session.txt"

    if ! grep -Eq 'break|Breakpoint|run|bt|backtrace|print|next|step|list' "${PROJECT_DIR}/reports/gdb-session.txt"; then
        fail "reports/gdb-session.txt does not contain enough GDB trace evidence"
    fi

    echo "PASS problem6"
}

check_output() {
    local build_dir="$1"
    local data_file="$2"
    local limit="$3"
    local expected_text="$4"
    local output

    output="$("${build_dir}/score-analyzer" "${PROJECT_DIR}/${data_file}" "${limit}")"
    if [[ "${output}" != "${expected_text}" ]]; then
        echo "Expected:" >&2
        printf '%s\n' "${expected_text}" >&2
        echo "Actual:" >&2
        printf '%s\n' "${output}" >&2
        fail "unexpected score-analyzer output for ${data_file} ${limit}"
    fi
}

check_fixed_behavior() {
    local build_dir="${TMP_DIR}/build-fixed"

    require_base_files
    configure_and_build "${PROJECT_DIR}" "${build_dir}"
    ctest --test-dir "${build_dir}" --output-on-failure

    check_output "${build_dir}" "data/scores.txt" "80" "$(cat <<'EXPECTED'
limit: 80
student count: 5
matched count: 2
sum of scores <= 80: 148
average of scores <= 80: 74.00
max score: 95
min score: 72
EXPECTED
)"

    check_output "${build_dir}" "data/scores-equal.txt" "80" "$(cat <<'EXPECTED'
limit: 80
student count: 4
matched count: 3
sum of scores <= 80: 210
average of scores <= 80: 70.00
max score: 90
min score: 60
EXPECTED
)"

    check_output "${build_dir}" "data/scores-no-match.txt" "60" "$(cat <<'EXPECTED'
limit: 60
student count: 3
matched count: 0
sum of scores <= 60: 0
average of scores <= 60: 0.00
max score: 95
min score: 81
EXPECTED
)"

    check_output "${build_dir}" "data/scores-empty.txt" "80" "$(cat <<'EXPECTED'
limit: 80
student count: 0
matched count: 0
sum of scores <= 80: 0
average of scores <= 80: 0.00
max score: 0
min score: 0
EXPECTED
)"

    echo "PASS problem7"
}

case "${CHECK}" in
    cmake)
        check_cmake_project
        ;;
    tests)
        check_requirement_tests
        ;;
    gdb)
        check_gdb_session
        ;;
    fix)
        check_fixed_behavior
        ;;
    all)
        check_cmake_project
        check_requirement_tests
        check_gdb_session
        check_fixed_behavior
        echo "PASS problem4-7"
        ;;
    *)
        echo "usage: $0 [cmake|tests|gdb|fix|all]" >&2
        exit 2
        ;;
esac
