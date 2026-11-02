execute_process(
  COMMAND "${KURA_EXECUTABLE}"
  OUTPUT_VARIABLE output
  RESULT_VARIABLE result
  OUTPUT_STRIP_TRAILING_WHITESPACE)

if(NOT result EQUAL 0)
  message(FATAL_ERROR "kura exited with code ${result}")
endif()

if(NOT output STREQUAL "Hello world.")
  message(FATAL_ERROR "Unexpected output: [${output}]")
endif()
