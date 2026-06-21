#ifndef SCORECALC_H
#define SCORECALC_H

#define SCORECALC_MAX_STUDENTS 100
#define SCORECALC_NAME_LEN 32

typedef struct {
    char name[SCORECALC_NAME_LEN];
    int score;
} ScoreCalcStudent;

typedef struct {
    ScoreCalcStudent students[SCORECALC_MAX_STUDENTS];
    int count;
} ScoreCalcBook;

int scorecalc_load_file(const char *path, ScoreCalcBook *book);
int scorecalc_sum_under_limit(const ScoreCalcBook *book, int limit);
int scorecalc_count_under_limit(const ScoreCalcBook *book, int limit);
double scorecalc_average_under_limit(const ScoreCalcBook *book, int limit);

#endif

