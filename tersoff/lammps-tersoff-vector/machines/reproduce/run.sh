#!/bin/bash

cd ../../benchmarks/lammps; \
../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_vect -in in.tersoff_gpu -v p kokkos -sf kk on t 0 g 1; \
../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_novect -in in.tersoff_gpu -v p kokkos -sf kk on t 0 g 1; \
../../machines/reproduce/lammps-10Mar16/src/lmp_mpi_gpu_single -sf gpu -pk gpu 1 -in in.tersoff_2e6


