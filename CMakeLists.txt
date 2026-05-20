cmake_minimum_required(VERSION 3.16)
project(fit4012_lab7_sha LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(sha256 sha_procedure.cpp)
add_executable(file_integrity file_integrity.cpp)
add_executable(password_hash password_hash.cpp)
add_executable(salted_password_hash salted_password_hash.cpp)
