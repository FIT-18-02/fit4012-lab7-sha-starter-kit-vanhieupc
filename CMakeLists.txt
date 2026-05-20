cmake_minimum_required(VERSION 3.16)

project(
    fit4012_lab7_sha
    VERSION 1.0
    DESCRIPTION "FIT4012 SHA-256 Lab"
    LANGUAGES CXX
)

# =========================
# C++ STANDARD
# =========================
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# =========================
# COMPILER WARNINGS
# =========================
if(MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(
        -Wall
        -Wextra
        -pedantic
        -O2
    )
endif()

# =========================
# SHA256 MAIN PROGRAM
# =========================
add_executable(
    sha256
    sha_procedure.cpp
)

# =========================
# FILE INTEGRITY
# =========================vh
add_executable(
    file_integrity
    file_integrity.cpp
)

# =========================
# PASSWORD HASH
# =========================
add_executable(
    password_hash
    password_hash.cpp
)

# =========================vh
# SALTED PASSWORD HASH
# =========================
add_executable(
    salted_password_hash
    salted_password_hash.cpp
)

# =========================
# INCLUDE CURRENT DIRECTORY
# =========================
target_include_directories(
    sha256 PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

target_include_directories(
    file_integrity PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

target_include_directories(
    password_hash PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

target_include_directories(
    salted_password_hash PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)
