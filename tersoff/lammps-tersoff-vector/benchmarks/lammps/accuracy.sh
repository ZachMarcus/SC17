#!/bin/bash


mpirun -np 8 -host "$HOSTNAME" ../../machines/cpu-only/lammps-10Mar16/src/lmp_intel_cpu_default_vector -in in.tersoff-acc -pk intel 0 mode $1 -sf intel -v p vanilla | tee acc-$1
