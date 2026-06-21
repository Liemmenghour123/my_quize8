#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/build-autograde"

check_file() {
    local path="$1"
    if [[ ! -f "${ROOT_DIR}/${path}" ]]; then
        echo "FAIL: missing ${path}"
        exit 1
    fi
}

check_project_files() {
    check_file "CMakeLists.txt"
    check_file "include/score.h"
    check_file "src/main.c"
    check_file "src/score.c"
    check_file "tests/test_score.cpp"
    check_file "data/scores.txt"
    check_file "data/scores-equal.txt"
    check_file "data/scores-no-match.txt"
    check_file "data/scores-empty.txt"
}

build_project() {
    cmake -S "${ROOT_DIR}" -B "${BUILD_DIR}"
    cmake --build "${BUILD_DIR}"
}

run_program_check() {
    local output
    output="$("${BUILD_DIR}/score-analyzer" "${ROOT_DIR}/data/scores.txt" 80)"

    grep -q "student count: 5" <<<"${output}"
    grep -q "matched count: 2" <<<"${output}"
    grep -q "sum of scores <= 80: 148" <<<"${output}"
    grep -q "average of scores <= 80: 74.00" <<<"${output}"
}

run_tests() {
    ctest --test-dir "${BUILD_DIR}" --output-on-failure
}

case "${1:-all}" in
    files)
        check_project_files
        ;;
    build)
        check_project_files
        build_project
        ;;
    run)
        check_project_files
        build_project
        run_program_check
        ;;
    test)
        check_project_files
        build_project
        run_tests
        ;;
    all)
        check_project_files
        build_project
        run_program_check
        run_tests
        echo "PASS: all checks passed"
        ;;
    *)
        echo "usage: $0 [files|build|run|test|all]"
        exit 2
        ;;
esac
