cmake_minimum_required(VERSION 3.21)

project(CMakeGit VERSION 1.2.0)

add_executable(CMakeGit main.cpp)

find_package(Git QUIET)

# # As per CMake documentation a custom target is always considered out of date
# # Using the ALL keyword ensures that the target is always built
# # https://cmake.org/cmake/help/v3.7/command/add_custom_target.html
# # https://cmake.org/pipermail/cmake/2012-December/053035.html
add_custom_target(version_target ALL
    COMMAND ${CMAKE_COMMAND} 
        -D GIT_EXECUTABLE=${GIT_EXECUTABLE}
        -D DST=${CMAKE_CURRENT_BINARY_DIR}/version.cpp
        -D SRC=${CMAKE_CURRENT_SOURCE_DIR}/version.cpp.in
        -P ${CMAKE_CURRENT_SOURCE_DIR}/FindVersion.cmake
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Generating version.cpp"
    VERBATIM
)
set(VERSION_CPP ${CMAKE_CURRENT_BINARY_DIR}/version.cpp)
set_source_files_properties(${VERSION_CPP} PROPERTIES GENERATED TRUE)

add_library(version_lib STATIC ${VERSION_CPP})
add_dependencies(version_lib version_target)
target_include_directories(version_lib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(CMakeGit PRIVATE version_lib)
