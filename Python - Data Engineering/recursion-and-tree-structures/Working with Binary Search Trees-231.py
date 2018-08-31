## 1. Introduction to Binary Search Trees ##

class Node:
    def __init__(self, value=None):
        self.left = None
        self.right = None
        self.value = value
    
    def __str__(self):
        return "<Node: {}>".format(self.value)

class BST:
    def __init__(self):
        self.node = None
    
    def insert(self,value):
        node = Node(value=value)
        
        if not self.node:
            self.node = node
            self.node.left = BST()
            self.node.right = BST()
            return
        
        if self.node.value > value:
            if self.node.left:
                self.node.left.insert(value)
            else:
                self.node.left.value = node   
                
        else:
            if self.node.right:
                self.node.right.insert(value)
            else:
                self.node.right = node
                
    def inorder(self,tree):
        if not tree.node:
            return list()
        
        return (self.inorder(tree.node.left) + [tree.node.value] + self.inorder(tree.node.right))
    
bst = BST()

bst.insert(4)
bst.insert(2)
bst.insert(1)
bst.insert(5)
bst.insert(3)

sorted_order = bst.inorder(bst)

root = bst.node.value

print(root)



        

## 2. Insert Multiple and Sorted Order ##

class BST(BaseBST):
    
    def insert_multiple(self,values):
        for value in values:
            self.insert(value)
            
    def inorder(self,tree):
        if not tree.node:
            return list()
        
        return (self.inorder(tree.node.left) + [tree.node.value] + self.inorder(tree.node.right))
    
bst = BST()
bst.insert_multiple(bst_values)

sorted_inorder = bst.inorder(bst)

print(sorted_inorder)





## 3. Searching the BST ##

class BST(BaseBST):
    
    def search(self,tree,value):
        if not tree.node:
            return False
        
        if tree.node.value == value:
            return True
        
        if tree.node.value > value:
            return self.search(tree.node.left,value)
        
        if tree.node.value < value:
            return self.search(tree.node.right,value)
        
bst = BST()
bst.insert_multiple(bst_values)

does_exist_1 = bst.search(bst,1)

does_exist_75 = bst.search(bst,75)

does_exist_101 = bst.search(bst,101)








## 4. Why We Need a Balanced BST ##

class BST(BaseBST):
    
    def depth(self,tree):
        
        if not tree:
            return 0
        
        return max(self.depth(tree.node.left),self.depth(tree.node.right))+1
    

    def is_balanced(self,tree):
        return (abs(self.depth(tree.node.left)-self.depth(tree.node.right))<=1)
                
bst = BST()
bst.insert_multiple(bst_values)

balanced = bst.is_balanced(bst)

                
                

## 5. Maintaining a Balance (Part 1) ##

class BST(BaseBST):
    
    def left_rotate(self):
        old_node = self.node
        new_node = self.node.right.node
        if not new_node:
            return
        
        right_sub = new_node.left.node
        self.node = new_node
        old_node.right.node = right_sub
        new_node.left.node = old_node
        
    def right_rotate(self):        
        old_node = self.node
        new_node = self.node.left.node
        if not new_node:
            return
        
        left_sub = new_node.right.node
        self.node = new_node
        old_node.left.node = left_sub
        new_node.right.node = old_node

bst = BST()
bst.insert_multiple(bst_values)

bst.left_rotate()
left_balanced = bst.is_balanced()

bst.right_rotate()
right_balanced = bst.is_balanced()

print(bst.inorder(bst))






## 7. Maintaining a Balance (Part 3) ##

class BST(BaseBST):
    
    def insert(self,value):
        node = Node(value=value)
        
        if not self.node:
            self.node = node
            self.node.left = BST()
            self.node.right = BST()
            return
        
        if self.node.value > value:
            if self.node.left:
                self.node.left.insert(value)
            else:
                self.node.left.value = node   
                
        else:
            if self.node.right:
                self.node.right.insert(value)
            else:
                self.node.right = node
                
        difference = self.depth(self.node.left.node)-self.depth(self.node.right.node)
        
        if difference > 1:
            if value > self.node.right.node.value:
                self.node.left.left_rotate()
            
            self.right_rotate()
            
        if difference < - 1:
            if value <= self.node.left.node.value:
                self.node.left.right_rotate()
                
            self.left_rotate()

bst = BST()

bst.insert_multiple(bst_values)
inorder = bst.inorder(bst)

is_bst_balanced = bst.is_balanced()





## 8. Enhancing the Node and BST Class ##

class BST(BaseBST):
    def __init__(self, index=None):
        self.node = None
        self.index = index
    
    def insert(self, value=None):
        key = value
        if self.index:
            key = value[self.index]
        
        node = Node(key=key, value=value)
        
        if not self.node:
            self.node = node
            self.node.left = BST(index=self.index)
            self.node.right = BST(index=self.index)
            return
        
        if key > self.node.key:
            if self.node.right:
                self.node.right.insert(value=value)
            else:
                self.node.right.node = node
        else:
            if self.node.left:
                self.node.left.insert(value=value)
            else:
                self.node.left.node = node
        
        difference = self.depth(self.node.left.node) - self.depth(self.node.right.node)
        
        # Left side case.
        if difference > 1:
            # Left-right case.
            if value > self.node.right.node.value:
                self.node.left.left_rotate()
            # Left-left case.
            self.right_rotate()
            
        # Right side case.
        if difference < -1:
            # Right-left case.
            if value <= self.node.left.node.value:
                self.node.left.right_rotate()
            self.left_rotate()

    def search(self,key):
        if not self.node:
            return False
        
        if key == self.node.key:
            return True
        
        if tree.node.value == value:
            return True
        
        if self.node.key > key:
            return self.node.left.search(key)
        
        if self.node.key < value:
            return self.node.right.search(key)
 
            
    
bst = BST()
bst.insert_multiple(bst_values)
inorder = bst.inorder(bst)

bst_list = BST(index=2)
bst_list.insert_multiple(bst_list_values)
inorder_list = bst.inorder(bst_list)


## 9. Adding the Range Query ##

class BST(BaseBST):
    
    def greater_than(self,key):
            if not self.node:
                return list()
            
            values=list()
            
            if self.node.left:
                values += self.node.left.greater_than(key)
            
            if self.node.right:
                values += self.node.right.greater_than(key)
                
            if self.node.key > key:
                values.append(self.node.value)
            
            return values
    
bst = BST()
bst.insert_multiple(bst_values)
greater = bst.greater_than(5)

bst_list = BST(2)
bst_list.insert_multiple(bst_list_values)
greater_list = bst_list.greater_than(5)




## 10. Range Querying a CSV ##

import csv

with open('amounts.csv','r') as f:
    next(f)
    amount_rows = [(col[0],float(col[1])) for col in csv.reader(f)]

bst = BST(1)  
bst.insert_multiple(amount_rows)                                 
                                 
csv_query = bst.greater_than(10)
                                 
print(csv_query)                                 
    
                                 