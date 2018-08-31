
# coding: utf-8

# # Guided Project - Implementing a Key-Value Database

# ## Implement the Get and the Set

# In[66]:


from btree import NodeKey, Node, BTree 
import pickle


# In[94]:


class DQKV(BTree):
    
    def __init__(self,type_,values=None):
        self.type = type_
        super().__init__(10)
        
    def get(self,key):
        value = self.search(self.root,key)
        if not value:
            raise KeyError('There is no value for {}'.format(key))
        else:
            return value
    
    def set(self,key,value):
        
        if not value:
            raise ValueError('Value is null !!')
        
        if not isinstance(key,self.type):
            raise KeyError('Invalid type for the key {}'.format(key))
        
        exist = self.search(self.root,key)
        
        if exist:
            raise KeyError('{} already exist !!'.format(key))
        
        nodekey = NodeKey(key,value)
        self.insert(nodekey)

    def range_query(self,interval,inclusive=False):
        
        if not isinstance(interval,list):
            raise ValueError('{} is not a list interval'.format(interval))
        if len(interval)>2:
            raise ValueError('Interval should only have a inf and sup value')
        if interval[0] and interval[1]:
            if interval[0] > interval[1]:
                raise ValueError('Value inf should be inferior to value sup in the interval')
        if not interval[0] and  not interval[1]:
            raise ValueError('The 2 values in the interval are not defined')        
        if interval[0]:
            if not isinstance(interval[0],int):
                raise ValueError('Values inf in interval should be interger types !!')            
        if interval[1]:
            if not isinstance(interval[1],int):
                raise ValueError('Values sup in interval should be interger types !!')            
        
        
        inc = inclusive
        node = self.root    
        list_values = list()

        if interval[0] is None:
            list_values = self.less_than(node, interval[1], inclusive=inc)

        elif interval[1] is None:
            list_values = self.greater_than(node,interval[0],inclusive=inc)

        else:
            list_values = self.greater_than(node,interval[0],interval[1],inclusive=inc)

        return list_values

    def save(self,namefile):
        filename = namefile + '.dqdb'
        
        with open(filename,'wb') as f:
            pickle.dump(self,f)
            return True
        
        return False

    @staticmethod
    def load(namefile):
        filename = namefile + '.dqdb'
        
        with open(filename,'rb') as f:
            return pickle.load(f)
        
        return False
    
    def set_from_dict(self,dictionnary):
        if not isinstance(dictionnary,dict):
            raise ValueError('Data in entry is not adictionnary !!')
            
        for key,value in dictionnary.items():
            self.set(key,value)
    


# In[95]:


dq = DQKV(int)

dq.set(1,'Hello')
dq.set(2,'World')
dq.set(3,'ABC')


# In[96]:


try :
    trial = dq.get(3)
    trial2 = dq.get(5)
    
except KeyError as e:
    print(e)

try :
    dq.set(2,'Morning')

except KeyError as e:
    print(e)
    
print(trial)


# ## Override the Initializer

# In[97]:


try:
    dq.set('a','Surprise !!')
except KeyError as e:
    print(e)
    


# ## Reimplementing the range Queries

# In[98]:


dq.set(9,'Hello')
dq.set(10,'World')
dq.set(11,'ABC')

dq.set(-9,'Croco')
dq.set(-10,'Alligator')
dq.set(-11,'Gavial')


# In[99]:


list1 = dq.range_query([0,5],True)
list2 = dq.range_query([6,None])
list3 = dq.range_query([None,6])


# In[100]:


list1


# In[101]:


list2


# In[102]:


list3


# ## Dump and load the KV Store

# In[103]:


saving = dq.save('MyFile')


# In[104]:


saving


# In[105]:


loading = DQKV.load('MyFile')


# In[106]:


loading


# ## Load from dictionnary

# In[107]:


dico = {20:'Gazelle',
        21:'Hippopotame',
        22:'Lion',
        23:'Cactus'}

dq.set_from_dict(dico)

query1 = dq.get(20)
query2 = dq.get(23)

list4 = dq.range_query([6,None])


# In[108]:


query1


# In[109]:


query2


# In[110]:


list4

