# 문제 7. Branch에서 결함 수정

아래 경로는 `4-7/` 디렉터리를 기준으로 한다.

`4-7/`은 독립 Git 저장소이다.

저장소 루트에서 아래 명령으로 이동한 뒤 작업한다.

```sh
cd 4-7
```

`4-7` 저장소의 main에서 바로 고치지 않는다.

수정용 branch를 만든 뒤 그 branch에서 `src/score.c`를 수정한다.

수정 후 다시 빌드하고 테스트한다.

아래 명령으로 테스트가 통과하는지 확인한다.

```sh
ctest --test-dir build-debug --output-on-failure
```

직접 실행 결과도 확인한다.

```sh
./build-debug/score-analyzer data/scores.txt 80
./build-debug/score-analyzer data/scores-equal.txt 80
./build-debug/score-analyzer data/scores-no-match.txt 60
./build-debug/score-analyzer data/scores-empty.txt 80
```

수정 내용을 `4-7` 저장소의 branch에 커밋한다.

main과 branch 차이를 확인한다.

여기서 멈춘다.

`4-7` 저장소의 main에는 아직 merge하지 않는다.

branch에는 아래 파일이 있어야 한다.

```text
CMakeLists.txt
src/score.c
tests/test_score.cpp
reports/gdb-session.txt
```

아래 파일은 수정하지 않는다.

```text
include/score.h
src/main.c
tests/CMakeLists.txt
```

## Problem 7. Fix defects on a branch

The paths below are based on the `4-7/` directory.

`4-7/` is an independent Git repository.

From the repository root, move to the directory below before working.

```sh
cd 4-7
```

Do not fix the code directly on `main` in the `4-7` repository.

Create a branch for the fix, and modify `src/score.c` on that branch.

After the fix, build and test again.

Use the command below to confirm that the tests pass.

```sh
ctest --test-dir build-debug --output-on-failure
```

Also check the program output directly.

```sh
./build-debug/score-analyzer data/scores.txt 80
./build-debug/score-analyzer data/scores-equal.txt 80
./build-debug/score-analyzer data/scores-no-match.txt 60
./build-debug/score-analyzer data/scores-empty.txt 80
```

Commit the changes on the branch in the `4-7` repository.

Check the difference between `main` and the branch.

Stop there.

Do not merge the branch into `main` in the `4-7` repository yet.

The branch must contain the files below.

```text
CMakeLists.txt
src/score.c
tests/test_score.cpp
reports/gdb-session.txt
```

Do not modify the files below.

```text
include/score.h
src/main.c
tests/CMakeLists.txt
```
