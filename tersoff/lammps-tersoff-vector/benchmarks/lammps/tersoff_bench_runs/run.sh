#!/bin/bash



run_it() {

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_novect -in in.tersoff_bench -log tersoff_bench-kokkos_novect-$1.log -k on t 0 g 1 -sf kk

mpirun -np 1 ../../machines/reproduce/lammps-10Mar16/src/lmp_kokkos_cuda_vect -in in.tersoff_bench -log tersoff_bench-kokkos_vect-$1.log -k on t 0 g 1 -sf kk

}


#run_it "1"
run_it "2"
run_it "3"
run_it "4"
run_it "5"











