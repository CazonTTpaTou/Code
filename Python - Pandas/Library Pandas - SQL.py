
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd


# In[2]:


# On peut créer une Series à partir d'une list
data = pd.Series([0.25, 0.5, 0.75, 1.0])
print("data ressemble à un tableau Numpy: ", data)


# In[3]:


# On peut spécifier des indices à la main
data = pd.Series([0.25, 0.5, 0.75, 1.0],
         index=['a', 'b', 'c', 'd'])
print("data ressemble à un dict en Python: ", data)
print(data['b'])


# In[6]:


# On peut même créer une Serie directement à partir d'une dict
population_dict = {'California': 38332521,
                   'Texas': 26448193,
                   'New York': 19651127,
                   'Florida': 19552860,
                   'Illinois': 12882135}
area_dict = {'California': 423967, 
             'Texas': 695662,
             'New York': 141297, 
             'Florida': 170312,
             'Illinois': 149995}
population = pd.Series(population_dict)
area = pd.Series(area_dict)
print(population)
print(area)


# In[7]:


# Que pensez vous de cette ligne?
print(population['California':'Illinois'])


# In[8]:


# A partir d'une Series
df = pd.DataFrame(population, columns=['population'])
print(df)


# In[9]:


# A partir d'une list de dict
data = [{'a': i, 'b': 2 * i}
        for i in range(3)]
df = pd.DataFrame(data)
print(df)


# In[10]:


# A partir de plusieurs Series
df = pd.DataFrame({'population': population,
              'area': area})
print(df)


# In[11]:


# A partir d'un tableau Numpy de dimension 2
df = pd.DataFrame(np.random.rand(3, 2),
             columns=['foo', 'bar'],
             index=['a', 'b', 'c'])
print(df)


# In[12]:


# Une fonction pour générer facilement des DataFrame - Elle nous sera utile dans la suite de ce chapitre...
def make_df(cols, ind):
    """Crée rapidement des DataFrame"""
    data = {c: [str(c) + str(i) for i in ind]
            for c in cols}
    return pd.DataFrame(data, ind)
# exemple
make_df('ABC', range(3))


# In[13]:


data = pd.Series([0.25, 0.5, 0.75, 1.0],
                 index=['a', 'b', 'c', 'd'])
print(data)
# On peut désigner un élément d'une Series par son index
print(data.loc['b'])
# Ou bien par sa position
print(data.iloc[1])


# In[14]:


data = pd.DataFrame({'area':area, 'pop':population})
print(data)
data.loc[:'Illinois', :'pop']


# In[15]:


ser1 = pd.Series(['A', 'B', 'C'], index=[1, 2, 3])
ser2 = pd.Series(['D', 'E', 'F'], index=[4, 5, 6])
pd.concat([ser1, ser2])


# In[16]:


df1 = make_df('AB', [1, 2])
print(df1)
df2 = make_df('AB', [3, 4])
print(df2)
pd.concat([df1, df2])


# In[20]:


pd.concat([df1,df2],axis=1)


# In[23]:


df3 = make_df('CD',[1,2])
pd.concat([df1,df3],axis=1)


# In[24]:


x = make_df('AB', [0, 1])
y = make_df('AB', [2, 3])
y.index = x.index  # Rend les index identiques
# Nous avons alors des index dupliqués
print(pd.concat([x, y]))
# Nous pouvons spécifier des index hiérarchiques
hdf = pd.concat([x, y], keys=['x', 'y'])
print(hdf)


# In[25]:


hdf.loc[('x', 1),]


# In[29]:


df1 = pd.DataFrame({'employee': ['Bob', 'Jake', 'Lisa', 'Sue'],
                    'department': ['Accounting', 'Engineering', 'Engineering', 'HR']})
df2 = pd.DataFrame({'employee': ['Lisa', 'Bob', 'Jake', 'Sue'],
                    'date': [2004, 2008, 2012, 2014]})
print(df1)
print(df2)
df3 = pd.merge(df1, df2)
print(df3)


# In[35]:


df4 = pd.DataFrame({'emp_name': ['Lisa', 'Bob', 'Jake', 'Sue'],
                    'date': [2004, 2008, 2012, 2014]})

df5 = pd.merge(df1, df4, left_on= "employee", right_on= "emp_name")
print(df5)


# In[36]:


df6 = pd.DataFrame({'department': ['Accounting', 'Engineering', 'HR'],
                    'supervisor': ['Carly', 'Guido', 'Steve']})
pd.merge(df5, df6)


# In[38]:


df7 = pd.DataFrame({'department': ['Accounting', 'Accounting',
                              'Engineering', 'Engineering', 'HR', 'HR'],
                    'competence': ['math', 'spreadsheets', 'coding', 'linux',
                               'spreadsheets', 'organization']})
print(df7)


# In[39]:


pd.merge(df1,df7)


# In[40]:


df8 = pd.DataFrame({'employee': ['Bob', 'Jake', 'Lisa', 'Sue', 'Lea'],
                    'department': ['Accounting', 'Engineering', 'Engineering', 'HR', 'Engineering']})
df2 = pd.DataFrame({'employee': ['Lisa', 'Bob', 'Jake', 'Sue'],
                    'date': [2004, 2008, 2012, 2014]})


# In[41]:


pd.merge(df8,df2)


# In[42]:


pd.merge(df8,df2,how="left")


# In[43]:


pd.merge(df8,df2,how="right")


# In[44]:


pd.merge(df8,df2,how="outer")


# In[45]:


# Nous ajoutons une nouvelle colonne à df1 et df2, qui contient toujours
# la même valeur, ici 0.
df1['key'] = 0
df2['key'] = 0
print(df1)
print(df2)


# In[47]:


# La jointure plusieurs-à-plusieurs
produit_cartesien = pd.merge(df1, df2, on='key')
print(produit_cartesien)


# In[48]:


# Effaçons la colonne key qui n'est plus utile
produit_cartesien.drop('key',1, inplace=True)
print(produit_cartesien)


# In[49]:


pd.merge(df1.assign(key=0), df2.assign(key=0), on='key').drop('key', axis=1)


# In[52]:


rng = np.random.RandomState(42)
ser = pd.Series(rng.rand(5))
print(ser)


# In[53]:


print(ser.sum())
print(ser.mean())


# In[55]:


df = pd.DataFrame({'A': rng.rand(5),
                   'B': rng.rand(5)})            
print(df)
# Par colonne
print(df.mean())
# Par ligne
print(df.mean(axis='columns'))


# In[56]:


df0 = pd.DataFrame({'key': ['A', 'B', 'C', 'A', 'B', 'C'],
                   'data1': range(6),
                   'data2': [10,11,10,9,10,10]})                  
print(df0)


# In[59]:


gb = df0.groupby('key')


# In[60]:


print(gb.sum())
print(gb.mean())


# In[61]:


s = gb['data1','data2'].sum()
m = gb['data2',].mean()
print(s)
print(m)


# In[63]:


groupped = pd.concat([s,m], axis=1)
groupped.columns = ["data1_somme","data2_somme","data2_moyenne"]
print(groupped)


# In[66]:


print(groupped.sum(axis='columns'))

