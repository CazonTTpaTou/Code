
# coding: utf-8

# In[2]:


import pandas as pd


# In[3]:


import matplotlib as plt


# In[4]:


get_ipython().magic('matplotlib inline')


# In[5]:


recent_grads = pd.read_csv('recent-grads.csv')
recent_grads.iloc[0]


# In[6]:


recent_grads.iloc[2]


# In[7]:


recent_grads.tail(3)


# In[9]:


recent_grads.describe()


# In[12]:


raw_data_count = recent_grads.count().max()
raw_data_count


# In[13]:


recent_grads = recent_grads.dropna(axis=0)
clean_data_count = recent_grads.count().max()


# In[14]:


delta = raw_data_count - clean_data_count
delta


# In[15]:


recent_grads.plot(x='Sample_size', 
                  y='Employed', 
                  kind='scatter', 
                  title='Employed vs. Sample_size', 
                  figsize=(5,10))


# In[16]:


recent_grads.plot(x='Sample_size', 
                  y='Median', 
                  kind='scatter', 
                  title='Median vs. Sample_size', 
                  figsize=(5,10))


# In[17]:


recent_grads.plot(x='Full_time', 
                  y='Median', 
                  kind='scatter', 
                  title='Median vs. Full_time', 
                  figsize=(5,10))


# In[18]:


recent_grads.plot(x='ShareWomen', 
                  y='Unemployment_rate', 
                  kind='scatter', 
                  title='ShareWomen vs. Unemployment_rate', 
                  figsize=(5,10))


# In[19]:


recent_grads.plot(x='Men', 
                  y='Median', 
                  kind='scatter', 
                  title='Men vs. Median', 
                  figsize=(5,10))


# In[20]:


recent_grads.plot(x='Women', 
                  y='Median', 
                  kind='scatter', 
                  title='Women vs. Median', 
                  figsize=(5,10))


# In[21]:


recent_grads['Sample_size'].plot(kind='hist')


# In[22]:


recent_grads['Sample_size'].hist(bins=25, range=(0,5000))


# In[23]:


recent_grads['Sample_size'].hist(bins=25, range=(0,5000))


# In[24]:


recent_grads['Median'].hist()


# In[25]:


recent_grads['Employed'].hist()


# In[26]:


recent_grads['Full_time'].hist()


# In[27]:


recent_grads['Unemployment_rate'].hist()


# In[28]:


recent_grads['Men'].hist()


# In[29]:


recent_grads['Women'].hist()


# In[31]:


#from pandas.plotting import scatter_matrix

pd.scatter_matrix(recent_grads[['Sample_size', 'Median']], figsize=(10,10))


# In[32]:


pd.scatter_matrix(recent_grads[['Sample_size', 'Median','Unemployment_rate']], figsize=(10,10))


# In[33]:


recent_grads[:5].plot.bar(x='Major', y='Women')


# In[34]:


recent_grads[:10]['ShareWomen'].plot(kind='bar')


# In[35]:


recent_grads[-10:]['ShareWomen'].plot(kind='bar')


# In[36]:


recent_grads[:10]['Unemployment_rate'].plot(kind='bar')


# In[38]:


recent_grads[-10:]['Unemployment_rate'].plot(kind='bar')


# In[6]:


recent_grads[-10:][['Women','Men']].plot(kind='bar')


# In[8]:


recent_grads[:10][['Women','Men']].plot(kind='bar')


# In[10]:


recent_grads[:10][['Women','Men']].sort_index().plot(kind='bar')


# In[16]:


recent_grads[:10][['Major','Median']].boxplot()


# In[18]:


recent_grads.plot(x='Major', 
                  y='Median', 
                  kind='box', 
                  title='Employed vs. Sample_size', 
                  figsize=(5,10))


# In[19]:


recent_grads.plot(x='Major', 
                  y='Unemployment_rate', 
                  kind='box', 
                  title='Employed vs. Sample_size', 
                  figsize=(5,10))


# In[23]:


recent_grads.plot(y='Unemployment_rate',
                  x='Median',
                  kind='hexbin', 
                  title='Employed vs. Sample_size', 
                  figsize=(5,10))

