#include <gtest/gtest.h>

extern "C" {
#include "score.h"
}


TEST(Requirement, CountIncludesScoresEqualToLimit) {
    ScoreBook book;
    book.count = 4;
    book.students[0].score = 70;
    book.students[1].score = 80;
    book.students[2].score = 80;
    book.students[3].score = 90;

   
    EXPECT_EQ(score_count_under_limit(&book, 80), 3);
}


TEST(Requirement, AverageReturnsZeroWhenNoScoreMatches) {
    ScoreBook book;
    book.count = 3;
    book.students[0].score = 80;
    book.students[1].score = 90;
    book.students[2].score = 100;

    EXPECT_DOUBLE_EQ(score_average_under_limit(&book, 60), 0.0);
}

TEST(Requirement, LoadFileRejectsMissingFile) {
    ScoreBook book;
    EXPECT_NE(score_load_file("no_file.txt", &book), 0);
}


TEST(Requirement, NullBookReturnsNeutralValues) {
    EXPECT_EQ(score_count_under_limit(NULL, 50), 0);
    EXPECT_DOUBLE_EQ(score_average_under_limit(NULL, 50), 0.0);
    EXPECT_EQ(score_max(NULL), 0);
    EXPECT_EQ(score_min(NULL), 0);
}