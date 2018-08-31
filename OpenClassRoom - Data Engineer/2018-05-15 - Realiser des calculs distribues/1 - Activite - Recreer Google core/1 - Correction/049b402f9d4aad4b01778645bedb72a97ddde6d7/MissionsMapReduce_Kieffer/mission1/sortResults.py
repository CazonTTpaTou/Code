#! /usr/bin/env python3
import sys
import pandas as pd


def sortData(filepath):
    data = pd.read_csv(filepath, sep = "\t", names = ['word', 'doc_id', 'w_t'])
    data_sorted = data.sort_values(by = ['w_t'], ascending = False).reset_index(drop = True)
    return data_sorted

def main():
    if len(sys.argv) != 2:
        print("ERROR: program should be run with the following command: ./sortResults.py filepath")
        return
    else:
        data_sorted = sortData(sys.argv[1])
        print(data_sorted.head(20))

if __name__ == "__main__":
    main()
