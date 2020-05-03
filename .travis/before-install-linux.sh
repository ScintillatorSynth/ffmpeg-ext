#!/bin/sh

sudo apt-get update
sudo apt-get install --yes nasm

if [ $CROSS_WINDOWS = true ]; then
    sudo apt-get install --yes subversion ragel curl texinfo g++ bison flex cvs yasm automake libtool autoconf gcc     \
        cmake git make pkg-config zlib1g-dev mercurial unzip pax gperf autogen bzip2 autoconf-archive p7zip-full clang \
        python3-distutils python3-pip python3-setuptools
    pip3 install --user meson
fi

