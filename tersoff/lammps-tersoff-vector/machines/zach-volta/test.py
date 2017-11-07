#!/usr/bin/python

import subprocess

def environment_setup():
    proc = subprocess.check_output("echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope".split(" "))


class Tester():
    def __init__(self, num_processes, binary_name, input_file, mode):
        self.command = "mpirun -np {} ./lammps-10Mar16/src/{} -in {} mode {}".format(num_processes, binary_name, input_file, mode)
    def run_test(self, output_file):
        proc = subprocess.check_output(self.command.split(" "))
        perf = ""
        for line in proc.split("\n"):
            if "Performance: " in line:
                perf = line.split("Performance: ")[1].split("ns/day")[0].rstrip()
        if len(perf) > 0:
            with open(output_file, "a+") as out:
                out.write("{}\n".format(perf))



if __name__ == "__main__":
#    environment_setup()
    vect_file = "vect_perf.txt"
    with open(vect_file, "w+") as f:
        f.write("ns/day\n")
    tester = Tester(2, "lmp_kokkos_cuda_vect", "in.tersoff", "double")
    for x in range(0,1):
        tester.run_test(vect_file)

    vect_file = "no_vect_perf.txt"
    with open(vect_file, "w") as f:
        f.write("ns/day\n")
    tester = Tester(2, "lmp_kokkos_cuda_novect", "in.tersoff", "double")
    for x in range(0, 1):
        tester.run_test(vect_file)




