#!/bin/bash


run_it() {

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_novect -in in.tersoff-acc -log tersoff-acc-kokkos_novect.log -k on t 0 g 1 -sf kk

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_vect -in in.tersoff-acc -log tersoff-acc-kokkos_vect.log -k on t 0 g 1 -sf kk

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_mpi_gpu_single -sf gpu -pk gpu 1 -in in.tersoff-acc-gpu -log tersoff-acc-gpu_single.log

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_mpi_gpu_mixed -sf gpu -pk gpu 1 -in in.tersoff-acc-gpu -log tersoff-acc-gpu-mixed.log

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_mpi_gpu_double -sf gpu -pk gpu 1 -in in.tersoff-acc-gpu -log tersoff-acc-gpu-double.log

}

run_it











