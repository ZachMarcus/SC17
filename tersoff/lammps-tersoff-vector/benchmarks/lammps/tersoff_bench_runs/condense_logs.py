#!/usr/bin/python3


import sys
import os.path


def get_run_info(filename):
    result = 0.0
    with open(filename, "r+") as f:
        data = f.read()
        first_run = True
        for line in data.split("\n"):
            if "ns/day" in line:
                if first_run:
                    first_run = False
                    continue
                else:
                    result = float(line.split(" ")[1])
                    return result
    print("Error in getting run info")
    return 0


def missing_files(list_of_files):
    for f in list_of_files:
        if not os.path.isfile(f):
            print("Missing file: {}".format(f))
            return True
    return False


def avg(list_of_nums):
    return sum(list_of_nums) / float(len(list_of_nums))



if __name__ == "__main__":
    gpu_double = ["tersoff_bench-gpu-double-1.log",
                  "tersoff_bench-gpu-double-2.log",
                  "tersoff_bench-gpu-double-3.log",
                  "tersoff_bench-gpu-double-4.log",
                  "tersoff_bench-gpu-double-5.log"]
    gpu_mixed = ["tersoff_bench-gpu-mixed-1.log",
                  "tersoff_bench-gpu-mixed-2.log",
                  "tersoff_bench-gpu-mixed-3.log",
                  "tersoff_bench-gpu-mixed-4.log",
                  "tersoff_bench-gpu-mixed-5.log"]
    gpu_single = ["tersoff_bench-gpu_single-1.log",
                  "tersoff_bench-gpu_single-2.log",
                  "tersoff_bench-gpu_single-3.log",
                  "tersoff_bench-gpu_single-4.log",
                  "tersoff_bench-gpu_single-5.log"]
    kk_novect = ["tersoff_bench-kokkos_novect-1.log",
                 "tersoff_bench-kokkos_novect-2.log",
                 "tersoff_bench-kokkos_novect-3.log",
                 "tersoff_bench-kokkos_novect-4.log",
                 "tersoff_bench-kokkos_novect-5.log"]
    kk_vect = ["tersoff_bench-kokkos_vect-1.log",
               "tersoff_bench-kokkos_vect-2.log",
               "tersoff_bench-kokkos_vect-3.log",
               "tersoff_bench-kokkos_vect-4.log",
               "tersoff_bench-kokkos_vect-5.log"]

    files = [gpu_double, gpu_mixed, gpu_single, kk_novect, kk_vect]
    missing_file = any(missing_files(fil) for fil in files)

    if missing_file:
        exit(-1)

    gpu_double_scores = []
    gpu_mixed_scores = []
    gpu_single_scores = []
    kk_novect_scores = []
    kk_vect_scores = []

    for run in gpu_double:
        gpu_double_scores.append(get_run_info(run))
    for run in gpu_mixed:
        gpu_mixed_scores.append(get_run_info(run))
    for run in gpu_single:
        gpu_single_scores.append(get_run_info(run))
    for run in kk_novect:
        kk_novect_scores.append(get_run_info(run))
    for run in kk_vect:
        kk_vect_scores.append(get_run_info(run))


# format:
# Type Min Max Average

    with open("performance.csv", "w+") as f:
        f.write("Binary,Min,Max,Average\n")
        f.write("{},{},{},{}\n".format("Ref-GPU-D",
                                       min(gpu_double_scores),
                                       max(gpu_double_scores),
                                       avg(gpu_double_scores)))
        f.write("{},{},{},{}\n".format("Ref-GPU-M",
                                       min(gpu_mixed_scores),
                                       max(gpu_mixed_scores),
                                       avg(gpu_mixed_scores)))
        f.write("{},{},{},{}\n".format("Ref-GPU-S",
                                       min(gpu_single_scores),
                                       max(gpu_single_scores),
                                       avg(gpu_single_scores)))
        f.write("{},{},{},{}\n".format("Ref-KK-D",
                                       min(kk_novect_scores),
                                       max(kk_novect_scores),
                                       avg(kk_novect_scores)))
        f.write("{},{},{},{}\n".format("Opt-KK-D",
                                       min(kk_vect_scores),
                                       max(kk_vect_scores),
                                       avg(kk_vect_scores)))


