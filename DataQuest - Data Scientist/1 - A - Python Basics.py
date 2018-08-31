
# coding: utf-8

# In[26]:


f = open('births.csv')
data = f.read()
data


# In[27]:


rows=data.split('\n')
print(rows)


# In[28]:


for row in rows:
    row.split(',')
    print(row)
    


# In[29]:


for row in rows:
    row.split(',')


# In[30]:


dictionnaire = {}
rows=rows[1:]

for row in rows:    
    day_of_week = row.split(',')[3]
    #print(day_of_week)
    if day_of_week in dictionnaire:
        dictionnaire[day_of_week] +=1
    else:
        dictionnaire[day_of_week] =1
        
print(dictionnaire)        
    


# ## Nombre d'entrées du dictionnaire

# In[31]:


len(dictionnaire)


# * candy
# * gum
# * goose

# 1. Red
# 2. Blue
# 3. Green

# Here is an example link : [AMAZON][TITLE]
# [TITLE]: http://amazon.fr/
