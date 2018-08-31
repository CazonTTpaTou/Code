
# coding: utf-8

# # Analyse Pandas - Agrégation de données

# ## Mécanisme Group By

# In[1]:


from pandas import DataFrame,Series
import numpy as np
import pandas as pd

df = DataFrame({'key1':['a','a','b','b','a'],
               'key2':['one','two','one','two','one'],
               'data1':np.random.randn(5),
               'data2':np.random.randn(5)})


# In[2]:


df


# In[4]:


grouped = df['data1'].groupby(df['key1'])
grouped


# In[5]:


grouped.mean()


# In[6]:


grouped = df['data1'].groupby([df['key1'],df['key2']]).mean()
grouped


# In[7]:


grouped.unstack()


# In[8]:


df.groupby(['key1','key2']).mean()


# In[9]:


df.groupby(['key1','key2']).size()


# In[10]:


for name,group in df.groupby('key1'):
    print(name)
    print(group)


# In[11]:


for (k1,k2),group in df.groupby(['key1','key2']):
    print(k1,k2)
    print(group)


# In[14]:


piece = df.groupby('key1')
list(piece)


# In[17]:


pieces = dict(list(df.groupby('key1')))
pieces


# In[18]:


pieces['b']


# In[19]:


type(pieces['b'])


# In[23]:


df.groupby(['key1','key2'])[['data2']].mean()


# In[25]:


df = DataFrame(np.random.randn(5,5),
               columns=['a','b','c','d','e'],
               index=['Joe','Alligator','Crocodile','Gavial','Caiman'])


# In[26]:


df


# In[27]:


# Regroupe par taille du label de l'index
df.groupby(len).sum()


# In[30]:


colonne = pd.MultiIndex.from_arrays([['US','US','US','JP','JP',],
                                   [1,3,5,1,3]],
                                   names=['cty','tenor'])
hier = DataFrame(np.random.randn(4,5),columns=colonne)
hier


# ## Agrégation de données

# In[36]:


hier.groupby(level='cty',axis=1).quantile(0.9)


# In[39]:


hier.groupby(level='tenor',axis=1).quantile(0.9)


# In[42]:


hier.groupby(by=hier.index,axis=0).quantile(0.9)


# In[47]:


filePath = r'E:\Data\CodesDivers\pydata-book-2nd-edition\examples\tips.csv'
tips = pd.read_csv(filePath)
tips['tip_pct'] = tips['tip']/tips['total_bill']
tips.head(3)


# In[49]:


grouped = tips.groupby(['time','smoker'])
grouped_pct=grouped['tip_pct']
grouped_pct.agg('mean')


# In[50]:


grouped_pct.mean()


# In[51]:


def peak_to_peak(arr):
    return arr.max() - arr.min()


# In[52]:


grouped_pct.agg(['mean','std',peak_to_peak])


# In[54]:


grouped_pct.agg([('amplitude',peak_to_peak),('écart-type',np.std)])


# In[58]:


functions = ['count','mean',('amplitude',peak_to_peak)]
result = grouped['tip_pct','total_bill'].agg(functions)
result


# ## Transform et Apply

# In[59]:


df = DataFrame(np.random.randn(5,5),
               columns=['a','b','c','d','e'],
               index=['Joe','Alligator','Crocodile','Gavial','Caiman'])
df


# In[60]:


key = ['one','two','one','two','one']


# In[61]:


df.groupby(key).mean()


# In[62]:


df.groupby(key).transform(np.mean)


# In[64]:


def reduction(arr):
    return arr - arr.mean()

df.groupby(key).transform(reduction)


# In[65]:


reduit = df.groupby(key).transform(reduction)
reduit.groupby(key).mean()


# ## Fonction Apply

# In[67]:


def top(df,n=5,column='tip_pct'):
    return df.sort_values(by=column)[-n:]

top(tips,n=2)


# In[68]:


tips.groupby('smoker').apply(top)


# In[69]:


tips.groupby(['smoker','day']).apply(top,n=1,column='total_bill')


# In[70]:


result = tips.groupby('smoker')['tip_pct'].describe()


# In[72]:


result.unstack()


# In[73]:


f = lambda x: x.describe()
grouped.apply(f)


# ## Analyse par tranche

# In[75]:


factor = pd.cut(tips.total_bill,4)

def get_stats(group):
    return {'min':group.min(),
            'max':group.max(),
             'count':group.count(),
             'mean':group.mean()}

grouped = tips.tip.groupby(factor)
grouped.apply(get_stats).unstack()


# ## Moyenne pondérée

# In[78]:


groupeds = tips.groupby('day')[['total_bill','tip_pct']]


# In[80]:


moy_pondere = lambda g: np.average(g['total_bill'],weights=g['tip_pct'])


# In[81]:


groupeds.apply(moy_pondere)


# In[86]:


groupeds.agg([('Moyenne',np.mean)])


# In[87]:


corr = lambda g: g.corrwith(g['tip_pct'])


# In[93]:


grouped_cor = tips.groupby(['smoker','day','time'])[['total_bill','tip','size','tip_pct']]


# In[98]:


grouped_cor.apply(corr)


# ## Tables pivot

# In[100]:


tips.pivot_table(index=['day','smoker'])


# In[101]:


tips.pivot_table(index=['smoker','day'])


# In[102]:


tips.pivot_table(values=['tip_pct','size'],index=['day','time'],columns='smoker')


# In[103]:


tips.pivot_table(values=['tip_pct','size'],index=['day','time'],columns='smoker',margins=True)


# In[106]:


# Fréquence
tips.pivot_table(values=['tip_pct','size'],index=['day','time'],columns='smoker',margins=True,aggfunc=len)


# In[107]:


# Somme
tips.pivot_table(values=['size'],index=['smoker'],columns='day',margins=True,aggfunc=sum,fill_value=0)


# In[108]:


pd.crosstab(tips.smoker,tips.day,margins=True)

