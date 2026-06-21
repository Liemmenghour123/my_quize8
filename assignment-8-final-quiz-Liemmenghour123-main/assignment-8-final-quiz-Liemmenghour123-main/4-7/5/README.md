# 문제 5. 요구사항 확인 테스트 작성

아래 경로는 `4-7/` 디렉터리를 기준으로 한다.

`src/score.c`에는 결함이 미리 들어 있다.

처음부터 코드를 고치지 않는다.

`tests/test_score.cpp`에 GoogleTest 테스트를 작성한다.

작성한 테스트는 아래 요구사항을 모두 확인해야 한다.

## 파일 읽기

`score_load_file(path, book)`은 점수 파일을 읽어 `ScoreBook`에 저장한다.

- `path` 또는 `book`이 `NULL`이면 `-1`을 반환한다.
- 파일을 열 수 없으면 0이 아닌 값을 반환한다.
- 정상 파일을 읽으면 `0`을 반환한다.
- 정상 파일을 읽은 뒤 `book->count`는 학생 수와 같아야 한다.
- 각 줄은 `이름 점수` 형식이다.

## 기준 점수 이하 합계

`score_sum_under_limit(book, limit)`은 `limit` 이하 점수의 합계를 반환한다.

- `book`이 `NULL`이면 `0`을 반환한다.
- `limit`과 같은 점수도 포함한다.

## 기준 점수 이하 개수

`score_count_under_limit(book, limit)`은 `limit` 이하 점수의 개수를 반환한다.

- `book`이 `NULL`이면 `0`을 반환한다.
- `limit`과 같은 점수도 포함한다.

## 기준 점수 이하 평균

`score_average_under_limit(book, limit)`은 `limit` 이하 점수의 평균을 반환한다.

- `book`이 `NULL`이면 `0.0`을 반환한다.
- 조건에 맞는 점수가 없으면 `0.0`을 반환한다.
- 평균은 `double`로 계산한다.

## 최댓값과 최솟값

`score_max(book)`은 가장 높은 점수를 반환한다.

`score_min(book)`은 가장 낮은 점수를 반환한다.

- `book`이 `NULL`이면 `0`을 반환한다.
- 학생 수가 0명이면 `0`을 반환한다.

테스트는 요구사항별 결함을 잡을 수 있어야 한다.

제공 코드의 결함 때문에 실패하는 테스트가 있어야 한다.

테스트 방향 예시는 아래와 같다.

```text
파일이 없을 때 실패 코드가 반환되는가
limit과 같은 점수가 count에 포함되는가
조건에 맞는 점수가 없을 때 평균이 0.0인가
빈 파일에서 max/min이 0인가
```

## 정답 테스트 실행 결과

테스트 실행 결과는 아래와 같다.

```text
CTEST_EXIT=8
33% tests passed, 4 tests failed out of 6

The following tests FAILED:
  1 - HiddenRequirements.LoadFileRejectsMissingFile (SEGFAULT)
  3 - HiddenRequirements.CountIncludesScoresEqualToLimit (Failed)
  4 - HiddenRequirements.AverageReturnsZeroWhenNoScoreMatches (Failed)
  6 - HiddenRequirements.NullBookReturnsNeutralValues (SEGFAULT)

HiddenRequirements.CountIncludesScoresEqualToLimit:
Expected equality of these values:
  3
  score_count_under_limit(&book, 80)
    Which is: 2

HiddenRequirements.AverageReturnsZeroWhenNoScoreMatches:
Expected equality of these values:
  0.0
    Which is: 0
  score_average_under_limit(&book, 60)
    Which is: -nan
```

## Problem 5. Write requirement verification tests

The paths below are based on the `4-7/` directory.

`src/score.c` contains defects in the starter code.

Do not fix the code first.

Write GoogleTest tests in `tests/test_score.cpp`.

The tests you write must verify all requirements below.

## File loading

`score_load_file(path, book)` reads a score file and stores it in `ScoreBook`.

- If `path` or `book` is `NULL`, it returns `-1`.
- If the file cannot be opened, it returns a nonzero value.
- If a valid file is read, it returns `0`.
- After reading a valid file, `book->count` must match the number of students.
- Each line uses the `name score` format.

## Sum of scores less than or equal to the limit

`score_sum_under_limit(book, limit)` returns the sum of scores less than or equal to `limit`.

- If `book` is `NULL`, it returns `0`.
- Scores equal to `limit` are included.

## Count of scores less than or equal to the limit

`score_count_under_limit(book, limit)` returns the number of scores less than or equal to `limit`.

- If `book` is `NULL`, it returns `0`.
- Scores equal to `limit` are included.

## Average of scores less than or equal to the limit

`score_average_under_limit(book, limit)` returns the average of scores less than or equal to `limit`.

- If `book` is `NULL`, it returns `0.0`.
- If no score matches the condition, it returns `0.0`.
- The average is calculated as a `double`.

## Maximum and minimum

`score_max(book)` returns the highest score.

`score_min(book)` returns the lowest score.

- If `book` is `NULL`, it returns `0`.
- If the number of students is 0, it returns `0`.

The tests must catch requirement-level defects.

At least one test must fail because of defects in the provided code.

Example test directions are shown below.

```text
Does a missing file return a failure code?
Is a score equal to limit included in count?
Is the average 0.0 when no score matches?
Are max and min 0 for an empty file?
```

## Answer Test Execution Result

The test execution result is shown below.

```text
CTEST_EXIT=8
33% tests passed, 4 tests failed out of 6

The following tests FAILED:
  1 - HiddenRequirements.LoadFileRejectsMissingFile (SEGFAULT)
  3 - HiddenRequirements.CountIncludesScoresEqualToLimit (Failed)
  4 - HiddenRequirements.AverageReturnsZeroWhenNoScoreMatches (Failed)
  6 - HiddenRequirements.NullBookReturnsNeutralValues (SEGFAULT)

HiddenRequirements.CountIncludesScoresEqualToLimit:
Expected equality of these values:
  3
  score_count_under_limit(&book, 80)
    Which is: 2

HiddenRequirements.AverageReturnsZeroWhenNoScoreMatches:
Expected equality of these values:
  0.0
    Which is: 0
  score_average_under_limit(&book, 60)
    Which is: -nan
```
