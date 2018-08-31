## 2. Recursion is thinking in Recursion ##

search_list = ['apple', 'orange', 'pear', 'fig', 'passionfruit']

def search(strings, term, index=0):
    # Implement your recursive solution here.
    if len(strings)==0:
        return -1
    if strings[0]==term:
        return index
    else:
        return search(strings[1:],term,index+1)

print(search(search_list,'croco'))    

print(search(search_list,'pear'))

print(search(search_list,'apple'))

print(search(search_list,'fig'))

apple_index = search(search_list,'apple')

pear_index = search(search_list,'pear')

foo_index = search(search_list,'foo')

## 3. Stack Overflow ##

def traverse_list(values):
    return traverse_list(values)

traverse_list([])

## 4. Divide and Conquer ##

# Load your file and cast it to integers here.

with open('random_integers.txt','r') as f:
    random_integers = [int(line) for line in f.read().strip().split('\n')]

def summation(values):    
    
    if len(values)==0:
        return 0
    
    if len(values)==1:
        return int(values[0])
    
    middle = int(round(len(values)/2,0))
    
    return summation(values[:middle]) + summation(values[middle:])

divide_and_conquer_sum = summation(random_integers)

#print(random_integers)



## 6. Merge Sort (Part 2) ##

f = open('random_integers.txt', 'r')
random_integers = [int(line) for line in f.readlines()]

def merge(left_list,right_list):
    sorted_list=list()
    #print(left_list)
    #print(right_list)
    
    while left_list and right_list:
        if left_list[0]<right_list[0]:
            sorted_list.append(left_list.pop(0))
        else:
            sorted_list.append(right_list.pop(0))
            
    sorted_list += left_list
    sorted_list += right_list
    return sorted_list

def merge_sort(unsorted):
    if len(unsorted)==1:
        return merge([unsorted[0]],[])
    if len(unsorted)==2:
        return merge([unsorted[0]],[unsorted[1]])
    
    middle = len(unsorted)//2

    return merge(merge_sort(unsorted[:middle]),
                 merge_sort(unsorted[middle:]))
                 
random_sorted = merge_sort(random_integers)                 
    
    
            

