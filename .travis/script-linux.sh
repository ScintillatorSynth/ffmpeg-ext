#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    cd $TRAVIS_BUILD_DIR/build/ffmpeg
    make
    make install
    # The links are breaking when being extracted on windows, so remove them.
    find $TRAVIS_BUILD_DIR/build/install-ext -type l -exec rm {} \;
else
    make
fi
