
# coding: utf-8

# # Spark SQL

# In[ ]:


# Find path to PySpark.
import findspark
findspark.init()


# In[2]:


# Import PySpark and initialize SparkContext object.
import pyspark
sc = pyspark.SparkContext()


# In[10]:


# Read `recent-grads.csv` in to an RDD.
path ='E:\\OneDrive\\Formation\\2018 - DataQuest\\Codes\\_Solutions-master'
file = 'recent-grads.csv'
file_path = '\\'.join([path,file])

f = sc.textFile(file_path)


# ## RDD Transformations

# In[11]:


# Slice data in lines
data = f.map(lambda line: line.split('\n'))


# In[6]:


data.take(5)


# In[21]:


s = ['2,2416,MINING AND MINERAL ENGINEERING,756,679,77,Engineering,0.101851852,7,640,556,170,388,85,0.117241379,75000,55000,90000,350,257,50']
for i in s:
    print(i)


# In[22]:


s[0]


# In[25]:


def Search_Job(line):
    id = line[0] 
    if 'ENGINEERING' in line[0]:
        yield id,'Good Job :'
        
good_jobs = data.flatMap(lambda x:Search_Job(x))  
    


# In[26]:


good_jobs.take(5)


# In[27]:


def naval_job(line):
    if 'naval' in line[0].lower():
        return True
    else:
        return False
    
sea_jobs = data.filter(lambda x:naval_job(x))    


# In[28]:


sea_jobs.take(5)


# ## RDD Actions

# In[29]:


data_count = data.count()
data_count


# In[31]:


data_collect = data.collect()[:3]
data_collect


# ## Transforming Dataset

# In[43]:


def return_id(line):
    data = line[0]
    if data[0]!='R':
        raw_data = data.split(',')
        return int(raw_data[0])
    
data_ids = data.map(lambda line:return_id(line))    


# In[45]:


list_data_ids = data_ids.collect()
list_data_ids[:5]


# In[46]:


real_text = data_ids.filter(lambda x:x is not None)

list_data_ids = real_text.collect()
list_data_ids[:5]


# ## Spark DataFrames

# In[62]:


import csv
with open(file_path,'r') as f:
    body=list(csv.reader(f))
            


# In[65]:


header = body[:1][0]
body = body[1:]


# In[47]:


# Import SQLContext
from pyspark.sql import SQLContext

# Pass in the SparkContext object `sc`
sqlCtx = SQLContext(sc)


# In[68]:


df = sqlCtx.read.csv(file_path,
                     header=True)


# In[69]:


print(type(df))


# In[50]:


df.printSchema()


# In[70]:


df.show(5)


# In[71]:


df.select('Major','Total','Men','Women').show()


# In[77]:


Major_2000 = df[df['Total']>2000]
Major_2000.select('Major','Total','Men','Women').show(5)


# In[83]:


Female = df[df['Women']>=df['Men']].select('Major','Total','Men','Women').show(5)
Female


# In[86]:


pandas_df = df.toPandas()


# In[99]:


def Men_Women(line):
    if line['Women'] and line['Men']:
        if line['Women']>=line['Men']:
            return True
        else:
            return False
    else:
        return False

pandas_df = pandas_df.dropna()    
pandas_df['Egality']=pandas_df.apply(Men_Women,axis=1)


# In[100]:


pandas_df_women = pandas_df.where(pandas_df['Egality']==True)
pandas_df_women.head(3)


# In[101]:


from matplotlib import pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')

pandas_df['Total'].hist()
plt.show()


# ## Spark SQL

# In[110]:


# Import SQLContext
from pyspark.sql import SQLContext

# Pass in the SparkContext object `sc`
sqlCtx = SQLContext(sc)


# In[111]:


df = sqlCtx.read.csv(file_path,
                     header=True)


# In[112]:


df.registerTempTable('major_results')

tables = sqlCtx.tableNames()

print(tables)


# In[105]:


query = "SELECT women FROM major_results"
sqlCtx.sql(query).show()


# In[116]:


query = """SELECT men,women FROM major_results"""

df = sqlCtx.sql(query)

df.describe().show()


# In[ ]:


df1 = sqlCtx.read.csv(file_path,
                     header=True)

df2 = sqlCtx.read.csv(file_path,
                     header=True)

tables = sqlCtx.tableNames()


# In[ ]:


df1.registerTempTable('major1')
df2.registerTempTable('major2')

query = """SELECT 
                t1.total,
                t2.total
            FROM 
                major1 as t1
            INNER JOIN 
                major2 as t2
                ON t1.major_code = t2.major_code
            """


# In[ ]:


sqlCtx.sql(query).show()


# In[ ]:


df1.registerTempTable('major1')
df2.registerTempTable('major2')

query = """SELECT 
                SUM(t1.total),
                SUM(t2.total)
            FROM 
                major1 as t1
            INNER JOIN 
                major2 as t2
                ON t1.major_code = t2.major_code
            """


# In[ ]:


sqlCtx.sql(query).show()

