
OCL_HOME=/opt/rocm/opencl
OCL_INC=$(OCL_HOME)/include
OCL_LIB=$(OCL_HOME)/lib/x86_64


all: vecAdd

vecAdd: ocl_vector_addition.cpp vector_add_kernel.cl
	g++ -o vecAdd ocl_vector_addition.cpp -I$(OCL_INC) -L$(OCL_LIB) -lOpenCL -std=c++11 

clean:
	rm vecAdd
