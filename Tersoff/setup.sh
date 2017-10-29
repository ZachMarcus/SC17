#!/bin/bash

# directory paths
LAMMPS_DIR=mylammps
TERSOFF_DIR=mytersoff

# Enable the packages MANYBODY, USER-OMP, and USER-INTEL
enable_packages() {
  cd $LAMMPS_DIR/src; \
    make yes-MANYBODY; \
    make yes-USER-OMP; \
    make yes-USER-INTEL; \
    make intel_cpu_intelmpi
}

# Copy files from tersoff to use
copy_files() {
  cp $TERSOFF_DIR/src/pair_tersoff_intel.h ./$LAMMPS_DIR/src/
  cp $TERSOFF_DIR/src/pair_tersoff_intel.cpp ./$LAMMPS_DIR/src/
  cp $TERSOFF_DIR/src/intel_intrinsics.h ./$LAMMPS_DIR/src/
}


copy_files

enable_packages



# Notes on building things:
#---------------------------------------------------------------
# USER-INTEL http://lammps.sandia.gov/doc/accelerate_intel.html
#src/MAKE/OPTIONS/Makefile.intel_cpu_intelmpi

# set environment variables
#   KMP_BLOCKTIME=0
#   CCFLAGS += -restrict -qopenmp -DLMP_INTEL-USELRT _DLMP_USE_MKL_RNG -O2 -fno-alias -ansi-alias -qoverride-limits fp-model fast=2 -no-prec-div -xHost
#   LINKFLAGS += -restrict -qopenmp
#   LIB should include -ltbbmalloc or if not than CCFLAGS += -DLMP_INTEL_NO_TBB
# OMP_NUM_THREADS := 2x number of cores


# add to LAMMPS command line:
#    -pk intel 0 omp 2 -sf intel

# add to input script
#    #newton off # option for simple 2-body potentials
#    processors *** grid numa # added to beginning of script
#    #kspace_modify diff ad # only if using kspace_style pppm

# NOTE
# vectorization directives are disabled by support
# 1 MPI task per physical core, maybe more threads
# Intel build:
#   make yes-user-intel
#   source /opt/intel/parallel_studio_xe_2016.3.067/psxevars.sh
#   make intel_cpu_intelmpi
# check for LRT later, that's a potentially good gain
#-----------------------------------------------------------------
# GPU NOTES: http://lammps.sandia.gov/doc/accelerate_gpu.html
# lol probably not
#-----------------------------------------------------------------
# KOKKOS NOTES (don't use though) http://lammps.sandia.gov/doc/accelerate_kokkos.html
# building: (with C++11 required)
# make yes-kokkos
# make mpi KOKKOS_DEVICES=OpenMP
# make kokkos_omp
#------------------------------------------------------------
# USER-OMP notes http://lammps.sandia.gov/doc/accelerate_omp.html
# CCFLAGS and LINKFLAGS in Makefile.machine must have -fopenmp
# make yes-user-omp
# make mpi # build with USER-OMP package, if settings added to Makefile.mpi
# make omp # or Makefile.omp already has settings
#---------------------------------------------------------------


# RUNNING

# for USER-INTEL:
# mpirun -np total_cores -ppn cores_per_node lmp_machine -sf intel -in in.script -pk intel 0 omp 2 -sf intel mode mixed

# for KOKKOS:
# mpirun -np total_cores -ppn cores_per_node lmp_mpi -k on t 2 -sf kk -in in.script.lj

# for USER-OMP:
# mpirun -np total_cores -ppn cores_per_node lmp_mpi -sf omp -pk omp 2 -in in.script






