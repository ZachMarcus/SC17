#!/bin/bash


HOMEDIR=/home/zmarcus/SC17/rohr


setup() {
  cd $HOMEDIR; \
  git clone https://github.com/davidrohr/hpl-gpu.git; \
  git clone https://github.com/davidrohr/caldgemm.git
  mkdir $HOMEDIR/lib
  mkdir $HOMEDIR/tmp

  # Get OpenMPI
  cd $HOMEDIR; \
  wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz; \
  tar xf openmpi-3.0.0.tar.gz; \
  cd openmpi-3.0.0; \
  ./configure --enable-static --enable-dynamic --prefix=$HOMEDIR/openmpi-3.0.0/install \
  make -j install


}


setup

