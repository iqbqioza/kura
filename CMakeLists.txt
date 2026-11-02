cmake_minimum_required(VERSION 3.21)

project(kura
  VERSION 0.1.0
  DESCRIPTION "Kura"
  LANGUAGES C)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  if(CMAKE_C_COMPILER_VERSION VERSION_LESS 15)
    message(FATAL_ERROR
      "GCC 15 or newer is required (found ${CMAKE_C_COMPILER_VERSION}).")
  endif()
elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
  if(CMAKE_C_COMPILER_VERSION VERSION_LESS 18)
    message(FATAL_ERROR
      "Clang 18 or newer is required (found ${CMAKE_C_COMPILER_VERSION}).")
  endif()
else()
  message(WARNING
    "kura is tested with GCC 15+ and Clang 18+; found "
    "${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}.")
endif()

option(KURA_WARNINGS_AS_ERRORS "Treat warnings as errors" OFF)
option(KURA_ENABLE_SANITIZERS
  "Enable AddressSanitizer and UndefinedBehaviorSanitizer" OFF)
option(KURA_ENABLE_CLANG_TIDY "Run clang-tidy while compiling" OFF)
option(KURA_ENABLE_CPPCHECK "Run cppcheck while compiling" OFF)

if(KURA_ENABLE_CLANG_TIDY)
  find_program(KURA_CLANG_TIDY_EXECUTABLE NAMES clang-tidy REQUIRED)
  set(CMAKE_C_CLANG_TIDY "${KURA_CLANG_TIDY_EXECUTABLE}")
endif()

if(KURA_ENABLE_CPPCHECK)
  find_program(KURA_CPPCHECK_EXECUTABLE NAMES cppcheck REQUIRED)
  set(CMAKE_C_CPPCHECK
    "${KURA_CPPCHECK_EXECUTABLE}"
    --enable=warning,style,performance,portability
    --inline-suppr
    --error-exitcode=1)
endif()

add_executable(kura src/main.c)

target_compile_options(kura PRIVATE -Wall -Wextra -Wpedantic)

if(KURA_WARNINGS_AS_ERRORS)
  target_compile_options(kura PRIVATE -Werror)
endif()

if(KURA_ENABLE_SANITIZERS)
  target_compile_options(kura PRIVATE
    -fsanitize=address,undefined
    -fno-omit-frame-pointer)
  target_link_options(kura PRIVATE -fsanitize=address,undefined)
endif()

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()

install(TARGETS kura RUNTIME DESTINATION bin)
