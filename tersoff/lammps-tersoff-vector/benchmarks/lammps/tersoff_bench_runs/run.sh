#!/bin/bash


run_it() {

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_novect -in in.tersoff_bench -log tersoff_bench-kokkos_novect-$1.log -k on t 0 g 1 -sf kk

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_vect -in in.tersoff_bench -log tersoff_bench-kokkos_vect-$1.log -k on t 0 g 1 -sf kk

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_mpi_gpu_single -sf gpu -pk gpu 1 -in in.tersoff_bench_gpu -log tersoff_bench-gpu_single-$1.log

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_mpi_gpu_mixed -sf gpu -pk gpu 1 -in in.tersoff_bench_gpu -log tersoff_bench-gpu-mixed-$1.log

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_mpi_gpu_double -sf gpu -pk gpu 1 -in in.tersoff_bench_gpu -log tersoff_bench-gpu-double-$1.log

}

run_it "1"
run_it "2"
run_it "3"
run_it "4"
run_it "5"











