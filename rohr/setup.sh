#!/bin/bash


HOMEDIR=/home/zmarcus/SC17/rohr


setup() {
  cd $HOMEDIR; \
  git clone https://github.com/davidrohr/hpl-gpu.git; \
  git clone https://github.com/davidrohr/caldgemm.git
  mkdir $HOMEDIR/lib
  mkdir $HOMEDIR/tmp
}

openmpi() {
  # Get OpenMPI
  cd $HOMEDIR; \
  wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz; \
  tar xf openmpi-3.0.0.tar.gz; \
  cd openmpi-3.0.0; \
  ./configure --enable-static --enable-shared --prefix=$HOMEDIR/openmpi-3.0.0/install; \
  make -j install
}

caldgemm() {
  source $HOMEDIR/caldgemm_setenv.sh
  cd $HOMEDIR; \
  cp config_options.mak ./caldgemm/config_options.mak; \
  cp caldgemm_config.h ./caldgemm/caldgemm_config.h; \
  cd caldgemm; \
  make -j
}

hpl-gpu() {
  cd $HOMEDIR/hpl-gpu; \
  ln -s ../caldgemm
  cd $HOMEDIR; \
  cp Make.Generic ./hpl-gpu/Make.Generic; \
  cp Make.Generic.Options ./hpl-gpu/Make.Generic.Options
  cd $HOMEDIR/hpl-gpu; \
  ./build.sh

}

run-it() {
  ./dgemm -g -/ 1,2

}


#setup
#openmpi
#caldgemm
#hpl-gpu




