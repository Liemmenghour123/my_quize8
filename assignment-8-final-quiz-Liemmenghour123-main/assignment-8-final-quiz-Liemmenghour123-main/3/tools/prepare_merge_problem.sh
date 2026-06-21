#!/usr/bin/env bash
set -euo pipefail

PROBLEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="${PROBLEM_DIR}/work"

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"
cp "${PROBLEM_DIR}/starter/feature-list.md" "${WORK_DIR}/feature-list.md"

git -C "$WORK_DIR" init >/dev/null
git -C "$WORK_DIR" checkout -B main >/dev/null
git -C "$WORK_DIR" config user.email final@example.invalid
git -C "$WORK_DIR" config user.name "Final Quiz"
git -C "$WORK_DIR" add feature-list.md
git -C "$WORK_DIR" commit -m "Initial feature list" >/dev/null

printf 'prepared %s\n' "$WORK_DIR"
