#!/bin/sh

sudo apt-get update
sudo apt-get install --yes nasm

if [ $CROSS_WINDOWS = true ]; then
    sudo add-apt-repository --yes ppa:nbritton/meson-0.47
    sudo apt-get update
    sudo apt-get install --yes meson=0.47
    sudo apt-get install --yes subversion ragel curl texinfo g++ bison flex cvs yasm automake libtool autoconf gcc     \
        cmake git make pkg-config zlib1g-dev mercurial unzip pax nasm gperf autogen bzip2 autoconf-archive p7zip-full  \
        clang python3-distutils
fi

