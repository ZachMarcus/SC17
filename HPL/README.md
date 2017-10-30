# HPL: a hot mess

## CPU libraries
 - BLIS
 - Intel MKL

Need to test these against one another.
BLIS needs to have an optimal configuration
Scaling studies gotta get run


## GPU libraries
 - rocBLAS
 - clBLAS
 - cuBLAS?

Is Nvidia something we need to look at? Hardware configuration TBD
Need to test these against one another.
Building could be challenging


## Bringing it all together
Which version of HPL to use?
 - Nvidia-provided binary, potential if using V100's
 - [Netlib version](http://www.netlib.org/benchmark/hpl/)
 - [David Rohr version](https://github.com/davidrohr/hpl-gpu/wiki)



## Tuning HPL-CPU
Problem size N?
 - 3.8GB RAM/processor (no hyperthreading)
 - 475M of 8 byte elements
 - 21794 Size -> 21504



### BLIS
 - [Testing](https://github.com/flame/blis/wiki/Testsuite)
 - [Kernel Optimizations](https://github.com/flame/blis/wiki/KernelsHowTo)
 - [Configuration](https://github.com/flame/blis/wiki/ConfigurationHowTo)
   - Two header files, "bli_config.h" and "bli_kernel.h"
     - bli_config.h
```
#define BLIS_ENABLE_OPENMP
#define BLIS_ENABLE_PTHREADS
#define BLIS_SIMD_NUM_REGISTERS 64
#define BLIS_SIMD_SIZE 32 # size in bytes of registers
#define BLIS_CACHE_LINE_SIZE 64
#define BLIS_PAGE_SIZE 4096
#define BLIS_SIMD_ALIGN_SIZE 16
#define BLIS_STACK_BUF_ALIGN_SIZE BLIS_SIMD_ALIGN_SIZE
#define BLIS_HEAP_ADDR_ALIGN_SIZE BLIS_SIMD_ALIGN_SIZE
#define BLIS_HEAP_STRIDE_ALIGN_SIZE BLIS_CACHE_LINE_SIZE
#define BLIS_POOL_ADDR_ALIGN_SIZE BLIS_PAGE_SIZE
#define BLIS_ENABLE_BLAS2BLIS # we want this, compatibility layer
#define BLIS_ENABLE_CBLAS
```

     - bli_kernel.h
```
#define BLIS_DEFAULT_MR_D 8
#define BLIS_DEFAULT_NR_D 4

```

   - Makefile definitions, "make_defs.mk"
     - Note: use Haswell as base
   - optimized kernels, specified via a symlink to subdir in kernels/
 - Environment
   - OMP_NUM_THREADS




