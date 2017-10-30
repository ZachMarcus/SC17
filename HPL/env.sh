#!/bib/bash

#LDFLAGS=$(LDFLAGS)/ -L/path/t
export LDFLAGS=$LDFLAGS:/home/zmarcus/SC17/HPL/openmpi-3.0.0/install/lib
export PATH=$PATH:/home/zmarcus/SC17/HPL/openmpi-3.0.0/install/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/zmarcus/SC17/HPL/openmpi-3.0.0/install/lib

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/zmarcus/SC17/HPL/blis/install/lib
