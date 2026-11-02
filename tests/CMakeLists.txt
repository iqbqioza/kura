add_test(
  NAME kura.hello
  COMMAND ${CMAKE_COMMAND}
    -DKURA_EXECUTABLE=$<TARGET_FILE:kura>
    -P ${CMAKE_CURRENT_SOURCE_DIR}/hello.cmake)
