# ⚠ FIRST-BUILD WARNING:
# FetchContent will download and compile ~400 MB of whisper.cpp C++ source
# on the very first build.  Expect 15–30 min; subsequent incremental builds
# are fast.  Progress appears as "Building CXX object …" in Gradle output.

cmake_minimum_required(VERSION 3.22.1)
project(whisper_bridge LANGUAGES CXX C)
set(CMAKE_CXX_STANDARD 17)

include(FetchContent)
FetchContent_Declare(
  whisper_cpp
  GIT_REPOSITORY https://github.com/ggerganov/whisper.cpp
  GIT_TAG        v1.7.4
  GIT_SHALLOW    TRUE
)
set(WHISPER_BUILD_TESTS    OFF CACHE BOOL "" FORCE)
set(WHISPER_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GGML_METAL             OFF CACHE BOOL "" FORCE)
set(GGML_CUDA              OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS      OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(whisper_cpp)

add_library(whisper_bridge SHARED src/main/cpp/whisper_bridge.cpp)
target_link_libraries(whisper_bridge whisper)
target_include_directories(whisper_bridge PRIVATE ${whisper_cpp_SOURCE_DIR})
