## 2. Sorting Arrays ##

import pandas as pd

data = pd.read_csv('amounts.csv')

amounts = list(data['Amount'])
times = list(data['Time'])

print(sum(amounts)/len(amounts))





## 3. Swapping Elements ##

def swap(array, pos1, pos2):
    value1 = array[pos1]
    array[pos1] = array[pos2]
    array[pos2] = value1
    return array

first_amounts = amounts[:10]

first_amounts = swap(first_amounts,1,2)



## 4. Selection Sort ##

def swap(array, pos1, pos2):
    value1 = array[pos1]
    array[pos1] = array[pos2]
    array[pos2] = value1
    return array

def selection_sort(array):
    for number in range(0,len(array)):
        """
        print(array[number:])
        try:
            print(min(array[number:]))
        except:
            print('Error !! ')
        """
        try:
            min_value=min(array[number:])
            array = swap(array,number,array.index(min_value))
            print(array)
        except:
            print('Error for {} '.format(number))
    return array

first_amounts = amounts[:10]

first_amounts = selection_sort(first_amounts)



## 5. Profiling The Selection Sort ##

import matplotlib.pyplot as plt

def selection_sort(array):
    counter=0
    for i in range(len(array)):
        lowest_index = i
        for z in range(i, len(array)):
            counter+=1
            if array[z] < array[lowest_index]:
                lowest_index = z
        swap(array, lowest_index, i)
        
    return counter

lengths = [10,100,1000,10000]
counters=list()

for length in lengths:
    first_amounts = amounts[:length]
    counters.append(selection_sort(first_amounts))
    
plt.plot(lengths,counters)
plt.show()


## 6. Bubble Sort ##

def swap(array, pos1, pos2):
    value1 = array[pos1]
    array[pos1] = array[pos2]
    array[pos2] = value1
    return array

def bubble_sort(array):
    swaps=1
    while swaps>0:
        swaps=0
        for index in range(0,len(array)-1):
            if array[index]>array[index+1]:
                array = swap(array,index,index+1)
                swaps+=1
                
    return array
 
first_amounts = amounts[:10]

sorted_array = bubble_sort(first_amounts)

print(sorted_array)
            
    



    

## 7. Profiling The Bubble Sort ##

import matplotlib.pyplot as plt

def bubble_sort(array):
    swaps = 1
    counter=0
    while swaps > 0:
        swaps = 0
        for i in range(len(array) - 1):
            counter+=1
            if array[i] > array[i+1]:
                swap(array, i, i+1)
                swaps += 1
    return counter

lengths = [10,100,1000,10000]

counters = list()

for length in lengths:
    first_amounts = amounts[:length]
    counters.append(bubble_sort(first_amounts))    
    
plt.plot(lengths,counters)
plt.show()



## 9. Insertion Sort ##

def insertion_sort(array):
    for i in range(1,len(array)):
        value = array[i]
        for j in range(i,0,-1):
            if value<array[j-1]:
                swap(array,j,j-1)

first_amounts = amounts[:10]

print(first_amounts)

insertion_sort(first_amounts)

print(first_amounts)
                



## 10. Profiling The Insertion Sort ##

import matplotlib.pyplot as plt

def insertion_sort(array):
    counter=0
    for i in range(1, len(array)):
        j = i
        while j > 0 and array[j - 1] > array[j]:
            counter+=1
            swap(array, j, j-1)
            j-=1
    return counter

lengths = [10,100,1000,10000]
counters=list()

for length in lengths:
    first_amounts = amounts[:length]
    counters.append(insertion_sort(first_amounts))
    
plt.plot(lengths,counters)
plt.show()


    