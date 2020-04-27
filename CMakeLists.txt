# Standalone cmake project to build and install ffmpeg dependencies for Scintillator
include(ExternalProject)
cmake_policy(SET CMP0048 NEW)
cmake_minimum_required(VERSION 3.9)

project(ffmpeg-dev VERSION 0.0.1)

set(INSTALL_EXT_DIR "${PROJECT_BINARY_DIR}/install-ext" CACHE PATH "")
file(MAKE_DIRECTORY "${INSTALL_EXT_DIR}")
set(SCIN_FFMPEG_GIT_TAG release/4.2)
set(SCIN_FFMPEG_GIT_REPO https://git.ffmpeg.org/ffmpeg.git)

if(SCIN_CROSS_WINDOWS)
    # We cross-compile for windows on Linux using the script provided by Roger Pack.
    ExternalProject_Add(build-helpers
        PREFIX ext
        STEP_TARGETS install
        GIT_REPOSITORY https://github.com/rdp/ffmpeg-windows-build-helpers
        GIT_TAG master
        GIT_PROGRESS ON
        UPDATE_COMMAND ""
        BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ./cross_compile_ffmpeg.sh --build-ffmpeg-shared=y --compiler-flavors=win64 --enable-gpl=y --sandbox-ok=y --ffmpeg-git-checkout-version=${SCIN_FFMPEG_GIT_TAG} --ffmpeg-git-checkout=${SCIN_FFMPEG_GIT_REPO}
        INSTALL_COMMAND 7z e sandbox/redist/ffmpeg-*-win64-shared.7z -o${INSTALL_EXT_DIR}
    )
else()
    if(APPLE)
        # TODO: Build parallelism is turned off right now because Travis inconsistently fails builds with too many child
        # processes spawned. So this build is serialized to be more stable. It also means that it is much slower than it needs
        # to be. Find a way to turn it back on.
        set(SCIN_FFMPEG_BUILD make)
    else()
        set(SCIN_FFMPEG_BUILD make -j)
    endif()

    ExternalProject_Add(ffmpeg
        PREFIX ext
        STEP_TARGETS install
        GIT_REPOSITORY ${SCIN_FFMPEG_GIT_REPO}
        GIT_TAG ${SCIN_FFMPEG_GIT_TAG}
        GIT_PROGRESS ON
        UPDATE_COMMAND ""
        BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ./configure --prefix=${INSTALL_EXT_DIR} --enable-gpl --disable-programs --enable-shared
        BUILD_COMMAND ${SCIN_FFMPEG_BUILD}
        INSTALL_COMMAND make install
    )
endif()
