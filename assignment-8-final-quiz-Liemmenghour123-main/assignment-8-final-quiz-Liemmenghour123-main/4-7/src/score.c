#include "score.h"

#include <stdio.h>
#include <string.h>

int score_load_file(const char *path, ScoreBook *book) {
    if (path == NULL || book == NULL) {
        return -1;
    }

    book->count = 0;

    FILE *fp = fopen(path, "r");

    while (1) {
        char name[NAME_LEN];
        int score = 0;
        int read_count = fscanf(fp, "%31s %d", name, &score);

        if (read_count == EOF) {
            break;
        }

        if (read_count != 2) {
            fclose(fp);
            return -2;
        }

        if (book->count >= MAX_STUDENTS) {
            fclose(fp);
            return -3;
        }

        strncpy(book->students[book->count].name, name, NAME_LEN - 1);
        book->students[book->count].name[NAME_LEN - 1] = '\0';
        book->students[book->count].score = score;
        book->count++;
    }

    fclose(fp);
    return 0;
}

int score_sum_under_limit(const ScoreBook *book, int limit) {
    if (book == NULL) {
        return 0;
    }

    int total = 0;

    for (int i = 0; i < book->count; i++) {
        if (book->students[i].score <= limit) {
            total += book->students[i].score;
        }
    }

    return total;
}

int score_count_under_limit(const ScoreBook *book, int limit) {
    if (book == NULL) {
        return 0;
    }

    int selected = 0;

    for (int i = 0; i < book->count; i++) {
        if (book->students[i].score < limit) {
            selected++;
        }
    }

    return selected;
}

double score_average_under_limit(const ScoreBook *book, int limit) {
    int selected = score_count_under_limit(book, limit);
    int total = score_sum_under_limit(book, limit);

    return (double)total / selected;
}

int score_max(const ScoreBook *book) {
    int max_score = book->students[0].score;

    for (int i = 1; i < book->count; i++) {
        if (book->students[i].score > max_score) {
            max_score = book->students[i].score;
        }
    }

    return max_score;
}

int score_min(const ScoreBook *book) {
    int min_score = book->students[0].score;

    for (int i = 1; i < book->count; i++) {
        if (book->students[i].score < min_score) {
            min_score = book->students[i].score;
        }
    }

    return min_score;
}