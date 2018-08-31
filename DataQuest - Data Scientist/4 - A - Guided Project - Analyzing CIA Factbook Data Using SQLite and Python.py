
# coding: utf-8

# In[1]:


import sqlite3
import pandas as pd

conn = sqlite3.connect("factbook.db")


# In[2]:


q = "SELECT * FROM sqlite_master WHERE type='table';"
pd.read_sql_query(q, conn)


# In[3]:


query = "SELECT * FROM facts LIMIT 5"

pd.read_sql_query(query, conn)


# In[4]:


query_min = "Select min(population) from facts"
query_max = "Select max(population) from facts"
query_min_growth="Select min(population_growth) from facts"
query_max_growth="Select max(population_growth) from facts"


# In[5]:


pd.read_sql_query(query_min,conn)


# In[6]:


pd.read_sql_query(query_max,conn)


# In[7]:


pd.read_sql_query(query_min_growth,conn)


# In[8]:


pd.read_sql_query(query_max_growth,conn)


# In[9]:


query_max_pop = "Select Name from facts where population = (Select max(population) from facts)"
query_min_pop = "Select Name from facts where population = (Select min(population) from facts)"


# In[10]:


pd.read_sql_query(query_max_pop,conn)


# In[11]:


pd.read_sql_query(query_min_pop,conn)


# In[12]:


query_outliers = "select * from facts "
query_outliers += "where population != (Select max(population) from facts)"
query_outliers += "and population != (Select min(population) from facts)"


# In[19]:


world_data = pd.read_sql_query(query_outliers,conn)


# In[50]:


import matplotlib.pyplot as plt
import numpy as np
get_ipython().magic('matplotlib inline')

fig = plt.figure(figsize=(20,20))

ax1 = fig.add_subplot(2,2,1)
ax2 = fig.add_subplot(2,2,2)
ax3 = fig.add_subplot(2,2,3)
ax4 = fig.add_subplot(2,2,4)

abscisse = np.arange(0,world_data['population'].count(),1)

graphs = ['population','population_growth','birth_rate','death_rate']
axes = [ax1,ax2,ax3,ax4]

for graph,axe in zip(graphs,axes):
    
    axe.hist(world_data[graph].dropna())
    axe.set_xlabel(graph)
plt.show()


# In[51]:


query_outliers = "select population,population_growth,birth_rate,death_rate from facts "
query_outliers += "where population != (Select max(population) from facts)"
query_outliers += "and population != (Select min(population) from facts)"


# In[52]:


world_data = pd.read_sql_query(query_outliers,conn)


# In[62]:


import seaborn
get_ipython().magic('matplotlib inline')

fig = plt.figure(figsize=(10,10))
ax = fig.add_subplot(111)

world_data.hist(ax=ax)
plt.show()


# In[64]:


query_outliers = "select population/area_land as density from facts "
query_outliers += "where population != (Select max(population) from facts)"
query_outliers += "and population != (Select min(population) from facts)"

world_data = pd.read_sql_query(query_outliers,conn)


# In[66]:


import seaborn
get_ipython().magic('matplotlib inline')

fig = plt.figure(figsize=(10,10))
ax = fig.add_subplot(111)

world_data.hist(ax=ax,color='red')
plt.show()


# In[71]:


query_outliers = "select name, cast(area_water as float)/cast(area_land as float) as water_land_ratio from facts "
query_outliers += "where population != (Select max(population) from facts)"
query_outliers += "and population != (Select min(population) from facts)"
query_outliers += " order by water_land_ratio DESC"

world_data = pd.read_sql_query(query_outliers,conn)


# In[72]:


world_data


# In[74]:


query_outliers = "select name, cast(area_water as float)/cast(area_land as float) as water_land_ratio from facts "
query_outliers += "where (cast(area_water as float)/cast(area_land as float)) > 1 "
query_outliers += " order by water_land_ratio DESC"

world_data = pd.read_sql_query(query_outliers,conn)


# In[75]:


world_data

