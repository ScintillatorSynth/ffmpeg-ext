#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    mkdir -p $TRAVIS_BUILD_DIR/build/install-ext
    cd $TRAVIS_BUILD_DIR/build/ffmpeg-windows-build-helpers

    # We only print every 100th line of output as a keepalive, which is pretty
    # bad for usability of the log but helps the build survive log length
    # termination on Travis. If the build is failing ok to remove the awk
    # pipe part or uncomment the tail command to get the last part of the
    # build log.
    PATH=$HOME/.local/bin:$PATH ./cross_compile_ffmpeg.sh --build-ffmpeg-shared=y --compiler-flavors=win64             \
        --enable-gpl=y --sandbox-ok=y --ffmpeg-git-checkout-version=${FFMPEG_GIT_TAG} --gcc-cpu-count=2                \
        --ffmpeg-git-checkout=${FFMPEG_GIT_REPO} --debug 2>&1 | awk 'NS % 100 == 0'
    tail -n1000 sandbox/cross_compilers/build.log
    7z e sandbox/redist/ffmpeg-*-win64-shared.7z -o$TRAVIS_BUILD_DIR/build/install-ext
else
    make
fi
