# 문제 3. Git merge와 conflict 해결

## 시작 파일

`3/work/feature-list.md`의 시작 내용은 아래와 같다.

```markdown
# 기능 목록

1. 티셔츠 올리기
2. 티셔츠 구매하기
```

## 요구사항

`main`에서 `feature/search` branch를 만든다.

`feature/search` branch에서는 `feature-list.md` 마지막에 아래 기능을 추가하고 commit한다.

```markdown
3. 상품 검색하기
```

다시 `main`으로 돌아온 뒤 `feature/review` branch를 만든다.

`feature/review` branch에서는 `feature-list.md` 마지막에 아래 기능을 추가하고 commit한다.

```markdown
3. 상품 리뷰 남기기
```

`feature/search` 변경을 `main`에 먼저 merge한다.

그 다음 `feature/review` branch에서 최신 `main`을 merge한다.

이때 같은 위치에 서로 다른 3번 항목이 추가되어 conflict가 발생해야 한다.

conflict marker를 제거하고 최종 내용을 직접 결정한다.

최종 `main` branch의 `feature-list.md`는 아래 내용과 같아야 한다.

```markdown
# 기능 목록

1. 티셔츠 올리기
2. 티셔츠 구매하기
3. 상품 리뷰 남기기
4. 상품 검색하기
```

## 최종 확인

최종 branch는 `main`이어야 한다.

`feature-list.md`에 conflict marker가 남아 있으면 안 된다.

`git log --oneline --graph --all --decorate`에서 conflict 해결 merge commit을 확인할 수 있어야 한다.

## Problem 3. Resolve a Git merge conflict

## Starting file

The initial contents of `3/work/feature-list.md` are shown below.

```markdown
# 기능 목록

1. 티셔츠 올리기
2. 티셔츠 구매하기
```

## Requirements

Create a `feature/search` branch from `main`.

On the `feature/search` branch, add the feature below to the end of `feature-list.md` and commit the change.

```markdown
3. 상품 검색하기
```

Return to `main`, and then create a `feature/review` branch.

On the `feature/review` branch, add the feature below to the end of `feature-list.md` and commit the change.

```markdown
3. 상품 리뷰 남기기
```

Merge the `feature/search` change into `main` first.

Then merge the latest `main` into the `feature/review` branch.

A conflict should occur because both branches added a different item at the same location.

Remove the conflict markers and decide the final file contents.

The final `feature-list.md` on the `main` branch must match the content below.

```markdown
# 기능 목록

1. 티셔츠 올리기
2. 티셔츠 구매하기
3. 상품 리뷰 남기기
4. 상품 검색하기
```

## Final check

The final branch must be `main`.

No conflict markers may remain in `feature-list.md`.

The conflict-resolution merge commit must be visible in `git log --oneline --graph --all --decorate`.
