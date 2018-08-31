## 2. Searching Arrays ##

import pandas as pd

data = pd.read_csv("amounts.csv")
amounts = list(data["Amount"])
times = [int(i) for i in list(data["Time"])]

first_4554 = times.index(4554)

print(first_4554)

## 3. Linear Search ##

def linear_search(array, search):
    indexes=list()
    for index,item in enumerate(array):
        if search==item:
            indexes.append(index)
    return indexes

sevens = linear_search(times,7)











## 4. Searching Multiple Arrays ##

def linear_multi_search(array, search):
    indexes=list()
    for index,row in enumerate(array):
        equality=True
        for col_row,col_search in zip(row,search):
            if col_row!=col_search:
                equality=False
        if equality:
            indexes.append(index)
    return indexes

transactions=list()

for ti,am in zip(times,amounts):
    transactions.append([ti,am])
    
results = linear_multi_search(transactions,[56,10.84])

                
        




## 5. Profiling Linear Search ##

import matplotlib.pyplot as plt

def linear_search(array, search):
    indexes = []
    counter = 0
    for i, item in enumerate(array):
        counter+=1
        if item == search:
            indexes.append(i)
    return counter,indexes

lengths = [10,100,1000,10000]
counters = list()

for length in lengths:
    first_amounts = amounts[:length]
    counters.append(linear_search(first_amounts,7)[0])
    
plt.plot(lengths,counters)

plt.show()



## 7. Binary Search ##

import math

def swap(array, pos1, pos2):
    store = array[pos1]
    array[pos1] = array[pos2]
    array[pos2] = store

def insertion_sort(array):
    for i in range(1, len(array)):
        j = i
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

insertion_sort(times)
result = min(binary_search(times,56))

            

## 8. Complex Criteria With Binary Search ##

def insertion_sort(array):
    for i in range(1, len(array)):
        j = i
        while j > 0 and array[j - 1] > array[j]:
            swap(array, j, j-1)
            j-=1

def binary_search(array, search):
    array.sort()
    m = 0
    i = 0
    z = len(array) - 1
    while i<= z:
        m = math.floor(i + ((z - i) / 2))
        if array[m] == search:
            return m
        elif array[m] < search:
            i = m + 1
        elif array[m] > search:
            z = m - 1
            
transactions = [str(ti)+'_'+str(am) for ti,am in zip(times,amounts)]
print(transactions[:20])
print(transactions.index('56_10.84'))
result = binary_search(transactions,'56_10.84')
                                           
                                           
                                           

## 9. Fuzzy Matches With Binary Search ##

def binary_search(array, search):
    array.sort()
    m = 0
    i = 0
    z = len(array) - 1
    while i<= z:
        m = math.floor(i + ((z - i) / 2))
        if array[m] == search:
            return m
        elif array[m] < search:
            i = m + 1
        elif array[m] > search:
            z = m - 1
    
    return m

def fuzzy_match(array, lower, upper, m):
    matches=list()
    left=m
    right=m+1
    while left>=0 and array[left]>=lower:
        matches.append(array[left])
        left-=1
    while right<=len(array) and array[right]<=upper:
        matches.append(array[right])
        right+=1
    return matches

m = binary_search(amounts,150)
matches = fuzzy_match(amounts,100,2000,m)

print(matches)



## 10. Profiling Binary Search ##

import matplotlib.pyplot as plt

def binary_search(array, search):
    counter=0
    array.sort()
    m = 0
    i = 0
    z = len(array) - 1
    while i<= z:
        counter+=1
        m = math.floor(i + ((z - i) / 2))
        if array[m] == search:
            return counter,m
        elif array[m] < search:
            i = m + 1
        elif array[m] > search:
            z = m - 1
    return counter,m

lengths = [10,100,1000,10000]
counters=list()

for length in lengths:
    first_amounts=amounts[:length]
    counters.append(binary_search(first_amounts,-1)[0])
    
plt.plot(lengths,counters)
plt.show()

    



## 11. Profiling Binary Search With Sorting ##

def insertion_sort(array):
    counter=0
    for i in range(1, len(array)):
        j = i
        while j > 0 and array[j - 1] > array[j]:
            swap(array, j, j-1)
            j-=1
            counter+=1
    return counter

def binary_search(array, search):
    counter = insertion_sort(array)    
    m = 0
    i = 0
    z = len(array) - 1
    while i<= z:
        counter += 1
        m = math.floor(i + ((z - i) / 2))
        if array[m] == search:
            return m
        elif array[m] < search:
            i = m + 1
        elif array[m] > search:
            z = m - 1
    return counter

lengths = [10,100,1000,10000]

counters = []
for i in lengths:
     # We sort in reverse order so we get the worst case performance of the insertion sort.
    first_amounts = sorted(amounts[:i], reverse=True)
    counter = binary_search(first_amounts, -1)
    counters.append(counter)

plt.plot(lengths, counters)