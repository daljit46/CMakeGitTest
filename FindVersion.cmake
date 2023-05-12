if(GIT_EXECUTABLE)
    message(STATUS "Git found: ${GIT_EXECUTABLE}")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --abbrev=0
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_TAG
        RESULT_VARIABLE GIT_TAG_ERROR
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if(NOT GIT_TAG_ERROR)
        message(STATUS "Git tag: ${GIT_TAG}")
        set(MRTRIX_VERSION ${GIT_TAG})
    else()
        message(STATUS "Git tag: not found")
    endif()
endif()
if(NOT MRTRIX_VERSION)
    set(MRTRIX_VERSION "1.0.0")
    message(STATUS "Failed to determine version from Git, using default: ${MRTRIX_VERSION}")
endif()


configure_file(
    ${SRC}
    ${DST}
    @ONLY
)