
# coding: utf-8

# # Démarrer avec pandas

# ## Structure de données

# In[14]:


from pandas import Series, DataFrame
import pandas as pd
import numpy as np


# In[4]:


obj = Series([4,7,-5,3])
obj


# In[5]:


obj.values


# In[6]:


obj.index


# In[7]:


obj2 = Series([4,7,-5,3],index=['d','b','a','c'])
obj2


# In[8]:


obj2['a']


# In[9]:


obj2[['a','c']]


# In[11]:


obj2[obj2>0]


# In[12]:


obj*2


# In[15]:


np.exp(obj2)


# In[16]:


'b' in obj2


# In[17]:


pd.isnull(obj2)


# In[18]:


obj2


# In[19]:


obj2.name='Trial'


# In[21]:


obj2.index.name='Entrepot'


# In[26]:


lis = []
lis = obj2.index.values
lis = 'Entrepot ' + lis
obj2.index = lis
obj2


# ## DataFrame

# In[27]:


data = {'State':['Ohio','Ohio','Ohio','Nevada','Nevada'],
        'Year':[2000,2001,2002,2001,2002],
        'pop':[1.5,1.7,3.6,2.4,2.9]}
frame = DataFrame(data)


# In[28]:


frame


# In[31]:


frame2 = DataFrame(data,
                   columns=['Year','State','pop','Debt'],
                   index=['one','two','three','four','five',])
frame2


# In[32]:


frame2.columns


# In[33]:


frame2['State']


# In[35]:


frame2.Year


# In[37]:


frame2.loc['three']


# In[39]:


frame2.Debt = np.arange(5)
frame2


# In[41]:


val = Series([-1.2,-1.5,-1.7],index=['two','four','five'])
frame2['New'] = float('nan')
frame2.New = val
frame2


# In[43]:


frame2['eastern'] = frame2.State == 'Ohio'
frame2


# In[45]:


del frame2['eastern']
frame2


# In[46]:


pop = {'Nevada':{2001:2.4,2002:2.9},'Ohio':{2000:1.5,2001:1.7,2002:3.6}}
frame3 = DataFrame(pop)
frame3


# In[47]:


frame3.T


# In[48]:


frame3.index.name='year'
frame3.columns.name='state'
frame3


# In[49]:


frame3.values


# ## Les index

# In[51]:


idx = frame.index
idx


# In[52]:


idx.is_monotonic


# In[53]:


idx.is_unique


# In[55]:


idx.isin(np.arange(0,5))


# In[57]:


obj = Series([4.5,7.2,-5.3,3.6],index=['d','b','a','c'])
obj


# In[60]:


obj.reindex(['a','b','c','d','e'],fill_value=0)


# In[62]:


obj3 = Series(['blue','purple','yellow'],index=[0,2,4])
obj3.reindex(range(6),method='ffill')


# In[63]:


obj3.reindex(range(6),method='bfill')


# In[73]:


obj4 = obj3.reindex(range(6),method='bfill')
obj5 = obj3.reindex(range(6),method='ffill')
frame = DataFrame(np.empty((6,2))*np.nan,index=range(6),columns=['Couleur1','Couleur2'])
frame


# In[74]:


frame.Couleur1 = obj3.reindex(range(6),method='bfill')
frame.Couleur2 = obj3.reindex(range(6),method='ffill')
frame


# In[76]:


couleurs = ['Couleur1','Couleur12','Couleur2']
frame.reindex(columns=couleurs)


# In[80]:


frame.reindex(index=['a','b','c','d','e','f'],columns=couleurs)


# In[81]:


frame.Couleur1 = obj3.reindex(range(6),method='bfill')
frame.Couleur2 = obj3.reindex(range(6),method='ffill')
frame


# ## Supprimer les entrées d'un axe

# In[83]:


newObj = frame.drop(5,axis=0)
newObj


# ## Sélectionner, filtrer

# In[85]:


newObj.loc[1:3,:]


# In[88]:


newObj.iloc[1]


# In[96]:


newObj.iloc[:,1]


# In[97]:


newObj.loc[:,'Couleur2']


# In[99]:


newObj.loc[newObj.Couleur1=='blue',:]


# In[102]:


newObj.loc[newObj.Couleur1=='blue','Couleur1']


# In[101]:


newObj.loc[:,newObj.iloc[1,:]=='blue']


# In[103]:


newObj.loc[1:3,newObj.iloc[1,:]=='blue']


# In[108]:


newObj.iloc[2,:]


# In[109]:


newObj.iloc[2,:][0]


# ## Fonctions Lambda

# In[122]:


frame = DataFrame(np.random.randn(4,3),
                  columns=list('bde'),
                  index=['Utah','Ohio','Texas','Oregon'])
frame


# In[123]:


f = lambda x: x.max() - x.min()


# In[124]:


frame.apply(f)


# In[125]:


frame.apply(f,axis=1)


# In[127]:


def f(x):
    return Series([x.min(),x.max()],index=['min','max'])


# In[128]:


frame.apply(f)


# In[129]:


frame.apply(f,axis=1)


# In[132]:


formatage = lambda x: '%.2f' % x


# In[133]:


frame.applymap(formatage)


# In[134]:


