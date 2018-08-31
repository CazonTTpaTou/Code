
# coding: utf-8

# # Guided Project - Analyzing Startup Fundraising Deals from Crunchbase

# In[4]:


import pandas as pd
pd.options.display.max_columns = 99

data = pd.read_csv('crunchbase-investments.csv',
                   encoding='ISO-8859-1',
                   low_memory=False)
data.head(5)


# In[5]:


chunks = pd.read_csv('crunchbase-investments.csv',
                     encoding='ISO-8859-1',
                     chunksize=5000)

memory_col= dict()
missing_value = dict()

memory = list()

for index,chunk in enumerate(chunks):
    memory.append(chunk.memory_usage(deep=True).sum()/(1024*1024))
    
    if index==0:
        for col in chunk.columns.tolist():
            memory_col[col]=list()
            missing_value[col]=list()
    
    for col in chunk.columns.tolist():
        memory_col[col].append(chunk[col].memory_usage(deep=True)/(1024*1024))   
        missing_value[col].append(chunk[col].isna().sum())


# In[9]:


print('--'*15)    

for key,value in missing_value.items():
    print('Column {} - {} missing value(s)'.format(key,sum(value)))

print('--'*15)    
    
for key,value in memory_col.items():
    print('Column {} - Memory footprint {} MB'.format(key,round(sum(value),2)))

print('--'*15)    

print('Total Memory size : {} MB'.format(round(sum(memory),2)))


# ## Selecting Data Types

# In[16]:


col_types = list()

chunks = pd.read_csv('crunchbase-investments.csv',
                     encoding='ISO-8859-1',
                     chunksize=5000)

for index,chunk in enumerate(chunks):     
    if index==0:
        print(chunk.dtypes)
        col_types = chunk.columns.tolist()


# In[19]:


col_str_num = list()

for col in col_types:
    if col.endswith('_code'):
        col_str_num.append(col)
        


# In[23]:


chunks = pd.read_csv('crunchbase-investments.csv',
                     encoding='ISO-8859-1',
                     chunksize=5000)

for index,chunk in enumerate(chunks):    
    for col in col_str_num:
        try:
            chunk[col] = pd.to_numeric(chunk[col])
        except:
            pass
        


# In[24]:


chunks = pd.read_csv('crunchbase-investments.csv',
                     encoding='ISO-8859-1',
                     chunksize=5000)

candidates_category = list()

for index,chunk in enumerate(chunks):
    for col in chunk.columns.tolist():
        number_values_unique = len(chunk[col].unique())
        
        if number_values_unique <20:
            candidates_category.append(col)
            
category_cols = set(candidates_category)            

print(category_cols)


# In[25]:


convert_col_dtypes = dict()

for col in category_cols:
    convert_col_dtypes[col]='category'

chunks = pd.read_csv('crunchbase-investments.csv',
                     encoding='ISO-8859-1',
                     dtype=convert_col_dtypes, 
                     chunksize=5000)



# In[26]:


memory = list()

for index,chunk in enumerate(chunks):
    memory.append(chunk.memory_usage(deep=True).sum()/(1024*1024))
    
print('Total Memory size : {} MB'.format(round(sum(memory),2)))


# In[27]:


# Drop columns representing URL's or containing way too many missing values (>90% missing)
drop_cols = ['investor_permalink', 'company_permalink', 'investor_category_code']

chunks = pd.read_csv('crunchbase-investments.csv',
                     encoding='ISO-8859-1',
                     dtype=convert_col_dtypes, 
                     chunksize=5000)

for chunk in chunks:
    chunk = chunk.drop(columns=drop_cols)

#keep_cols = chunk.columns.drop(drop_cols)


# ## Loading Chunks into SQLite

# In[28]:


import sqlite3

conn =sqlite3.connect('crunchbase.db')

chunks = pd.read_csv('crunchbase-investments.csv',
                     encoding='ISO-8859-1',
                     dtype=convert_col_dtypes, 
                     chunksize=5000)

for chunk in chunks:
    
    chunk = chunk.drop(columns=drop_cols)
    
    for col in col_str_num:
        try:
            chunk[col] = pd.to_numeric(chunk[col])
        except:
            pass
        
    chunk.to_sql("investments",conn
                              ,index=False
                              ,if_exists='append')
    
    


# In[29]:


get_ipython().system("wc 'crunchbase.db'")


# ## Data Exploration and Analysis

# In[30]:


query = """
SELECT company_name,
        (SUM(raised_amount_usd)
        /(SELECT SUM(raised_amount_usd) FROM investments))
        AS Proportion
        FROM investments
        GROUP BY company_name
        ORDER BY Proportion DESC;
"""

top = pd.read_sql(query,conn)


# In[31]:


top


# In[38]:


query = """
SELECT company_category_code,
        SUM(raised_amount_usd)/1000000 AS invest 
        
        FROM investments
        
        GROUP BY company_category_code
        ORDER BY invest DESC;
"""

category_invest = pd.read_sql(query,conn)


# In[39]:


category_invest


# In[40]:


query = """
SELECT investor_name,
        SUM(raised_amount_usd)/1000000 AS invest 
        
        FROM investments
        
        GROUP BY investor_name
        ORDER BY invest DESC;
"""

investor = pd.read_sql(query,conn)


# In[41]:


investor


# In[43]:


query = """
SELECT *
        
        FROM investments
        
        ORDER BY raised_amount_usd DESC
        LIMIT 1;
"""

top_round = pd.read_sql(query,conn)


# In[44]:


top_round


# In[46]:


query = """
SELECT *
        
        FROM investments
        WHERE raised_amount_usd IS NOT NULL
        ORDER BY raised_amount_usd ASC
        LIMIT 1;
"""

worst_round = pd.read_sql(query,conn)


# In[47]:


worst_round

