add_executable(score_test
    test_score.cpp
)

target_link_libraries(score_test PRIVATE
    score
    GTest::gtest_main
)

target_compile_options(score_test PRIVATE
    -Wall
    -Wextra
)

include(GoogleTest)

gtest_discover_tests(score_test
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)