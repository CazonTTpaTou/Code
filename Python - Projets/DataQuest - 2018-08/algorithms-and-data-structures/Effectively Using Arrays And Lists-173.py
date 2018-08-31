## 2. Arrays And Binary ##

numbers = list(range(100))

binary = [bin(num)[2:] for num in numbers]

new_numbers = [int(bnr,2) for bnr in binary]

status = numbers == new_numbers

print(status)

print(binary)


## 4. Arrays And Lists ##

import time
import matplotlib.pyplot as plt

times = {}
iterations = 1000
numbers = list(range(20))

l = list()

for iteration in range(0,iterations):
    for i in numbers:
        start_timer = time.time()
        l.append(i)
        end_timer = time.time()
        length=end_timer-start_timer
        try:
            times[i].append(length)
        except:
            times[i]=list()

avg_times = list()

for i in numbers:
    avg_times.append(sum(times[i]))
    
plt.bar(numbers,avg_times)
plt.show()


        

## 6. Array Pointers ##

sentence = "I desperately want a 1982 Winnebago."
sentence2 = sentence

values = [1,2,3,4,5]

sentence_hex = hex(id(sentence))

sentence2_hex = hex(id(sentence2))

values_elements_hex = [hex(id(val)) for val in values]

values_hex = hex(id(values))

print(sentence_hex)

print(sentence2_hex)

print(values_elements_hex)

print(values_hex)





## 8. Implementing An Array ##

import numpy as np
import csv

class Array():
    def __init__(self, size):
        self.array = np.zeros(size, dtype=np.float64)
        self.size = size
    
    def __getitem__(self, key):
        return self.array[key]
    
    def __setitem__(self,key,value):
        self.array[key] = value

prices = Array(10)
with open('prices.csv') as f:
    next(f)
    price = list(csv.reader(f))[:10]
    
for index,p in enumerate(price):
    prices[index] = float(p[1])
    
    
    



## 9. Resizing The Array ##

class Array():
    def __init__(self, size):
        self.array = np.zeros(size, dtype=np.float64)
        self.size = size
        
    def __len__(self):
        self.size = len(self.array)
        return self.size
    
    def __getitem__(self, key):
        return self.array[key]
    
    def __setitem__(self, key, value):
        self.array[key] = value
        
    def insert(self,position,value):
        self.size+=1
        new_array = np.zeros(self.size,dtype=np.float64)
        offset=0
        new_array[position]=value
        
        for index,val in enumerate(self.array):
            if index==position:
                offset=1
            new_array[index+offset]=val
            
        self.array = new_array
        
    def append(self,value):
        self.insert(self.size+1,value)

with open('prices.csv','r') as f:        
    all_prices = [row.split(',')[1] for row in f.readlines()][1:]
    all_prices = [float(price.strip()) for price in all_prices]
    
prices = Array(0)

for index,price in enumerate(all_prices[:100]):
    prices.insert(index,price)

prices.insert(50,646.921081)


        
        

## 10. Resizing The Array ##

class Array():
    def __init__(self, size):
        self.array = np.zeros(size, dtype=np.float64)
        self.size = size
    
    def __getitem__(self, key):
        return self.array[key]
    
    def __setitem__(self, key, value):
        self.array[key] = value
    
    def insert(self, position, value):
        new_array = np.zeros(self.size + 1, dtype=np.float64)
        new_pos = 0
        for i, item in enumerate(self.array):
            if i == position:
                new_array[new_pos] = value
                new_pos += 1
            new_array[new_pos] = item
            new_pos += 1
        if position == (self.size):
            new_array[new_pos] = value
        self.size += 1
        self.array = new_array
    
    def __len__(self):
        return self.size
    
    def append(self, value):
        self.insert(self.size, value)
        
    def pop(self,position):
        self.size-=1
        removed = self.array[position]
        new_array = np.zeros(self.size,dtype=np.float64)
        offset=0
        
        for index,val in enumerate(self.array):            
            new_array[index+offset]=val
            offset=(index>=position)*(-1)
            
        self.array = new_array
        return removed
    
