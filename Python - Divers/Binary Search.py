import math
import csv

rep_file='C:\\Users\\monne\\Desktop'
name_file='amounts.csv'
filer="\\".join([rep_file,name_file])

with open(filer,'r') as f:
    next(f)
    data=list(csv.reader(f))

amount=[float(row[1]) for row in data]
times=[int(row[0].strip().replace('1e+05','100000')) for row in data]

times.sort()

def swap(array, pos1, pos2):
    store = array[pos1]
    array[pos1] = array[pos2]
    array[pos2] = store

def insertion_sort(array):
    for i in range(1, len(array)):
        j = i
        print(j)
        while j > 0 and array[j - 1] > array[j]:
            swap(array, j, j-1)
            j-=1

def binary_search(array, search):
    indexes=list()
    begin=0
    end=len(array)-1
    
    while end>=begin:
        middle=int(math.floor(begin+(end-begin)/2))

        if array[middle]==search:
            indexes.append(middle)
            if array[middle+1] > search:
                end=middle-1
            else:
                begin=middle+1

        elif search > array[middle]:
            begin=middle+1
        else:
            end=middle-1
            
    return indexes

#insertion_sort(times)

print(binary_search(times,56))
result = min(binary_search(times,56))
print(result)

            