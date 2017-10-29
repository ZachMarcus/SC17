#!/bin/bash
git clone https://github.com/flame/blis.git

cd blis; \
./configure --enable-cblas -p /home/zmarcus/SC17/HPL/blis/install/ --enable-shared --enable-static haswell

cd blis; \
make -j

cd blis; \
make install
