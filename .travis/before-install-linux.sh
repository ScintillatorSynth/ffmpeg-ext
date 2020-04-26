#!/bin/sh

sudo apt-get update
sudo apt-get install --yes nasm

if [ $CROSS_WINDOWS = true ]; then
    sudo add-apt-repository --yes ppa:nbritton/meson-0.47
    sudo apt-get update
    sudo apt-get install subversion ragel curl texinfo g++ bison flex cvs yasm automake libtool autoconf gcc cmake git \
        make pkg-config zlib1g-dev mercurial unzip pax nasm gperf autogen bzip2 autoconf-archive p7zip-full meson      \
        clang python3-distutils -y
fi

