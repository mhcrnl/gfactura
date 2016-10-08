#!/usr/bin/env bash

if [ ! -d build ]; then
  mkdir build
fi

cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../
make
sudo make install
cd ..

