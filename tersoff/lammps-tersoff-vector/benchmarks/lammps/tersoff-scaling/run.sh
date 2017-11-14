#!/bin/bash




mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_novect -in in.tersoff_bench -log kokkos-novect-1-gpu.log -k on t 0 g 1 -sf kk

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_vect -in in.tersoff_bench -log kokkos-vect-1-gpu.log -k on t 0 g 1 -sf kk


mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_novect -in in.tersoff_bench -log kokkos-novect-2-gpu.log -k on t 0 g 2 -sf kk

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_vect -in in.tersoff_bench -log kokkos-vect-2-gpu.log -k on t 0 g 2 -sf kk











