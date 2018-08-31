
# coding: utf-8

# # Analyse Pandas - Representations graphiques 

# ## MatplotLib

# In[2]:


from matplotlib import pyplot as plt
import numpy as np
import pandas as pd


# In[3]:


plt.plot(np.random.randn(50).cumsum(),'k--')


# In[5]:


fig = plt.figure()
ax1 = fig.add_subplot(2,2,1)
ax2 = fig.add_subplot(2,2,2)
ax3 = fig.add_subplot(2,2,3)
ax4 = fig.add_subplot(2,2,4)

ax1.plot(np.random.randn(50).cumsum(),'k--',color='red')
ax2.plot(np.random.randn(50).cumsum(),'k--',color='blue')
ax3.plot(np.random.randn(50).cumsum(),'k--',color='green')
ax4.plot(np.random.randn(50).cumsum(),'k--',color='purple')


# In[19]:


fig = plt.figure(figsize=(15,15))
ax1 = fig.add_subplot(2,2,1)
ax2 = fig.add_subplot(2,2,2)
ax3 = fig.add_subplot(2,2,3)
ax4 = fig.add_subplot(2,2,4)

ax1.plot(np.random.randn(50).cumsum(),linestyle='dashed',marker='o',color='red')
ax2.hist(np.random.randn(100),bins=20,alpha=0.3,color='blue')
ax3.scatter(np.arange(30),np.arange(30)+np.random.randn(30),color='blue')
ax4.plot(np.random.randn(50).cumsum(),'ko--',color='black')


# In[12]:


fig,axes = plt.subplots(2,2,sharex=True,sharey=True)
for i in range(2):
    for j in range(2):
        axes[i,j].hist(np.random.randn(500),bins=50,alpha=0.5)
plt.subplots_adjust(wspace=0.05,hspace=0.10)



# ## Etiquettes et légendes

# In[4]:


fig = plt.figure();
ax = fig.add_subplot(1,1,1)
ax.plot(np.random.randn(1000).cumsum())


# In[12]:


fig = plt.figure();
ax = fig.add_subplot(1,1,1)

ticks = ax.set_xticks([0,250,500,750,1000])
ax.plot(np.random.randn(1000).cumsum())


# In[13]:


fig = plt.figure();
ax = fig.add_subplot(1,1,1)

ticks = ax.set_xticks([0,250,500,750,1000])
labels = ax.set_xticklabels(['one','two','three','four','five'],rotation=30,fontsize='small')
ax.plot(np.random.randn(1000).cumsum())


# In[15]:


fig = plt.figure();
ax = fig.add_subplot(1,1,1)

ticks = ax.set_xticks([0,250,500,750,1000])
labels = ax.set_xticklabels(['one','two','three','four','five'],rotation=30,fontsize='small')
ax.set_title('My First Random March')
ax.set_xlabel('Stages')
ax.set_ylabel('Values')
ax.plot(np.random.randn(1000).cumsum(),color='red')


# In[17]:


fig = plt.figure();
ax = fig.add_subplot(1,1,1)

ticks = ax.set_xticks([0,250,500,750,1000])
ax.set_title('My First Random March')
ax.set_xlabel('Stages')
ax.set_ylabel('Values')
ax.plot(np.random.randn(1000).cumsum(),'k',color='red',label='one')
ax.plot(np.random.randn(1000).cumsum(),'k--',color='blue',label='two')
ax.plot(np.random.randn(1000).cumsum(),'k.',color='green',label='three')

ax.legend(loc='best')


# ## Annotations et dessin

# In[21]:


filePath = 'E:\Data\CodesDivers\pydata-book-2nd-edition\examples\spx.csv'

fig = plt.figure();
ax = fig.add_subplot(1,1,1)

ticks = ax.set_xticks([0,250,500,750,1000])
ax.text(150,10,'Hello World !!',family='monospace',fontsize=10)

ax.plot(np.random.randn(1000).cumsum())




# In[80]:


from datetime import datetime

filePath = 'E:\Data\CodesDivers\pydata-book-2nd-edition\examples\spx.csv'

fig = plt.figure(figsize=(12,12))
ax = fig.add_subplot(1,1,1)
ax.set_title('Dates importantes dans la crise financière 2008-2009')

data = pd.read_csv(filePath,index_col=0,parse_dates=True)
spx = data['SPX']
spxx = spx.iloc[4260:5300].dropna()

ax.plot(spxx.index,spxx.values)

#x = spxx.asof(datetime(2007,10,11))

crisis_data = [
    (datetime(2007,10,11),'Pic de la hausse boursière'),
    (datetime(2008,3,12),'Faillite de Bear Stearns'),
    (datetime(2008,9,15),'Banqueroute de Lehman'),    
]

for date,label in crisis_data:
    ax.annotate(label,xy=(date,spxx.asof(date)+25),
               xytext=(date,spxx.asof(date)+150),
               arrowprops=dict(facecolor='red'),
               horizontalalignment='left',verticalalignment='top')
    
ax.set_ylim([600,1800])
ax.set_xlim(['1/1/2007','1/1/2011'])


# In[82]:


fig= plt.figure()
ax = fig.add_subplot(1,1,1)

rect = plt.Rectangle((0.2,0.75),0.4,0.15,color='k',alpha=0.3)
circ = plt.Circle((0.7,0.2),0.15,color='b',alpha=0.3)
pgon = plt.Polygon([[0.15,0.15],[0.35,0.4],[0.2,0.6]],0.15,color='g',alpha=0.5)

