#!/bib/bash

#LDFLAGS=$(LDFLAGS)/ -L/path/t
#export LDFLAGS=$LDFLAGS:/home/zmarcus/SC17/HPL/openmpi-3.0.0/install/lib
LINPACK_HOME=/home/zmarcus/SC17/HPL

export PATH=$PATH:$LINPACK_HOME/openmpi-3.0.0/install/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LINPACK_HOME/openmpi-3.0.0/install/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LINPACK_HOME/blis/install/lib
export BLIS_NUM_THREADS=128

# for rocBLAS and clBLAS
export AMDAPPSDKROOT=/opt/rocm/opencl
export BUILD_SHARED_LIBS=1
export FC=/usr/bin/gfortran-5
export CXX=/opt/rocm/bin/hcc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LINPACK_HOME/rocBLAS/install/lib
