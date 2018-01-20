#!/bin/bash

if [ ! -d Tempura ]; then
  cd ..
fi

echo "[Tempura] Build and test script"
echo ""

if [ -e "/usr/local/bin/swiftenv" ]; then
  export PATH="/usr/local/bin:$PATH"
fi

eval "$(swiftenv init -)"

swiftenv version

swift package clean
swift package resolve
swift build
sbexit=$?

if [[ $sbexit != 0 ]]; then
  exit $sbexit
fi

if [ -d "Tests" ]; then
  swift test
fi
