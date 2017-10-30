#1/binbash

# Get HPL
wget http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz
tar xf hpl-2.2.tar.gz

# Get OpenMPI
wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz
tar xf openmpi-3.0.0.tar.gz
cd openmpi-3.0.0; \
./configure --enable-static --enable-dynamic --prefix=/home/zmarcus/SC17/HPL/openmpi-3.0.0/install \
make -j; \
make install



