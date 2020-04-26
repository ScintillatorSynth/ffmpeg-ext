#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    cmake -DSCIN_CROSS_WINDOWS=ON
else
    cmake ..
fi

