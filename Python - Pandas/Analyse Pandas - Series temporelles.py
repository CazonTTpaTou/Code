
# coding: utf-8

# # Analyse Pandas - Séries temporelles

# ## Dates et données

# In[1]:


from datetime import datetime

now = datetime.now()
now


# In[2]:


now.year,now.month,now.day


# In[3]:


delta = datetime(2011,1,7)-datetime(2008,6,24,15)
delta


# In[6]:


delta.seconds


# In[7]:


str(now)


# In[9]:


stamp=datetime(2011,1,7)
stamp.strftime('%Y-%m-%d')


# In[15]:


dateStr = ['7/6/2011','8/6/2011']
[datetime.strptime(x,'%m/%d/%Y') for x in dateStr]


# In[16]:


from dateutil.parser import parse

parse('2011-03-01')


# In[17]:


parse('2011-03-01',dayfirst=True)


# In[18]:


import pandas as pd
pd.to_datetime(dateStr)


# In[21]:


sr = pd.to_datetime(dateStr)


# In[22]:


from pandas import Series

srT = Series([1,2],index=sr)


# In[24]:


srT


# In[25]:


srT + srT[::1]


# In[26]:


srT.index[1]


# In[29]:


import numpy as np

longer_ts = Series(np.random.randn(1000),
                  index=pd.date_range('1/1/2000',periods=1000))
longer_ts.head(5)


# In[31]:


longer_ts['2001-5'].head(5)


# In[33]:


longer_ts['2001-5':'2001-7'].tail(5)


# In[35]:


ws_ts = Series(np.random.randn(100),
                  index=pd.date_range('1/1/2000',periods=100,freq='W-WED'))
ws_ts.head(5)


# In[38]:


ajout=datetime(2000,1,5)
ajout


# In[43]:


doubleChunk = Series({ajout:0.1234589})
newTab = ws_ts.append(doubleChunk)
newTab.tail(5)


# In[44]:


grouped = newTab.groupby(level=0)
grouped.count().head(5)


# ## Générer des plages de date

# In[48]:


completTab = newTab.resample('D')
completTab.head(10)


# In[49]:


index1 = pd.date_range(start='4/1/2012',periods=20)
index1


# In[51]:


index2 = pd.date_range('4/1/2012','6/1/2012')
index2


# In[52]:


index3 = pd.date_range(end='8/1/2012',periods=10)
index3


# In[54]:


# Toutes les fins de mois ouvrables
index4 = pd.date_range('4/1/2012','4/1/2013',freq='BM')
index4


# In[55]:


# Toutes les fins de mois calendaires
index5 = pd.date_range('4/1/2012','4/1/2013',freq='M')
index5


# In[57]:


# 3ième vendredi de chaque mois
index6 = pd.date_range('4/1/2017','4/1/2018',freq='WOM-3FRI')
index6


# ## Décalage de dates

# In[58]:


now


# In[62]:


from pandas.tseries.offsets import Day,MonthEnd
from pandas.tseries import offsets 

d1 = now + MonthEnd()
d1


# In[66]:


d2 = now + MonthEnd(2)
d2


# In[68]:


d3 = now + 3 * Day()
d3


# In[69]:


offset = MonthEnd()
offset.rollforward(now)


# In[72]:


offset = MonthEnd()
offset.rollback(now)


# ## Périodes

# In[73]:


p = pd.Period(2007,freq='A-DEC')
p


# In[74]:


p + 5


# In[75]:


p-3


# In[77]:


rng = pd.period_range('1/1/2000','6/30/2000',freq='M')
rng


# In[80]:


Series(np.random.randn(6),index=rng)


# In[81]:


rngm = p.asfreq('M',how='start')


# In[82]:


rngm


# In[83]:


rngm = p.asfreq('M',how='end')
rngm


# In[85]:


# Année fiscale sur juin
pj = pd.Period('2010',freq='A-JUN')


# In[87]:


rngm = pj.asfreq('M',how='end')
rngm


# In[88]:


rngn = pj.asfreq('M',how='start')
rngn


# In[98]:


# Fréquences trimestrielles
pj = pd.Period('2010',freq='Q-DEC')
rngm = pj.asfreq('M',how='start')
rngm


# In[99]:


rngm = pj.asfreq('M',how='end')
rngm


# In[100]:


rngm = pj.asfreq('D',how='end')
rngm


# In[101]:


# Fréquences trimestrielles
pj = pd.Period('2010Q2',freq='Q-DEC')
rngm = pj.asfreq('M',how='start')
rngm


# In[102]:


rngm = pj.asfreq('M',how='end')
rngm


# In[107]:


rng = pd.period_range('2007Q3','2008Q4',freq='Q-JAN')
ts = Series(np.arange(len(rng)),index=rng)
ts


# In[109]:


rng = pd.period_range('2007Q3','2008Q4',freq='M')
ts = Series(np.arange(len(rng)),index=rng)
ts


# In[110]:


ts.index


# In[112]:


ts.values


# In[114]:


ts.resample('Y').sum()


# In[120]:


ts.resample('D').mean().head(5)


# In[126]:


ts.resample('D').ffill()


# ## Graphiques

# In[131]:


ws_ts = Series(np.random.randn(120),
                  index=pd.date_range('1/1/2016',periods=120,freq='W-WED'))


# In[132]:


from matplotlib import pylab as plt
ws_ts.plot()


# In[133]:


pd.rolling_mean(ws_ts,10).plot()


# In[134]:


ws_ts.rolling(window=20,center=False).mean().plot()


# In[135]:


get_ipython().run_line_magic('timeit', "ts.resample('D').ffill()")

