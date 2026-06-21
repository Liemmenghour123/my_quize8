# 문제 4. CMakeLists.txt 작성과 테스트 준비

아래 경로는 `4-7/` 디렉터리를 기준으로 한다.

`src/`, `include/`, `tests/`, `data/`는 제공되어 있다.

문제 4~7은 같은 프로젝트를 사용한다.

`4-7/`은 독립 Git 저장소이다.

문제 4에서 만든 CMake 설정으로 문제 5의 GoogleTest, 문제 6의 GDB, 문제 7의 결함 수정을 계속 진행한다.

학생은 프로젝트 루트에 제공된 `CMakeLists.txt` 뼈대를 완성한다.

```text
CMakeLists.txt
```

작성한 CMake 설정은 아래 대상을 빌드해야 한다.

- `score`: `src/score.c`로 만드는 정적 라이브러리
- `score-analyzer`: `src/main.c`로 만드는 실행 파일
- `score_test`: `tests/test_score.cpp`로 만드는 GoogleTest 실행 파일

`score`는 `include/`의 헤더를 사용할 수 있어야 한다.

`score-analyzer`와 `score_test`는 `score`를 링크해야 한다.

테스트는 `ctest`로 실행할 수 있어야 한다.

빌드 디렉터리에는 `data/` 디렉터리가 복사되어야 한다.

필수 산출물은 아래와 같다.

```text
CMakeLists.txt 완성본
build-debug/score-analyzer
build-debug/tests/score_test
```

## Problem 4. Complete CMakeLists.txt and prepare tests

The paths below are based on the `4-7/` directory.

The `src/`, `include/`, `tests/`, and `data/` directories are provided.

Problems 4 through 7 use the same project.

`4-7/` is an independent Git repository.

The CMake configuration completed in Problem 4 will also be used for the GoogleTest work in Problem 5, the GDB work in Problem 6, and the defect fix in Problem 7.

Complete the provided `CMakeLists.txt` skeleton at the project root.

```text
CMakeLists.txt
```

The completed CMake configuration must build the targets below.

- `score`: a static library built from `src/score.c`
- `score-analyzer`: an executable built from `src/main.c`
- `score_test`: a GoogleTest executable built from `tests/test_score.cpp`

`score` must be able to use the headers in `include/`.

`score-analyzer` and `score_test` must link against `score`.

The tests must be runnable with `ctest`.

The `data/` directory must be copied into the build directory.

The required artifacts are shown below.

```text
Completed CMakeLists.txt
build-debug/score-analyzer
build-debug/tests/score_test
```
