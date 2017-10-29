#!/bin/bash

# directory paths
LAMMPS_DIR=mylammps
TERSOFF_DIR=mytersoff

source /opt/intel/parallel_studio_xe_2018/psxevars.sh; \


# setup for intel builds
intel_build() {
  export KMP_BLOCKTIME=0
  export CCFLAGS="${CCFLAGS} -restrict -qopenmp -DLMP_INTEL-USELRT -DLMP_USE_MKL_RNG -O2 -fno-alias -ansi-alias -qoverride-limits -fp-model -fast=2 -no-prec-dev -xHost -DLMP_INTEL_NO_TBB"
  export LDFLAGS="${LDFLAGS} -restrict -qopenmp"
  export OMP_NUM_THREADS=16
}


intel_build



