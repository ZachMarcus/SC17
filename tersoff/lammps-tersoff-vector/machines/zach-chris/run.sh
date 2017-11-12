#!/bin/bash

cd ../../benchmarks/lammps; \
../../machines/zach-chris/lammps-10Mar16/src/lmp_kokkos_cuda_vect -in in.tersoff_gpu -v p kokkos -sf kk on t 0 g 1; \
../../machines/zach-chris/lammps-10Mar16/src/lmp_kokkos_cuda_novect -in in.tersoff_gpu -v p kokkos -sf kk on t 0 g 1