ax.add_patch(rect)
ax.add_patch(circ)
ax.add_patch(pgon)


# ## Enregistrer graphiques dans un fichier

# In[86]:


fig= plt.figure()
ax = fig.add_subplot(1,1,1)

rect = plt.Rectangle((0.2,0.75),0.4,0.15,color='k',alpha=0.3)
circ = plt.Circle((0.7,0.2),0.15,color='b',alpha=0.3)
pgon = plt.Polygon([[0.15,0.15],[0.35,0.4],[0.2,0.6]],0.15,color='g',alpha=0.5)

ax.add_patch(rect)
ax.add_patch(circ)
ax.add_patch(pgon)

plt.savefig('figpath.png',dpi=400)


# In[88]:


from io import StringIO
buffer = StringIO()
#plt.savefig(buffer)
plot_data = buffer.getvalue()
plot_data


# ## Configurations

# In[89]:


plt.rc('figure',figsize=(10,10))


# In[91]:


font_options = {'family':'monospace',
               'weight':'bold',
               'size':10}

plt.rc('font',**font_options)


# ## Graphiques Pandas

# In[94]:


from pandas import Series

plt.rc('figure',figsize=(5,5))

s = Series(np.random.randn(10).cumsum(),index=np.arange(0,100,10))
s.plot()


# In[102]:


from pandas import DataFrame
df = DataFrame(np.random.randn(10,4).cumsum(0),
              columns=['A','B','C','D'],
              index=np.arange(0,100,10))

df


# In[103]:


df.plot()


# In[106]:


fig, axes = plt.subplots(2,1)

data = Series(np.random.randn(16),index=list('abcdefghijklmnop'))

data.plot(kind='bar',ax=axes[0],color='k',alpha=0.7)
data.plot(kind='hist',ax=axes[1],color='b',alpha=0.7)


# In[107]:


pd.Index(['A','B','C','D','E'],name='Genus')


# In[109]:


df2 = DataFrame(np.random.randn(6,5),
               index=['one','two','three','four','five','six'],
               columns=pd.Index(['A','B','C','D','E'],name='Genus'))
df2


# In[110]:


df2.plot(kind='barh',stacked=True,alpha=0.5)


# In[112]:


df2.plot(kind='bar',stacked=False,alpha=0.5)


# In[114]:


np.random.rand(6,5)


# ## Dataset des pourboires

# In[126]:


filePath2 = r'E:\Data\CodesDivers\pydata-book-2nd-edition\examples\tips.csv'


# In[128]:


tips = pd.read_csv(filePath2)
tips.head(5)


# In[134]:


taille = tips.iloc[:,5]
party_counts = pd.crosstab(tips.day,taille,rownames=['day'], colnames=['taille'])
party_counts


# In[158]:


#party_counts['5 et plus'] = party_counts.iloc[:,4] + party_counts.iloc[:,5]

#party_counts_bis = party_counts.iloc[:,:4].copy()
#party_counts_bis.insert(4,'5 et +',party_counts.loc[:,'5 et plus'])

#party_counts_bis.assign(Series(party_counts.iloc[:,4]+ party_counts[:,5],column=('5 et plus')))
#party_counts_bis.head(5)


# In[162]:


party_counts_bis = party_counts.iloc[:,2:4].copy()
party_counts_bis.insert(0,'2 et -',party_counts.iloc[:,0] + party_counts.iloc[:,1])
party_counts_bis.insert(3,'5 et +',party_counts.iloc[:,4] + party_counts.iloc[:,5])

party_counts_bis


# In[163]:


party_counts_bis.sum(1)


# In[164]:


party_counts_bis.div(party_counts_bis.sum(1),axis=0)


# In[166]:


party_counts_bis.div(party_counts_bis.sum(1),axis=0).sum(1)


# In[169]:


ratio_normalises = party_counts_bis.div(party_counts_bis.sum(1),axis=0)
ratio_normalises.plot(kind='bar',stacked=True)
plt.xlabel('Jour de la semaine')
plt.legend(title='Taille des groupes')


# In[172]:


tips['ratio'] = tips['tip']/tips['total_bill']


# In[173]:


tips['ratio'].hist(bins=50)


# In[174]:


tips['ratio'].plot(kind='kde')


# In[177]:


comp1 = np.random.normal(0,1,size=200)
comp2 = np.random.normal(10,2,size=200) 
values = Series(np.concatenate([comp1,comp2]))


# In[182]:


values.hist(bins=100,alpha=0.3,color='k',density=True)
values.plot(kind='kde',style='k--')


# ## Nuage de points

# In[186]:


filePath2 = r'E:\Data\CodesDivers\pydata-book-2nd-edition\examples\macrodata.csv'
macro = pd.read_csv(filePath2)

data = macro[['cpi','m1','tbilrate','unemp']]


# In[190]:


transdata = np.log(data).diff().dropna()
transdata.head(5)


# In[192]:


transdata[-5:]


# In[194]:


plt.scatter(transdata['m1'],transdata['unemp'])
plt.title('Evolutions de log %s comparé à log %s' % ('m1','unemp'))


# In[207]:


np.log(data).diff().dropna()
np.log(data).diff().dropna()[:5]


# In[209]:


pd.plotting.scatter_matrix(transdata,diagonal='kde',color='k',alpha=0.3)

