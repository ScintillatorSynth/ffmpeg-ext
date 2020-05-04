#!/bin/sh

sudo apt-get update
sudo apt-get install --yes nasm

if [ $CROSS_WINDOWS = true ]; then
    sudo apt-get install --yes g++-mingw-w64-x86-64 gcc-mingw-w64-x86-64 libtool pkg-config autoconf automake yasm
fi

