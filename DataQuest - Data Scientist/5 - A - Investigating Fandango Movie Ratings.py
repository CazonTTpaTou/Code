
# coding: utf-8

# # Fandango Analysis

# ## Understanding the data

# In[1]:


import pandas as pd
pd.options.display.max_columns = 100  # Avoid having displayed truncated output

previous = pd.read_csv('fandango_score_comparison.csv')
after = pd.read_csv('movie_ratings_16_17.csv')

previous.head(3)


# In[2]:


fandango_previous = previous[['FILM', 'Fandango_Stars', 'Fandango_Ratingvalue', 'Fandango_votes',
                             'Fandango_Difference']].copy()
fandango_after = after[['movie', 'year', 'fandango']].copy()

fandango_previous.head(3)


# In[3]:


fandango_after.head(3)


# ## Isolating the samples

# In[5]:


sample_previous = fandango_previous.sample(10,random_state=1)
sample_after = fandango_after.sample(10,random_state=1)


# In[6]:


sample_previous


# In[7]:


sample_after


# In[9]:


sum(sample_previous['Fandango_votes']<30)


# ## Datasets by year

# In[13]:


fandango_2016 = fandango_after[fandango_after['year']==2016]


# In[21]:


fandango_previous['Year'] = fandango_previous['FILM'].str[-5:-1]
condition = fandango_previous['Year'] == '2015'
fandango_2015 = fandango_previous[condition]


# In[22]:


print(fandango_2015['Year'].value_counts())


# In[20]:


fandango_previous['Year'].head()


# In[25]:


fandango_2016['year'].value_counts()


# ## Visual Comparing

# In[29]:


get_ipython().magic('matplotlib inline')
fandango_2015['Fandango_Stars'].plot.hist(histtype = 'step', label = '2015', legend = True)
fandango_2016['fandango'].plot.hist(histtype = 'step', label = '2016', legend = True)


# In[33]:


from numpy import arange
import matplotlib.pyplot as plt
get_ipython().magic('matplotlib inline')

plt.style.use('fivethirtyeight')

fandango_2015['Fandango_Stars'].plot.kde(label = '2015', 
                                         legend = True,
                                        xticks = arange(0,5.5,0.5))

fandango_2016['fandango'].plot.kde(label = '2016', 
                                   legend = True,
                                  xticks = arange(0,5.5,0.5))

plt.title("Comparing distribution shapes for Fandango's ratings\n(2015 vs 2016)",
          y = 1.07) # the `y` parameter pads the title upward
plt.xlabel('Stars')
plt.xlim(0,5) # because ratings start at 0 and end at 5


# ## Analysing frequencies

# In[35]:


fandango_2015['Fandango_Stars'].value_counts(normalize=True).sort_index()


# In[36]:


fandango_2016['fandango'].value_counts(normalize=True).sort_index()


# ## Statistics

# In[43]:


moy_2015 = fandango_2015['Fandango_Stars'].mean()
med_2015 = fandango_2015['Fandango_Stars'].median()
mod_2015 = fandango_2015['Fandango_Stars'].mode()[0]

moy_2016 = fandango_2016['fandango'].mean()
med_2016 = fandango_2016['fandango'].median()
mod_2016 = fandango_2016['fandango'].mode()[0]

stats= {2015:{'moyenne':moy_2015,
              'médiane':med_2015,
              'mode':mod_2015},
       2016:{'moyenne':moy_2016,
              'médiane':med_2016,
              'mode':mod_2016}}

df_stats = pd.DataFrame(stats)
df_stats


# In[48]:


df_stats.plot.bar(rot=30)


# In[49]:


df_stats.plot.barh()


# In[51]:


plt.style.use('fivethirtyeight')
df_stats[2015].plot.bar(color = '#0066FF', align = 'center', label = '2015', width = .25)
df_stats[2016].plot.bar(color = '#CC0000', align = 'edge', label = '2016', width = .25,
                         rot = 0, figsize = (8,5))

plt.title('Comparing summary statistics: 2015 vs 2016', y = 1.07)
plt.ylim(0,5.5)
plt.yticks(arange(0,5.1,.5))
plt.ylabel('Stars')
plt.legend(framealpha = 0, loc = 'upper center')
plt.show()

