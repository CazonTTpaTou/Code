
# coding: utf-8

# In[48]:


import pandas as pd
star_wars = pd.read_csv("star_wars.csv", encoding="ISO-8859-1")


# In[49]:


star_wars.head(10)


# In[50]:


star_wars.columns


# In[51]:


star_wars = star_wars.dropna(axis=0,subset=["RespondentID"])


# In[52]:


star_wars['RespondentID'].isnull().sum()


# In[53]:


star_wars.count()


# In[54]:


star_wars['Have you seen any of the 6 films in the Star Wars franchise?'].value_counts()


# In[55]:


star_wars['Do you consider yourself to be a fan of the Star Wars film franchise?'].value_counts()


# In[56]:


yes_no = {'Yes':True,'No':False}

star_wars['Have you seen any of the 6 films in the Star Wars franchise?'].map(yes_no)
star_wars['Do you consider yourself to be a fan of the Star Wars film franchise?'].map(yes_no)



# In[90]:


import numpy as np

star_wars_copie = star_wars.copy()

star_wars_copie.head()


# In[91]:



movie_mapping = {
    "Star Wars: Episode I  The Phantom Menace": True,
    np.nan: False,
    "Star Wars: Episode II  Attack of the Clones": True,
    "Star Wars: Episode III  Revenge of the Sith": True,
    "Star Wars: Episode IV  A New Hope": True,
    "Star Wars: Episode V The Empire Strikes Back": True,
    "Star Wars: Episode VI Return of the Jedi": True
}

for index,col in enumerate(star_wars_copie.columns[3:9]):
    star_wars_copie[col] = star_wars_copie[col].map(movie_mapping)




# In[92]:


star_wars_copie.head()


# In[93]:


dictionnaire_cols = {}

for index,col in enumerate(star_wars_copie.columns[3:9]):
    new_name = "seen_" + str(index+1)
    dictionnaire_cols[col]=new_name
    
star_wars_copie.rename(columns=dictionnaire_cols,
                       inplace=True)



# In[94]:


star_wars_copie.head()


# In[95]:


star_wars_copie[star_wars_copie.columns[9:15]] = star_wars_copie[star_wars_copie.columns[9:15]].astype(float)


# In[96]:


dictionnaire_cols = {}

for index,col in enumerate(star_wars_copie.columns[9:15]):
    new_name = "ranking_" + str(index+1)
    dictionnaire_cols[col]=new_name
    
star_wars_copie.rename(columns=dictionnaire_cols,
                       inplace=True)


# In[98]:


get_ipython().magic('matplotlib inline')

ranking = star_wars_copie[star_wars_copie.columns[9:15]].mean()
ranking.plot.bar()


# In[99]:


seen = star_wars_copie[star_wars_copie.columns[3:9]].sum()
seen.plot.bar()


# In[109]:


males = star_wars_copie[star_wars_copie["Gender"] == "Male"]
females = star_wars_copie[star_wars_copie["Gender"] == "Female"]


# In[112]:


dataframe = [males,females]
ranking_list = []
seen_list = []

for df in dataframe:
    ranking = df[df.columns[9:15]].mean()
    ranking_list.append(ranking)

    seen = df[df.columns[3:9]].sum()
    seen_list.append(seen)


# In[114]:


ranking_list[0].plot.bar()


# In[115]:


ranking_list[1].plot.bar()


# In[116]:


seen_list[0].plot.bar()


# In[117]:


seen_list[1].plot.bar()

