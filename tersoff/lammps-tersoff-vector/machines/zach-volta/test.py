#!/usr/bin/python

import subprocess

def environment_setup():
    proc = subprocess.check_output("echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope".split(" "))


class Tester():
    def __init__(self, command):
        self.command = command.split(" ")
    def run_test(self, output_file):
        proc = subprocess.check_output(self.command)
        perf = ""
        for line in proc.split("\n"):
            if "Performance: " in line:
                perf = line.split("Performance: ")[1].split("ns/day")[0].rstrip()
        if len(perf) > 0:
            with open(output_file, "a+") as out:
                out.write("{}\n".format(perf))



if __name__ == "__main__":
#    environment_setup()

    runtime_tests = {
        "gpu_package_single": "mpirun -np 1 ./lammps-10Mar16/src/lmp_mpi_gpu_single -in in.tersoff -sf gpu",
        "gpu_package_double": "mpirun -np 1 ./lammps-10Mar16/src/lmp_mpi_gpu_double -in in.tersoff -sf gpu",
        "gpu_package_mixed": "mpirun -np 1 ./lammps-10Mar16/src/lmp_mpi_gpu_mixed -in in.tersoff -sf gpu",
        "kokkos_package_vect": "mpirun -np 1 ./lammps-10Mar16/src/lmp_kokkos_cuda_vect -v p -sf kk -k on t 0 g 1 -in in.tersoff mode double",
        "kokkos_package_novect": "mpirun -np 1 ./lammps-10Mar16/src/lmp_kokkos_cuda_novect -v p -sf kk -k on t 0 g 1 -in in.tersoff mode double"
    }


    for run in runtime_tests.keys():
        with open("{}.log".format(run), "w+") as f:
            f.write("ns/day\n")
        tester = Tester(runtime_tests[run])
        for x in range(0, 1):
            tester.run_test("{}.log".format(run))


