#!/bin/sh

if [ $CROSS_WINDOWS = true ]; then
    git clone https://github.com/rdp/ffmpeg-windows-build-helpers
else
    cmake -DSCIN_FFMPEG_GIT_REPO=$FFMPEG_GIT_REPO -DSCIN_FFMPEG_GET_TAG=$FFMPEG_GIT_TAG ..
fi

