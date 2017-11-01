if [ "0$CALDGEMM_ENVIRONMENT" == "1" ]; then
    exit;
fi



HOMEDIR=/home/zmarcus/SC17/rohr


###Patchs to required software
#Path to AMD APP SDK
export AMDAPPSDKROOT=/opt/rocm/opencl
#Path to OpenMPI
export OPENMPI_PATH=$HOMEDIR/openmpi-3.0.0/install
#Base path to Intel software
export INTELPATH=$HOMEDIR/intel
#Path to the Intel MKL BLAS library (usually inside $INTELPATH)
export MKL_PATH=$INTELPATH/mkl
#Path to libiomp (as part of ICC or standalone)
export ICC_PATH=$INTELPATH
#Path to the GotoBLAS BLAS library
export GOTOBLAS_PATH=$HOMEDIR/GotoBLAS2
#Path to AMD ACML BLAS library
export ACML_PATH=$HOMEDIR/acml/gfortran64_mp
#Path to the CBLAS interface (required for ACML BLAS Slibrary)
export CBLAS_PATH=$HOMEDIR/CBLAS
#Path to NVIDIA CUDA SDK
export CUDA_PATH=/usr/local/cuda

###Add all required paths to $LD_LIBRARY_PATH
#We want to use the most recent AMD OpenCL library. Usually this comes with the driver. If the SDK is newer than the driver, outcomment the next line.
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$AMDAPPSDKROOT/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_PATH/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ICC_PATH/lib/intel64:$MKL_PATH/lib/intel64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ACML_PATH/lib
export LD_LIBRARY_PATH=$OPENMPI_PATH/lib:$LD_LIBRARY_PATH
#We need one library path at the very beginning that overrides all others for preloading libraries
export LD_LIBRARY_PATH=$HOMEDIR/lib:$LD_LIBRARY_PATH

###Add OpenMPI to $PATH for mpirun command
export PATH=$OPENMPI_PATH/bin:$PATH

###Set some environment variables for AMD GPUs and for Headless X Setup
export GPU_FORCE_64BIT_PTR=1
export GPU_NUM_COMPUTE_RINGS=1
export DISPLAY=:0
export COMPUTE=:0

###Set correct ulimits for memory allocation
ulimit -v unlimited
ulimit -m unlimited
ulimit -l unlimited

#We do need to set these values only once
export CALDGEMM_ENVIRONMENT=1