frame['e'].map(formatage)


# ## Trier et classer

# In[135]:


frame.sort_index(0)


# In[137]:


frame.sort_index(axis=1,ascending=False)


# In[139]:


obj = Series([4,np.nan,7,np.nan,-3,2])
obj.sort_values()


# In[141]:


frame.sort_values(by='b')


# In[143]:


frame.sort_values(by='d',ascending=False)


# In[144]:


frame.sort_values(by=['d','b'],ascending=[False,True])


# In[145]:


obj


# In[146]:


obj.rank()


# In[147]:


frame.rank(axis=0)


# In[148]:


frame.rank(axis=1)


# In[154]:


frame.loc['Floride']=[4,7,9]
frame


# In[156]:


frame.index.is_unique


# In[164]:


frame = frame.append(Series([5,5,5],index=frame.columns,name='Mississipi'))
frame


# In[166]:


frame = frame.drop('Mississipi')
frame


# In[167]:


frame = frame.append(Series([5,5,5],index=frame.columns,name='Mississipi'))
frame


# ## Cumul et statistiques descriptives

# In[168]:


frame.sum()


# In[169]:


frame.sum(axis=1)


# In[170]:


frame.mean(axis=1,skipna=False)


# In[172]:


frame.idxmax()


# In[173]:


frame.idxmax(axis=1)


# In[174]:


frame.cumsum()


# In[175]:


frame.cumsum(axis=1)


# In[176]:


frame.describe()


# In[178]:


frame.diff()


# ## Corrélation et covariance

# In[184]:


import pandas_datareader.data as web
from datetime import datetime
start = datetime(2017, 5, 9)
end = datetime(2017, 5, 24)

f = web.DataReader('F', 'iex', start, end)
f
#all_data = {}
#for ticker in ['AAPL','IBM','MSFT','GOOG']:
#    all_data[ticker] = pdr.get_data_yahoo(ticker,'1/1/2000','1/1/2010')


# In[188]:


f.loc['2017-05-22',:]


# In[189]:


f.volume.corr(f.high)


# In[190]:


f.corr()


# In[191]:


f.cov()


# ## Valeurs uniques

# In[192]:


objet = Series(['a','b','c','a','b','c','a','b','c','a','b','c'])


# In[197]:


uniques = objet.unique()
uniques.sort()
uniques


# In[198]:


objet.value_counts()


# In[200]:


mask = objet.isin(['b','c'])
mask


# In[206]:


data = DataFrame({'Ele1':[1,3,4,3,4],
                  'Ele2':[2,3,1,2,3],
                 'Ele3':[1,5,2,4,4],
                 'Ele4':[1,1,1,1,4]},
                 index=['Maths','Litterature','Informatique','Statistiques','Business'])
data


# In[207]:


data.Ele1.value_counts()


# In[209]:


result = data.apply(pd.value_counts)
result


# In[210]:


result = data.apply(pd.value_counts).fillna(0)
result


# ## Gérer les données manquantes

# In[211]:


string_data = Series(['a',np.nan,'c'])
string_data.isnull()


# In[212]:


string_data_na = string_data.dropna()
string_data_na


# In[213]:


string_data[string_data.notnull()]


# In[216]:


data = DataFrame([[1,2],[1,np.nan],[np.nan,np.nan]])
data


# In[217]:


data.dropna(how='all')


# In[218]:


data.dropna(axis=1,how='all')


# In[220]:


data.dropna(axis=1,thresh=2)


# ## Remplir les données manquantes

# In[221]:


data2 = DataFrame([[1,2,np.nan],[1,np.nan,3],[np.nan,np.nan,4],[np.nan,np.nan,np.nan]])
data2


# In[228]:


data2.fillna({0:0,1:-1,2:1})


# In[229]:


data3 = DataFrame([[1,2,np.nan],[1,np.nan,3],[np.nan,np.nan,4],[np.nan,np.nan,np.nan]])
data3


# In[231]:


data3.fillna(method='ffill',limit=2)


# In[234]:


data3.fillna(method='bfill')


# In[233]:


data3.fillna(data3.mean())


# ## Indexation hiérarchique

# In[237]:


data = Series(np.random.randn(10),
             index=[['a','a','a','b','b','b','c','c','d','d'],
                    [1,2,3,1,2,3,1,2,2,3]])


# In[238]:


data


# In[239]:


data.index


# In[240]:


data['b']


# In[241]:


data['b':'c']


# In[242]:


data[:,2]


# In[244]:


newFrame = data.unstack()
newFrame


# In[245]:


newFrame.stack()


# In[246]:


data.swaplevel(0,1)


# In[250]:


data.sort_index(level=0)


# In[251]:


data.sort_index(level=1)


# In[252]:


data.sum(level=0)


# In[253]:


data.sum(level=1)


# In[256]:


data.iloc[7]


# In[262]:


data3D = pd.Panel([[[1,2],[3,4]],[[5,6],[7,8]]])


# In[263]:


data3D


# In[264]:


data3D[0]


# In[265]:


data3D[1]


# In[266]:


data3D.iloc[:,1,:]


# In[269]:


stacked = data3D.to_frame()


# In[270]:


stacked


# In[271]:


stacked.to_panel()

