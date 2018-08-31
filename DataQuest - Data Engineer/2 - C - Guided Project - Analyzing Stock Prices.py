
# coding: utf-8

# #  Guided Project - Analyzing Stock Prices 

# ## Stock Price Data

# In[1]:


from concurrent.futures import ThreadPoolExecutor
import csv
import os

stock_price = dict()

def reading_file(name):
    filename='/'.join(['prices',name])
    with open(filename,'r',encoding='utf-8') as f:
        next(f)
        data = list(csv.reader(f))
        return (name,data)

list_file = os.listdir('prices')        
        
with ThreadPoolExecutor(max_workers=5) as pool:
    list_data = list(pool.map(reading_file,list_file))
    
for item in list_data:
    name=item[0][:-4]
    stock_price[name] = item[1]
        


# In[2]:


columns = ['date', 'close', 'open', 'high', 'low', 'volume']
companies = list(stock_price.keys())


# In[3]:


companies[:10]


# In[4]:


stock_price['aapl']


# ## Computing Aggregates

# In[14]:


dict_stock_price = dict()

for key,value in stock_price.items():
    dict_company = dict()
    
    
    dict_company[columns[0]] = [row[0] for row in value] 
    
    for col in columns[1:]:
        index = columns.index(col)
        dict_company[col] = [float(row[index]) for row in value] 
    
    dict_stock_price[key] = dict_company

dict_stock_price['aapl']    


# In[15]:


import statistics

columns


# In[21]:


dict_stats_company = dict()

for key,value in dict_stock_price.items():   
    stats_company = dict()
    
    for col in columns[1:]:
        stats=dict()
        
        stats['mean']= statistics.mean(value[col])        
        stats['stdev']= statistics.stdev(value[col])
        stats['median']= statistics.median(value[col])
        stats['median_grouped']= statistics.median_grouped(value[col])
        
        stats_company[col]=stats
    
    dict_stats_company[key]=stats_company
    


# In[22]:


columns[1:]


# In[23]:


dict_stats_company


# In[28]:


stats_sort = sorted(dict_stats_company.keys(),
                    key=(lambda x:dict_stats_company[x]['close']['mean']),
                    reverse=True)


# In[29]:


stats_sort


# In[30]:


for index,company in enumerate(stats_sort):
    print('{} {} : {}'.format(index,
                              company,
                              round(dict_stats_company[company]['close']['mean'],2)))   
    


# ## Finding the most traded stock each day

# In[37]:


liste_day_stock = list()
dict_day_stock = dict()

for key,value in dict_stock_price.items():
    for date,volume in zip(value['date'],value['volume']):
        liste_day_stock.append(tuple((key,date,volume)))

for tup in liste_day_stock:
    row=tuple((tup[0],tup[2]))
    try:
        dict_day_stock[tup[1]].append(row)
    except:
        dict_day_stock[tup[1]] = row

dict_day_stock        


# In[ ]:


day_stock_volume = dict()

for key,value in dict_day_stock.items():
    

