#!/bin/bash

if [ ! -d Tempura ]; then
  cd ..
fi

echo "[Tempura] Build and test iOS framework"
echo ""

xcodebuild -workspace Tempura.xcworkspace -scheme Tempura-iOS -sdk iphonesimulator build test -destination "platform=iOS Simulator,name=iPhone SE" | xcpretty -c
