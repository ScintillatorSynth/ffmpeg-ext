#!/bin/sh

echo "** starting script-osx.sh"
cmake --build . --config Release
cmake --install . --config Release

