## 1. Augmenting Pandas With SQLite ##

import sqlite3
import pandas as pd

conn = sqlite3.connect('moma.db')

for moma_iter in pd.read_csv('moma.csv',chunksize=1000):
    
    moma_iter.to_sql('exhibitions',conn,
                            if_exists='append',
                            index=False)
    
  


## 2. Pandas Types vs. SQLite Types ##

conn = sqlite3.connect('moma.db')

results_df = pd.read_sql('PRAGMA table_info(exhibitions);',conn)

print(result_df)




## 3. Setting Appropriate Types ##

conn = sqlite3.connect('moma.db')

for moma_iter in pd.read_csv('moma.csv',chunksize=1000):
    moma_iter['ExhibitionSortOrder']=moma_iter['ExhibitionSortOrder'].astype('int16')        
                
    moma_iter.to_sql('exhibitions',conn,
                            if_exists='append',
                            index=False)    
    
results_df = pd.read_sql('PRAGMA table_info(exhibitions);',conn)

print(results_df)




## 4. Computing Primarily in SQL ##

conn = sqlite3.connect('moma.db')

query = 'SELECT ExhibitionID,COUNT(*) AS counts FROM exhibitions GROUP BY ExhibitionID ORDER BY counts DESC;'

eid_counts = pd.read_sql(query,conn)

print(eid_counts.head(10))




## 5. Computing Primarily in Pandas ##

q = 'select exhibitionid from exhibitions;'

eid_df = pd.read_sql(q, conn)
eid_pandas_counts = eid_df['ExhibitionID'].value_counts()

print(eid_pandas_counts[:10])

## 6. Reading in SQL Results Using Chunks ##

import time
import sqlite3

conn = sqlite3.connect('moma.db')

for moma_iter in pd.read_csv('moma.csv',chunksize=1000):    
    moma_iter.to_sql('exhibitions',conn,
                            if_exists='append',
                            index=False)    

q = 'select exhibitionid from exhibitions;'

for size_chunk in [10,50,100,200,500,750,1000,2000,5000]:
    start = time.time()
    for moma_iter in pd.read_sql(q, conn,chunksize=size_chunk):

        eid_pandas_counts = eid_counts['ExhibitionID'].value_counts(dropna=False).sort_values(ascending=False)
        
    print('Size of chunk {} : Length = {}'.format(size_chunk,
                                                  round(time.time()-start,2)))
    
    
        
        