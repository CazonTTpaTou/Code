
# coding: utf-8

# # Analyse Pandas - Manipulation données

# ## Fusion de dataframes

# In[8]:


from pandas import DataFrame
import pandas as pd


# In[15]:


df1 = DataFrame({'key':['b','b','a','c','a','a','b'],
               'data1':range(7)})


# In[16]:


df1


# In[18]:


df2 = DataFrame({'key':['a','b','d'],
               'data2':range(3)})
df2


# In[19]:


pd.merge(df1,df2,on='key')


# In[13]:


df3 = DataFrame({'key1':['b','b','a','c','a','a','b'],
               'data1':range(7)})

df4 = DataFrame({'key2':['a','b','d'],
               'data2':range(3)})

pd.merge(df3,df4,left_on='key1',right_on='key2')


# In[20]:


# Jointure outer
pd.merge(df1,df2,how='outer')


# In[21]:


# Jointure externe gauche
pd.merge(df1,df2,how='left')


# In[22]:


# Jointure externe droite
pd.merge(df1,df2,how='right')


# In[23]:


# Jointure interne
pd.merge(df1,df2,how='inner')


# In[26]:


# Jointure interne
pd.merge(df1,df2,on='key',how='outer',suffixes=('_left','_right'))


# ## Index

# In[28]:


left1 = DataFrame({'key':['a','b','a','a','b','c'],
                  'value':range(6)})


# In[29]:


right1 = DataFrame({'group_val':[3.5,7]},index=['a','b'])


# In[30]:


pd.merge(left1,right1,left_on='key',right_index=True)


# In[34]:


left2 = DataFrame({'group_val2':[8,9]},index=['a','b'])


# In[35]:


left2.join(right1,how='outer')


# In[36]:


left2.join(left1,how='outer')


# ## Concaténer le long d'un axe

# In[42]:


import numpy as np
from pandas import Series

arr = np.arange(12).reshape(3,4)


# In[40]:


np.concatenate([arr,arr],axis=1)


# In[44]:


s1 = Series([0,1],index=['a','b'])
s2 = Series([2,3,4],index=['c','d','e'])
s3 = Series([5,6],index=['f','g'])


# In[46]:


pd.concat([s1,s2,s3])


# In[47]:


pd.concat([s1,s2,s3],axis=1)


# In[48]:


s4 = pd.concat([s1*5,s3])
s4


# In[49]:


pd.concat([s1,s4],axis=1,join='inner')


# In[51]:


result = pd.concat([s1,s2,s3],keys=['one','two','three'])
result


# In[52]:


result.unstack()


# In[53]:


result2 = pd.concat([s1,s2,s3],axis=1,keys=['one','two','three'])
result2


# In[54]:


result3 = pd.concat({'level1':result2,'level2':result2},axis=1)
result3


# In[55]:


result4 = pd.concat({'level1':result2,'level2':result2},axis=0)
result4


# In[56]:


result5 = pd.concat({'level1':result2,'level2':result2},axis=1,ignore_index=True)
result5


# In[57]:


result3['level1']


# In[58]:


result3['level1']['two']


# In[63]:


result3.loc['b']


# In[64]:


result3.loc['b']['level1']


# In[65]:


result3.loc['b']['level1']['two']


# ## Combinaison avec superposition

# In[66]:


s5 = Series([2,3,4,np.nan,np.nan],index=['c','d','e','a','b'])
s6 = Series([2,np.nan,np.nan,3,4],index=['c','d','e','a','b'])
np.where(pd.isnull(s5),s6,s5)


# In[67]:


s6.combine_first(s5)


# ## Faire pivoter

# In[68]:


result3


# In[69]:


result3.unstack()


# In[70]:


result3.stack()


# In[71]:


result3.stack().unstack()


# ## Doublons

# In[72]:


data = DataFrame({'k1':['one']*3+['two']*4,
                 'k2':[1,1,2,3,3,4,4]})
data


# In[73]:


data.duplicated()


# In[74]:


data.drop_duplicates()


# In[75]:


data['v1']=range(7)
data


# In[76]:


data.drop_duplicates()


# In[77]:


data.drop_duplicates(['k1'])


# In[78]:


data.drop_duplicates(['k1','k2'])


# ## Fonction Map

# In[80]:


conversion = {'one':'four','two':'height','three':'twelve'}
data['k1'].map(conversion).map(str.upper)


# In[81]:


data['k1'].map(lambda x:str.upper(conversion[x]))


# In[82]:


data.replace(2,7)


# In[88]:


data2 = data.copy()
data2.index = data.index.map(lambda x:2*x)
data2


# ## Discretisation

# In[90]:


ages = [20,22,25,27,21,23,37,31,61,45,41,32]
bins=[18,25,35,60,100]
cats=pd.cut(ages,bins)
cats


# In[91]:


pd.value_counts(cats)


# In[94]:


cats.codes


# In[102]:


datas=np.random.randn(20)
datas


# In[104]:


categ=pd.qcut(datas,4)
categ


# In[105]:


categ.codes


# In[107]:


categ.value_counts()


# ## Filtrer

# In[109]:


np.random.seed(12345)
datass = DataFrame(np.random.randn(1000,4))
datass.describe()


# In[111]:


col = datass[3]
col[np.abs(col) >3]


# In[115]:


datass[(np.abs(datass)>3).any(1)]


# ## Permutations et échantillons

# In[123]:


sampler = np.random.permutation(5)
sampler


# In[124]:


df= DataFrame(np.arange(5*4).reshape(5,4))
df


# In[125]:


df.take(sampler)


# In[127]:


# Echantillon avec remise
samplers = np.random.randint(0,len(df),len(df)*2)


# In[128]:


draws=df.take(samplers)


# In[129]:


draws


# ## Calcul indicateur variables vides

# In[130]:


data


# In[132]:


pd.get_dummies(data['k1'])


# In[134]:


dummies = pd.get_dummies(data['k1'],prefix='k1')
dummies


# In[135]:


df_with_dummy = data.iloc[:,1:].join(dummies)
df_with_dummy


# In[136]:


values = np.random.rand(10)
values


# In[137]:


bins=[0,0.2,0.4,0.6,0.8,1]
pd.get_dummies(pd.cut(values,bins))

