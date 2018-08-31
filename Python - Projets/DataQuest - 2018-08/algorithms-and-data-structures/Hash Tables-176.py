## 2. Hash Tables ##

import os
quotes = {}

list_files = os.listdir('lines')

for fil in list_files:
    key = fil.replace('.txt','')
    name_file = '/'.join(['lines',fil])
    
    with open(name_file,'r',encoding='UTF-8') as f:
        quotes[key]=f.read()
        
print(quotes)        
        
        







## 3. Hash Functions ##

def simple_hash(key):
    key_str = str(key)
    first_character = key_str[0]
    return ord(first_character)

xmen_hash = simple_hash('xmen')

things_hash = simple_hash('10thingsihateaboutyou')



## 4. Fitting Values Into An Array ##

def simple_hash(key):
    key = str(key)
    modulo = ord(key[0]) % 20
    return modulo

xmen_hash = simple_hash('xmen')

things_hash = simple_hash('10thingsihateaboutyou')



## 5. Creating A Hash Table ##

import numpy as np

def simple_hash(key):
    key = str(key)
    code = ord(key[0])
    return code % 20

class HashTable():
    
    def __init__(self, size):
        self.size=size
        self.hashtable = np.empty(self.size,
                                  dtype=np.object)
    
    def __getitem__(self, key):
        index = simple_hash(key)
        return self.hashtable[index]
    
    def __setitem__(self, key, value):
        index = simple_hash(key)
        self.hashtable[index]=value

hash_table = HashTable(20)

with open('lines/xmen.txt','r',encoding='utf-8') as f:
    hash_table['xmen'] = f.read()
    
print(hash_table)
    

## 6. Hash Collisions ##

class HashTable():
    
    def __init__(self, size):
        self.array = np.empty(size, dtype=np.object)
        self.size = size
    
    def __getitem__(self, key):
        ind = simple_hash(key)
        return self.array[ind]
    
    def __setitem__(self, key, value):
        ind = simple_hash(key)
        
        if self.array[ind] is None:
            self.array[ind] = list()
            
        self.array[ind].append(value)
        
hash_table = HashTable(20)

with open('lines/xmen.txt','r',encoding='utf-8') as f:
    hash_table['xmen'] = f.read()
    
with open('lines/xmenoriginswolverine.txt','r',encoding='utf-8') as g:
    hash_table['xmenoriginswolverine'] = g.read()
    
    
    

## 7. Retrieving Values From Hash Tables ##

class HashTable():
    
    def __init__(self, size):
        self.array = np.zeros(size, dtype=np.object)
        self.size = size
    
    def __getitem__(self, key):
        ind = simple_hash(key)
        tup = self.array[ind]
        
        for t in tup:
            if t[0]==key:
                return t[1]
    
    def __setitem__(self, key, value):
        ind = simple_hash(key)
        
        tup = tuple([key,value])
        
        if not isinstance(self.array[ind], list):
            self.array[ind] = []
            
        self.array[ind].append(tup)
        
hash_table = HashTable(20)

with open('lines/xmen.txt','r',encoding='utf-8') as f:
    hash_table['xmen'] = f.read()

with open('lines/xmenoriginswolverine.txt','r',encoding='utf-8') as f:
    hash_table['xmenoriginswolverine'] = f.read()    
    
        
        
        

## 8. Overwriting Values ##

class HashTable():
    
    def __init__(self, size):
        self.array = np.zeros(size, dtype=np.object)
        self.size = size
    
    def __getitem__(self, key):
        ind = simple_hash(key)
        for k,v in self.array[ind]:
            if key == k:
                return v
    
    def __setitem__(self, key, value):
        replace = None
        ind = simple_hash(key)
        if not isinstance(self.array[ind], list):
            self.array[ind] = []  
            
        for index,tup in enumerate(self.array[ind]):
            if tup[0]==key:
                replace=index
                
        if replace is None:
            self.array[ind].append((key,value))            
        else:
            self.array[ind][replace]=(key,value)
        
hash_table = HashTable(20)

with open("lines/xmen.txt", 'r') as f:
    hash_table["xmen"] = f.read()

with open("lines/xmenoriginswolverine.txt", 'r') as f:
    hash_table["xmen"] = f.read()       
    
print(hash_table["xmen"])

        

## 9. Profiling Hash Tables ##

def simple_hash(key):
    key = str(key)
    code = ord(key[0])
    return code % 1

class HashTable():
    
    def __init__(self, size):
        self.array = np.zeros(size, dtype=np.object)
        self.size = size
    
    def __getitem__(self, key):
        counter=0
        ind = simple_hash(key)
        for k,v in self.array[ind]:
            counter+=1
            if key == k:
                return v,counter
    
    def __setitem__(self, key, value):
        ind = simple_hash(key)
        if not isinstance(self.array[ind], list):
            self.array[ind] = []
        replace = None
        for i,data in enumerate(self.array[ind]):
            if data[0] == key:
                replace = i
        if replace is None:
            self.array[ind].append((key,value))
        else:
            self.array[ind][replace] = (key, value)

data = [
    ("xmen", "Wolverine"), 
    ("xmenoriginswolverine", "Superman"), 
    ("vanillasky", "Thor"), 
    ("tremors", "Aquaman")
]

hash_table = HashTable(1)

for tup in data:
    hash_table[tup[0]] = tup[1]
    
counter = hash_table["tremors"][1]

print(counter)

hash_table['reptile']='Caiman'

counter = hash_table["tremors"][1]

print(counter)



## 10. Profiling Array Length ##

import time
import os
import matplotlib.pyplot as plt

class HashTable():
    
    def __init__(self, size):
        self.array = np.zeros(size, dtype=np.object)
        self.size = size
    
    def __getitem__(self, key):
        ind = hash(key) % self.size
        for k,v in self.array[ind]:
            if key == k:
                return v
    
    def __setitem__(self, key, value):
        ind = hash(key) % self.size
        if not isinstance(self.array[ind], list):
            self.array[ind] = []
        replace = None
        for i,data in enumerate(self.array[ind]):
            if data[0] == key:
                replace = i
        if replace is None:
            self.array[ind].append((key,value))
        else:
            self.array[ind][replace] = (key, value)

def profile_table(size):
    start = time.time()
    hash_table = HashTable(size)
    directory = "lines"
    
    for filename in os.listdir(directory):
        name = filename.replace(".txt", "")
        hash_table[name] = quotes[name]
        
    duration = time.time()-start
    return duration

lengths = [1,10,20,30,40,50]
times = list()

for length in lengths:
    times.append(profile_table(length))
    
plt.plot(lengths,times)

plt.show()