with open('prices.csv','r') as f:
    next(f)
    all_prices = [price.split(',')[1] for price in f.readlines()]
    all_prices = [float(price.strip()) for price in all_prices]

prices = Array(0)                        
                        
for value in all_prices:
    prices.append(value)
                        
print(prices.pop(40))
                        
                        
                        

## 12. Linked Lists ##

class Node():
    def __init__(self, value):
        self.value = value
        self.next_node = None
    
    def set_next_node(self, node):
        self.next_node = node
        
    def append(self,value):
        new_node = Node(value)
        self.set_next_node(new_node)
        return new_node
    
price_1 = Node(all_prices[0])
node = price_1

for value in all_prices[1:5]:
    node = node.append(value)

node = price_1    
    
while node.next_node is not None:
    print(node.value)
    node = node.next_node
            
        
        

## 13. Indexing A Linked List ##

class Node():
    def __init__(self, value):
        self.value = value
        self.next_node = None
    
    def set_next_node(self, node):
        self.next_node = node
    
    def append(self, value):
        next_node = Node(value)
        self.next_node = next_node
        return next_node
    
    def __getitem__(self,position):
        node = self
        for item in range(0,position):
            node = node.next_node
        return node
    
price_1 = Node(all_prices[0])
node = price_1

for price in all_prices[1:5]:
    node = node.append(price)
    
print(price_1[2].value)

print(price_1[3].value)
    
    

## 14. Inserting Into A Linked List ##

class Node():
    def __init__(self, value):
        self.value = value
        self.next_node = None
    
    def set_next_node(self, node):
        self.next_node = node
    
    def append(self, value):
        next_node = Node(value)
        self.next_node = next_node
        return next_node
    
    def __getitem__(self, key):
        node = self
        counter = 0
        while counter < key:
            node = node.next_node
            counter += 1
        return node
    
    def insert(self,position,value):
        newnode = Node(value)

        try:
            newnode.set_next_node(self[position])
        except:
            next_node = None            
        
        if position>0:
            self[position-1].set_next_node(newnode)
            return self
        else :
            return newnode


                
price_1 = Node(all_prices[0])
node = price_1

for price in all_prices[1:5]:
    node = node.append(price)

node=price_1
print(node.value)
for i in range(0,4):
    node = node.next_node
    print(node.value)


          
price_1 = price_1.insert(2,all_prices[4])
price_1 = price_1.insert(0,all_prices[5])
price_1 = price_1.insert(6,all_prices[6])



print('--'*20)    
print(price_1[3].value)
print('--'*20)

node=price_1
print(node.value)
for i in range(0,7):
    node = node.next_node
    print(node.value)

## 15. Removing From A Linked List ##

class Node():
    def __init__(self, value):
        self.value = value
        self.next_node = None
    
    def set_next_node(self, node):
        self.next_node = node
    
    def append(self, value):
        next_node = Node(value)
        self.next_node = next_node
        return next_node
    
    def __getitem__(self, key):
        node = self
        counter = 0
        while counter < key:
            node = node.next_node
            counter += 1
        return node
    
    def insert(self, position, value):
        if position == 0:
            node = Node(value)
            node.next_node = self
            return node
        else:
            node = Node(value)
            split_start = self[position - 1]
            split_end = split_start.next_node
            split_start.next_node = node
            node.next_node = split_end
            return self
        
    def pop(self,position):
        node_removed = self[position]
        
        if position==0:
            self = self[position+1]    
        else : 
            try:
                self[position-1].set_next_node(self[position+1])
            except:
                self[position-1].set_next_node(None)
                
        return node_removed,self
    
price_1 = Node(all_prices[0])
node = price_1
for price in all_prices[1:5]:
    node = node.append(price)

node = price_1
for item in range(0,4):
    print(node.value)
    node = node.next_node

print(node.value)      
    
removed1,price_1 = price_1.pop(0)
removed2,price_1 = price_1.pop(3)
    
print('--'*20)  

print(price_1[2].value)

print('--'*20)

node = price_1
for item in range(0,2):
    print(node.value)
    node = node.next_node        

print(node.value)     
        