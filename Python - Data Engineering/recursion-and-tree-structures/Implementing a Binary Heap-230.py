## 2. Heap Inserts ##

class Node:
    def __init__(self, value=None):
        self.value = value
        self.left = None
        self.right = None
        self.parent = None

    def __repr__(self):
        # Helpful method to keep track of Node values.
        return "<Node: {}>".format(self.value)    

class MaxHeap:
    def __init__(self):
        self.root = None
    
    def insert(self,value):
        node = Node(value=value)
        
        if self.root is None:
            self.root = node
            return node
        
        if self.root.value >= value:
            node.parent = self.root
            if not self.root.left:
                self.root.left = node
            elif not self.root.right:
                self.root.right = node
            return node
        
        old_root = self.root
        node.left = old_root.left
        node.right = old_root.right
        self.root = node
        
        if not self.root.left:
            self.root.left = old_root
        elif not self.root.right:
            self.root.right = old_root
        return node
    
heap = MaxHeap()

heap.insert(3)
heap.insert(9)
heap.insert(11)

root = heap.root.value
left = heap.root.left.value
right = heap.root.right.value


print(heap)

        
    
    
    
    

## 3. Speed Up Insert ##

import math

class MaxHeap:
    def __init__(self):
        self.nodes = []
    
    def insert(self,value):
        index = len(self.nodes)
        self.nodes.append(value)
        
        while index>0:
            index_parent=math.floor((index-1)/2)
            
            if self.nodes[index]>self.nodes[index_parent]:
                buffer_value = self.nodes[index_parent]
                self.nodes[index_parent] = self.nodes[index]
                self.nodes[index] = buffer_value
                index = index_parent                
            else:
                index=0
                            
heap = MaxHeap()

heap.insert(3)
heap.insert(9)
heap.insert(11)

nodes = heap.nodes

print(nodes)




## 4. Get the Max Integer ##

class MaxHeap(BaseMaxHeap):
    pass

    def insert_multiple(self,list_values):
        for value in list_values:
            self.insert(value)
            
    def max(self):
        return self.nodes[0]
    
heap = MaxHeap()

list_value = [1,2,3,8,5,9,7,3,5]

heap.insert_multiple(heap_list)

heap_max = heap.max()

print(heap_max)




## 5. Pop the Root Value ##

class MaxHeap(BaseMaxHeap):
    def pop(self):
        root = self.nodes[0]
        self.nodes[0] = self.nodes[-1]
        self.nodes = self.nodes[:-1]
        index=0
        index_left=2*index+1
        index_right=2*index+2
        
        while max(index_left,index_right) <= len(self.nodes)-1:
            swap_index = index_left
            if self.nodes[swap_index]<self.nodes[index_right]:
                swap_index=index_right
            if self.nodes[swap_index]<self.nodes[index]:
                return root
            
            self.nodes[swap_index], self.nodes[index] = self.nodes[index], self.nodes[swap_index]
            
            index_left=2*index+1
            index_right=2*index+2
            index = swap_index
        
        return root    
    
heap = MaxHeap()
heap.insert_multiple(heap_list)

heap_max=heap.max()
heap_map = heap.pop()





## 6. Grab the Top N Elements ##

class MaxHeap(BaseMaxHeap):
    
    def top_n_elements(self,number):
        top=list()
        
        for num in range(0,number):
            top.append(self.pop())
    
        return top
    
heap = MaxHeap()
heap.insert_multiple(heap_list)

top_100 = heap.top_n_elements(100)





## 7. Using Python's Heap ##

import csv

with open('amounts.csv','r') as f:
    next(f)
    amount = list(csv.reader(f))

top_100 = heapq.nlargest(100,amount,key=lambda x:x[1])



## 8. Analyzing the Heap ##

heap_list = list(range(10 * 100 * 5000))
random.shuffle(heap_list)
    
start = time.time()
sorted(heap_list, reverse=True)[:100]
print("Sorting search took: {} seconds".format(time.time() - start))

start = time.time()
heapq.nlargest(100, heap_list)
print("Heap search took: {} seconds".format(time.time() - start))