# 문제 1. 삭제된 동적 라이브러리 복구

이 디렉터리에는 문제 1을 풀기 위해 필요한 파일이 들어 있다.

`vendor/bin/score-report`는 동적 라이브러리를 사용해 빌드된 실행 파일이다.

시험 시작 상태에서는 `vendor/bin/score-report`는 있고, `vendor/lib/libscorecalc.so`는 삭제되어 실행되지 않는다.

아래 경로에 `include/scorecalc.h`와 `src/scorecalc.c`를 이용해 동적 라이브러리를 생성하라.

```text
1/vendor/lib/libscorecalc.so
```

복구한 뒤 저장소 루트에서 아래 명령으로 실행 결과를 남긴다.

```bash
mkdir -p reports
./1/vendor/bin/score-report 1/data/scores.txt 80 > reports/dynamic-library-check.txt
```

## Problem 1. Restore the missing dynamic library

This directory contains the files needed to solve Problem 1.

`vendor/bin/score-report` is an executable built with a dynamic library.

At the beginning of the exam, `vendor/bin/score-report` exists, but `vendor/lib/libscorecalc.so` has been removed, so the executable cannot run.

Using `include/scorecalc.h` and `src/scorecalc.c`, create the dynamic library at the path below.

```text
1/vendor/lib/libscorecalc.so
```

After restoring the library, run the command below from the repository root and save the execution result.

```bash
mkdir -p reports
./1/vendor/bin/score-report 1/data/scores.txt 80 > reports/dynamic-library-check.txt
```
