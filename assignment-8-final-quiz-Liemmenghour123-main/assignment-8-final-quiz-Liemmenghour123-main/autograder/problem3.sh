#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

fail() {
    echo "FAIL problem3: $*" >&2
    exit 1
}

target="3/work/feature-list.md"
[[ -f "${target}" ]] || fail "missing ${target}"

if grep -Eq '^(<<<<<<<|=======|>>>>>>>)' "${target}"; then
    fail "conflict marker remains in ${target}"
fi

expected="$(mktemp)"
cat > "${expected}" <<'EXPECTED'
# 기능 목록

1. 티셔츠 올리기
2. 티셔츠 구매하기
3. 상품 리뷰 남기기
4. 상품 검색하기
EXPECTED

diff -u "${expected}" "${target}" || fail "unexpected final feature-list.md"

if [[ -d "3/work/.git" ]]; then
    branch="$(git -C 3/work branch --show-current)"
    [[ "${branch}" == "main" ]] || fail "3/work final branch must be main"
    git -C 3/work log --oneline --graph --all --decorate | grep -Eq 'Merge|merge' \
        || fail "3/work merge commit not found"
else
    echo "WARN problem3: 3/work/.git is not available in GitHub Classroom; checked file content only"
fi

echo "PASS problem3"
