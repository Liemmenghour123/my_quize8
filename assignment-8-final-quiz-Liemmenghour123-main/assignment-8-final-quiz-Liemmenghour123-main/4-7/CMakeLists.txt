cmake_minimum_required(VERSION 3.16)

project(final_quiz_score
    VERSION 0.1
    LANGUAGES C CXX
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)


add_library(score STATIC src/score.c)

target_include_directories(score
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
)


add_executable(score-analyzer src/main.c)

target_link_libraries(score-analyzer
    PRIVATE score
)


include(FetchContent)

FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
)


set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(googletest)

enable_testing()


add_subdirectory(tests)


file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/data
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})