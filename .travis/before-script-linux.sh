#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    git clone $FFMPEG_GIT_REPO ffmpeg
    cd ffmpeg
    git checkout $FFMPEG_GIT_TAG
    mkdir -p $TRAVIS_BUILD_DIR/build/install-ext
    ./configure --enable-gpl --arch=x86_64 --target-os=mingw32 --cross-prefix=x86_64-w64-mingw32-                      \
        --pkg-config=pkg-config --prefix=$TRAVIS_BUILD_DIR/build/install-ext --disable-programs --enable-shared        \
        --enable-encoder=png
else
    cmake -DSCIN_FFMPEG_GIT_REPO=$FFMPEG_GIT_REPO -DSCIN_FFMPEG_GET_TAG=$FFMPEG_GIT_TAG ..
fi

