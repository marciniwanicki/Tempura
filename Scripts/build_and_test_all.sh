#!/bin/bash

set -e

if [ ! -d Sources ]; then
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
  swift package generate-xcodeproj
  xcodebuild -scheme Tempura-iOS -enableCodeCoverage YES test
fi
