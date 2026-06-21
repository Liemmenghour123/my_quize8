# 문제 6. GDB로 원인 찾기

아래 경로는 `4-7/` 디렉터리를 기준으로 한다.

문제 5에서 실패한 테스트 하나를 고른다.

GDB로 실패 원인을 관찰하고 실행 흔적을 파일로 남긴다.

필수 산출물은 아래와 같다.

```text
reports/gdb-session.txt
```

로그를 저장할 디렉터리를 만든 뒤 GDB를 실행한다.

`ScoreRequirements.CountIncludesScoresEqualToLimit` 부분은 본인이 작성한 실패 테스트 이름으로 바꾼다.

```sh
mkdir -p reports
gdb --args ./build-debug/tests/score_test --gtest_filter='ScoreRequirements.CountIncludesScoresEqualToLimit'
```

GDB가 시작되면 로그 기록을 켠다.

```gdb
set logging file reports/gdb-session.txt
set logging enabled on
```
이후 실패 원인을 확인하기 위한 명령을 실행한다.

디버깅을 마치기 전에 로그 기록을 끈다.

```gdb
set logging enabled off
quit
```

GDB 로그에는 실패 원인을 확인하기 위해 실행한 디버깅 흔적이 남아야 한다.

예를 들면 중단점, 실행, 다음 줄 실행, 변수 출력, 호출 스택 확인 중 일부가 들어갈 수 있다.

`No symbol table is loaded`가 나오면 Debug build가 아니거나 빌드가 오래된 것이다.

## Problem 6. Find the cause with GDB

The paths below are based on the `4-7/` directory.

Choose one failed test from Problem 5.

Use GDB to observe the cause of the failure and leave an execution trace in a file.

The required artifact is shown below.

```text
reports/gdb-session.txt
```

Create the directory for the log file, and then run GDB.

Replace `ScoreRequirements.CountIncludesScoresEqualToLimit` with the name of the failed test you wrote.

```sh
mkdir -p reports
gdb --args ./build-debug/tests/score_test --gtest_filter='ScoreRequirements.CountIncludesScoresEqualToLimit'
```

After GDB starts, turn on logging.

```gdb
set logging file reports/gdb-session.txt
set logging enabled on
```

Then run commands that help identify the cause of the failure.

Before finishing the debugging session, turn off logging.

```gdb
set logging enabled off
quit
```

The GDB log must contain debugging traces used to identify the cause of the failure.

For example, it may include some of the following: breakpoints, program execution, next-line execution, variable printing, or call stack inspection.

If `No symbol table is loaded` appears, the build is not a Debug build or the build is stale.
