
# coding: utf-8

# In[2]:


import pandas as pd
pd.options.display.max_columns = 99


# ## Guided Project - Practice Optimizing Dataframes and Processing in Chunks

# In[4]:


data = pd.read_csv('loans_2007.csv',low_memory=False)
data.head(5)


# In[5]:


thousand_rows = pd.read_csv('loans_2007.csv',nrows=1000)
thousand_rows.memory_usage(deep=True)


# In[6]:


thousand_rows.memory_usage(deep=True).sum()


# In[7]:


thousand_rows.memory_usage(deep=True).sum()/(1024*1024)


# ## Exploring the data in chunk

# In[16]:


chunks = pd.read_csv('loans_2007.csv',chunksize=3000)

for index,chunk in enumerate(chunks):
    memory = chunk.memory_usage(deep=True).sum()/(1024*1024)
    number_rows = len(chunk)                                              
    print('Chunkn n° {} - Memory size : {}- Number of rows : {}'.format(index+1,round(memory,2),number_rows)) 


# In[20]:


chunks = pd.read_csv('loans_2007.csv',chunksize=3000)

for chunk in chunks:
    print(chunk.dtypes.value_counts())


# In[28]:


cols_unique_values = dict()

chunks = pd.read_csv('loans_2007.csv',chunksize=3000)

for chunk in chunks:
    cols_string = chunk.select_dtypes(include=['object']).columns.tolist()
    for col in cols_string :
        try:
            cols_unique_values[col].append(len(chunk[col].unique()))
        except:
            cols_unique_values[col] = list()
            cols_unique_values[col].append(len(chunk[col].unique()))
            
for cols in cols_unique_values.keys():
    print('--'*20)
    print(cols)
    print('--'*20)
    print(cols_unique_values[cols])
    print('--'*20)
    
        


# In[29]:


chunks = pd.read_csv('loans_2007.csv',chunksize=3000)

for index,chunk in enumerate(chunks):
    for col in chunk.columns.tolist():
        if chunk[col].isna().sum()>0:
            print('Chunk n° {} - Column {} - Missing values : {}'.format(index,
                                                                         col,
                                                                         chunk[col].isna().sum()))


# ## Optimizing String Columns

# In[36]:


chunks = pd.read_csv('loans_2007.csv',chunksize=3000)
candidates_category = list()

for index,chunk in enumerate(chunks):
    for col in chunk.columns.tolist():
        number_values_unique = len(chunk[col].unique())
        number_values = len(chunk[col])-chunk[col].isna().sum()
        ratio = round(number_values_unique / number_values,4)*100

        if ratio <0.1:
            candidates_category.append(col)
            
category_cols = set(candidates_category)            

print(category_cols)


# In[37]:


convert_col_dtypes = {
    "sub_grade": "category", "home_ownership": "category", 
    "verification_status": "category", "purpose": "category"
}


# In[41]:


chunks = pd.read_csv('loans_2007.csv',chunksize=3000)

for index,chunk in enumerate(chunks):
    chunk['int_rate'] = chunk['int_rate'].str.replace('%','').astype('float')
    chunk['int_rate'] = chunk['int_rate'].fillna(chunk['int_rate'].mean())
    print(round(chunk['int_rate'].mean(),2))
    


# ## Optimizing Numeric Columns

# In[43]:


chunk_iter = pd.read_csv('loans_2007.csv', 
                         chunksize=3000, 
                         dtype=convert_col_dtypes, 
                         parse_dates=["issue_d", "earliest_cr_line", "last_pymnt_d", "last_credit_pull_d"])

for chunk in chunk_iter:
    term_cleaned = chunk['term'].str.lstrip(" ").str.rstrip(" months")
    revol_cleaned = chunk['revol_util'].str.rstrip("%")
    chunk['term'] = pd.to_numeric(term_cleaned)
    chunk['revol_util'] = pd.to_numeric(revol_cleaned)
    
chunk.dtypes.sort_index()


# In[53]:


chunk_iter = pd.read_csv('loans_2007.csv', 
                         chunksize=3000, 
                         dtype=convert_col_dtypes, 
                         parse_dates=["issue_d", "earliest_cr_line", "last_pymnt_d", "last_credit_pull_d"])

missing_values = dict()
total_memory = list()

for chunk in chunk_iter:
    term_cleaned = chunk['term'].str.lstrip(" ").str.rstrip(" months")
    revol_cleaned = chunk['revol_util'].str.rstrip("%")
    chunk['term'] = pd.to_numeric(term_cleaned)
    chunk['revol_util'] = pd.to_numeric(revol_cleaned)
    
    memory = chunk.memory_usage(deep=True).sum()/(1024*1024)
    total_memory.append(memory)
    
    cols_float = chunk.select_dtypes(include='float')
    
    for col in cols_float:
        missing = chunk[col].isna().sum()
        try:
            missing_values[col]+=missing
        except:
            missing_values[col]=missing

print('Total Memory : {}'.format(round(sum(total_memory),2)))            
print('--'*20) 

for key,value in missing_values.items():
    print('{} : {} missing value(s)'.format(key,value))

