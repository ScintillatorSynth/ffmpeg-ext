#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    mkdir -p $TRAVIS_BUILD_DIR/build/install-ext
    cd $TRAVIS_BUILD_DIR/build/ffmpeg-windows-build-helpers
    PATH=$HOME/.local/bin:$PATH ./cross_compile_ffmpeg.sh --build-ffmpeg-shared=y --compiler-flavors=win64             \
        --enable-gpl=y --sandbox-ok=y --ffmpeg-git-checkout-version=${FFMPEG_GIT_TAG}                                  \
        --ffmpeg-git-checkout=${FFMPEG_GIT_REPO} --debug  || exit 1                                                    \
    7z e sandbox/redist/ffmpeg-*-win64-shared.7z -o$TRAVIS_BUILD_DIR/build/install-ext
else
    make
fi
