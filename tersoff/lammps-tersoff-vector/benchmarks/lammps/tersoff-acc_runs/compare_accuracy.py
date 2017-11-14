#!/usr/bin/python3


import sys



def get_run_info(filename):
    result = {}
    with open(filename, "r+") as f:
        in_data = False
        data = f.read()
        for line in data.split("\n"):
            if in_data:
                if "Loop time" in line:
                    return result
                line = line.split()
#                print(line)
                result[int(line[0])] = float(line[4])
            else:
                if "TotEng" in line:
                    in_data = True


def calc_difference(base_val, comparison_val):
    return abs((base_val - comparison_val) / base_val)




if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: ./compare_accuracy.py [base_file] [comparison_file]")
        exit(-1)
    file1 = sys.argv[1]
    file2 = sys.argv[2]

    file1_info = get_run_info(file1)
    file2_info = get_run_info(file2)

    with open("comparison.csv", "w+") as f:
        for key in sorted(file1_info.keys()):
            if key not in file2_info.keys():
                print("failed")
            else:
                f.write("{},{}\n".format(key, calc_difference(file1_info[key], file2_info[key])))

    keys = sorted(file1_info.keys())
    for key in keys:
        if key not in file2_info.keys():
            print("dang")




