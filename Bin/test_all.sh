#!/bin/bash

if [ ! -d Tempura ]; then
cd ..
fi

swift package clean
swift package resolve
swift test
