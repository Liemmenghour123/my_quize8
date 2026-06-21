#ifndef SCORE_H
#define SCORE_H

#define MAX_STUDENTS 100
#define NAME_LEN 32

typedef struct {
    char name[NAME_LEN];
    int score;
} Student;

typedef struct {
    Student students[MAX_STUDENTS];
    int count;
} ScoreBook;

int score_load_file(const char *path, ScoreBook *book);
int score_sum_under_limit(const ScoreBook *book, int limit);
int score_count_under_limit(const ScoreBook *book, int limit);
double score_average_under_limit(const ScoreBook *book, int limit);
int score_max(const ScoreBook *book);
int score_min(const ScoreBook *book);

#endif