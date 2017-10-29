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
 - [netlib version](http://www.netlib.org/benchmark/hpl/)
 - [David Rohr version](https://github.com/davidrohr/hpl-gpu/wiki)


