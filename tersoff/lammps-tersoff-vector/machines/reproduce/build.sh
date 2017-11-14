#!/bin/bash
set -o verbose

[[ -d lammps-10Mar16 ]] || cp -r ../lammps-10Mar16 .
cd lammps-10Mar16/
patch -p1 -N < ../../ccflags.patch
cd src

binaries=intel_cpu

# kokkos-cuda
make no-USER-INTEL
make no-USER-OMP
make yes-KOKKOS

cd ../lib/kokkos/config
ln -s nvcc_wrapper g++
cd ../../../src

if [[ ! -e lmp_kokkos_cuda_novect ]]; then
# make kokkos_cuda KOKKOS_ARCH=Pascal60 -j32
 make kokkos_cuda KOKKOS_ARCH=Maxwell53 CUDA_ARCH=-arch=sm_70 -j64
 mv lmp_kokkos_cuda lmp_kokkos_cuda_novect || exit
fi
#if [[ ! -e lmp_kokkos_omp_novect ]]; then
# make kokkos_omp -j32
# mv lmp_kokkos_omp lmp_kokkos_omp_novect || exit
#fi

cd ..
patch -p1 < ../../kokkosvect.patch || exit
cd src
cp ../../../kokkos_vector.h . || exit

if [[ ! -e lmp_kokkos_cuda_vect ]]; then
#  make kokkos_cuda KOKKOS_ARCH=Pascal60 -j32
  make kokkos_cuda KOKKOS_ARCH=Maxwell53 CUDA_ARCH=-arch=sm_70 -j64
  mv lmp_kokkos_cuda lmp_kokkos_cuda_vect || exit
fi
#if [[ ! -e lmp_kokkos_omp_vect ]]; then
#  make kokkos_omp -j32
#  mv lmp_kokkos_omp lmp_kokkos_omp_vect || exit
#fi

rm kokkos_vect.h

# gpu
make no-KOKKOS
make yes-GPU
function build_gpu() {
  cd ../lib/gpu
  echo '#!/bin/bash\nmpicxx "$@"' > mpic++
  chmod +x mpic++
  a=$PATH
  export PATH=.:$a
  make -f Makefile.linux clean
  make -f Makefile.linux CUDA_ARCH=-arch=sm_70 CUDA_HOME=$CUDA_ROOT CUDA_PRECISION=$1 -j32
  export PATH=$a
  cd ../../src
  make mpi -j32
  mv lmp_mpi lmp_mpi_gpu_$2 || exit
}
build_gpu "-D_SINGLE_SINGLE" single
build_gpu "-D_SINGLE_DOUBLE" mixed
build_gpu "-D_DOUBLE_DOUBLE" double
