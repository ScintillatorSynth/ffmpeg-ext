#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    cd $TRAVIS_BUILD_DIR/build/ffmpeg
    make
    make install
else
    make
fi
