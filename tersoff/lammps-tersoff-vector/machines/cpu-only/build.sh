#!/bin/bash

#script build.script
set -o verbose

#[[ -e lammps.tar.gz ]] || wget http://lammps.sandia.gov/tars/lammps.tar.gz
#[[ -d lammps-14Mar16 ]] || tar xzf lammps.tar.gz
[[ -d lammps-10Mar16 ]] || cp -r ../lammps-10Mar16 .
cd lammps-10Mar16/
patch -p1 -N < ../../ccflags.patch
cd src
make yes-USER-OMP
make yes-USER-INTEL
make no-KOKKOS
make no-GPU

binaries=intel_cpu

function build_binaries() {
  set -o verbose
  for f in $binaries; do
    touch pair_tersoff_intel.h
    [[ -e lmp_${f}_$2 ]] && continue
    make $f "$1" -j16
    mv lmp_$f lmp_${f}_$2 || exit
  done
}

build_binaries "CCFLAGS=-DLMP_INTEL_NOOP" "default_vector"
build_binaries "CCFLAGS=-DLMP_INTEL_TERSOFF_PACK_I=true" "packi_vector"
build_binaries "CCFLAGS=-DLMP_INTEL_TERSOFF_PACK_I=false" "nopacki_vector"

build_binaries "CCFLAGS=-LMP_INTEL_VECTOR_MIC=NONE -DLMP_INTEL_VECTOR_HOST=NONE" "default_scalar"
build_binaries "CCFLAGS=-DLMP_INTEL_TERSOFF_PACK_I=true -LMP_INTEL_VECTOR_MIC=NONE -DLMP_INTEL_VECTOR_HOST=NONE" "packi_scalar"
build_binaries "CCFLAGS=-DLMP_INTEL_TERSOFF_PACK_I=false -LMP_INTEL_VECTOR_MIC=NONE -DLMP_INTEL_VECTOR_HOST=NONE" "nopacki_scalar"

# kokkos-cuda
make no-USER-INTEL
make no-USER-OMP
make yes-KOKKOS

cd ../lib/kokkos/config
#ln -s nvcc_wrapper g++
cd ../../../src

if [[ ! -e lmp_kokkos_omp_novect ]]; then
 make kokkos_omp -j16
 mv lmp_kokkos_omp lmp_kokkos_omp_novect || exit
fi

cd ..
patch -p1 < ../../kokkosvect.patch || exit
cd src
cp ../../../kokkos_vector.h . || exit

if [[ ! -e lmp_kokkos_omp_vect ]]; then
  make kokkos_omp -j16
  mv lmp_kokkos_omp lmp_kokkos_omp_vect || exit
fi

