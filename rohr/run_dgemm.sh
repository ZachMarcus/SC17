#!/bin/bash

# -z to enable multithreading, -z and -Z for multi GPU when GPU_C = 0
# -g to use GPU for DGEMM
# -A to Do async DMA transfer, always enable
# -tc to print full CALDGEMM config settings
# -01 <string> to specify an external dgemm library
# -0x Removes the CPU fromt he OpenCL context
# -F <num> define OpenCL Platform ID to use
# -/ <list> specify which GPU devices to use
#
#

FLAGS="-O 2 -Oc 1 -z -g -A -tc"

cd ./caldgemm; \
./dgemm_bench $FLAGS


