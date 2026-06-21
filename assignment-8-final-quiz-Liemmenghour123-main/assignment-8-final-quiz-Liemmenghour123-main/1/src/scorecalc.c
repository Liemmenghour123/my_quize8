#include "scorecalc.h"

#include <stdio.h>
#include <string.h>

int scorecalc_load_file(const char *path, ScoreCalcBook *book) {
    if (path == NULL || book == NULL) {
        return -1;
    }

    book->count = 0;

    FILE *fp = fopen(path, "r");
    if (fp == NULL) {
        return -2;
    }

    while (1) {
        char name[SCORECALC_NAME_LEN];
        int score = 0;
        int read_count = fscanf(fp, "%31s %d", name, &score);

        if (read_count == EOF) {
            break;
        }

        if (read_count != 2) {
            fclose(fp);
            return -3;
        }

        if (book->count >= SCORECALC_MAX_STUDENTS) {
            fclose(fp);
            return -4;
        }

        strncpy(book->students[book->count].name, name, SCORECALC_NAME_LEN - 1);
        book->students[book->count].name[SCORECALC_NAME_LEN - 1] = '\0';
        book->students[book->count].score = score;
        book->count++;
    }

    fclose(fp);
    return 0;
}

int scorecalc_sum_under_limit(const ScoreCalcBook *book, int limit) {
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

int scorecalc_count_under_limit(const ScoreCalcBook *book, int limit) {
    if (book == NULL) {
        return 0;
    }

    int selected = 0;

    for (int i = 0; i < book->count; i++) {
        if (book->students[i].score <= limit) {
            selected++;
        }
    }

    return selected;
}

double scorecalc_average_under_limit(const ScoreCalcBook *book, int limit) {
    int selected = scorecalc_count_under_limit(book, limit);

    if (selected == 0) {
        return 0.0;
    }

    return (double)scorecalc_sum_under_limit(book, limit) / selected;
}

