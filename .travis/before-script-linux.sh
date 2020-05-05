#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    mkdir $TRAVIS_BUILD_DIR/build/install-ext

    # build zlib for libpng
    cd $TRAVIS_BUILD_DIR
    git clone https://github.com/madler/zlib zlib
    cd zlib
    git checkout v1.2.11
    # spot of wisdom from https://wiki.openttd.org/Cross-compiling_for_Windows#libpng. The main makefile seems broken
    # for the cross-compilation use case. Modify the win32 makefile to use the mingw setup.
    sed -e s/"PREFIX ="/"PREFIX = x86_64-w64-mingw32-"/ -i win32/Makefile.gcc
    BINARY_PATH=${TRAVIS_BUILD_DIR}/build/install-ext/bin INCLUDE_PATH=${TRAVIS_BUILD_DIR}/buildinstall-ext/include    \
        LIBRARY_PATH=${TRAVIS_BUILD_DIR}/build/install-ext/lib make -f win32/Makefile.gcc install

    # build libpng for png encodes
    cd $TRAVIS_BUILD_DIR
    git clone https://github.com/glennrp/libpng libpng
    cd libpng
    git checkout libpng16
    ./configure --prefix=$TRAVIS_BUILD_DIR/build/install-ext --host=x86_64-w64-mingw32 --enable-shared=no              \
        CPPFLAGS="-I${TRAVIS_BUILD_DIR}/build/install-ext/include" LDFLAGS="-L${TRAVIS_BUILD_DIR}/build/install-ext/lib"
    make
    make install

    # configure ffmpeg
    cd $TRAVIS_BUILD_DIR
    git clone $FFMPEG_GIT_REPO ffmpeg
    cd ffmpeg
    git checkout $FFMPEG_GIT_TAG
    ./configure --enable-gpl --arch=x86_64 --target-os=mingw32 --cross-prefix=x86_64-w64-mingw32-                      \
        --pkg-config=pkg-config --prefix=$TRAVIS_BUILD_DIR/build/install-ext --disable-programs --enable-shared        \
        --extra-cflags="-I${TRAVIS_BUILD_DIR}/build/install-ext/include"                                               \
        --extra-ldflags="-L${TRAVIS_BUILD_DIR}/build/install-ext/lib"
else
    cmake -DSCIN_FFMPEG_GIT_REPO=$FFMPEG_GIT_REPO -DSCIN_FFMPEG_GET_TAG=$FFMPEG_GIT_TAG ..
fi

