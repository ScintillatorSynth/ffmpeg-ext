#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    PATH=~/.local/bin:$PATH cmake -DSCIN_CROSS_WINDOWS=ON ..
else
    cmake ..
fi

