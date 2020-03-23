# Standalone cmake project to build and install macOS build time dependencies.
include(ExternalProject)
cmake_policy(SET CMP0048 NEW)
cmake_minimum_required(VERSION 3.9)

project(ffmpeg-dev VERSION 0.0.1)

set(INSTALL_EXT_DIR "${PROJECT_BINARY_DIR}/install-ext" CACHE PATH "")
file(MAKE_DIRECTORY "${INSTALL_EXT_DIR}")

ExternalProject_Add(ffmpeg
    PREFIX ext
    STEP_TARGETS install
    GIT_REPOSITORY https://git.ffmpeg.org/ffmpeg.git
    GIT_TAG release/4.2
    GIT_PROGRESS ON
    UPDATE_COMMAND ""
    BUILD_IN_SOURCE ON
    CONFIGURE_COMMAND ./configure --prefix=${INSTALL_EXT_DIR} --enable-gpl --enable-nonfree --disable-programs --enable-shared
    BUILD_COMMAND make -j
    INSTALL_COMMAND make install
)

