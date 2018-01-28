#!/bin/bash

if [ ! -d Sources ]; then
  cd ..
fi

bash <(curl -s https://codecov.io/bash)
