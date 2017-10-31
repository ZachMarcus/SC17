#1/binbash

BASE=/home/zmarcus/SC17/HPL


# Get HPL
hpl() {
  cd $BASE; \
  wget http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz; \
  tar xf hpl-2.2.tar.gz; \
  # Try BLIS CPU library
  cp Make.EPYC ./hpl-2.2/Make.EPYC; \
  source env.sh; \
  cd hpl-2.2/; \
  make arch=EPYC -j; \
  make arch=EPYC -j install
}

# Get OpenMPI
openmpi() {
  cd $BASE; \
  wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz; \
  tar xf openmpi-3.0.0.tar.gz; \
  cd openmpi-3.0.0; \
  ./configure --enable-static --enable-dynamic --prefix=$BASE/openmpi-3.0.0/install \
  make -j; \
  make -j install
}

# Get BLIS
blis() {
  cd $BASE; \
  git clone https://github.com/flame/blis.git; \
  cd blis; \
  ./configure --enable-threading=pthreads --enable-cblas -p $BASE/blis/install/ --enable-shared --enable-static haswell \
  make -j; \
  make -j install
}

# Get rocBLAS
rocblas() {
  git clone https://github.com/ROCmSoftwarePlatform/rocBLAS.git
  mkdir rocBLAS/install
  mkdir rocBLAS/build
  cd rocBLAS/build; \
  cmake -DCMAKE_INSTALL_PREFIX:PATH=$BASE/rocBLAS/install ..; \
  make -j install
}

# Get clBLAS
clblas() {
  git clone https://github.com/clMathLibraries/clBLAS.git
}


openmpi
blis
hpl




