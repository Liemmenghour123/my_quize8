#include "score.h"

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s <score-file> <limit>\n", argv[0]);
        return 1;
    }

    const char *score_path = argv[1];
    int limit = atoi(argv[2]);

    ScoreBook book = {0};
    int load_result = score_load_file(score_path, &book);

    if (load_result != 0) {
        fprintf(stderr, "failed to read score file: %s\n", score_path);
        return 1;
    }

    printf("limit: %d\n", limit);
    printf("student count: %d\n", book.count);
    printf("matched count: %d\n", score_count_under_limit(&book, limit));
    printf("sum of scores <= %d: %d\n", limit, score_sum_under_limit(&book, limit));
    printf("average of scores <= %d: %.2f\n", limit, score_average_under_limit(&book, limit));
    printf("max score: %d\n", score_max(&book));
    printf("min score: %d\n", score_min(&book));

    return 0;
}