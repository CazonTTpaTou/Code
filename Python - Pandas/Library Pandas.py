
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd


# In[4]:


famille_panda = [
    np.array([100, 5  , 20, 80]), # maman panda
    np.array([50 , 2.5, 10, 40]), # bébé panda
    np.array([110, 6  , 22, 80]), # papa panda
]
famille_panda


# In[3]:


famille_panda = [
    [100, 5  , 20, 80], # maman panda
    [50 , 2.5, 10, 40], # bébé panda
    [110, 6  , 22, 80], # papa panda
]
famille_panda_numpy = np.array(famille_panda)
famille_panda_numpy


# In[7]:


famille_panda_numpy[2,0]
famille_panda_numpy[:,0]


# In[8]:


famille_pandas_df = pd.DataFrame(famille_panda)
famille_pandas_df


# In[10]:


famille_panda_df = pd.DataFrame(famille_panda_numpy,index=['maman','bébé','papa'],columns=['pattes','poil','queue','ventre'])
famille_panda_df


# In[12]:


famille_panda_df["ventre"]


# In[13]:


famille_panda_df.ventre


# In[14]:


famille_panda_df["ventre"].values


# In[15]:


famille_panda_df.ventre.values


# In[16]:


for ligne in famille_panda_df.iterrows():
    index_ligne = ligne[0]
    contenu_ligne = ligne[1]
    print("Voici le panda %s :" % index_ligne)
    print(contenu_ligne)
    print("--------------------")


# In[17]:


famille_panda_df.iloc[2] # Avec iloc(), indexation positionnelle
famille_panda_df.loc["papa"] # Avec loc(), indexation par label


# In[18]:


famille_panda_df["ventre"] == 80


# In[20]:


masque = famille_panda_df["ventre"] == 80
pandas_80 = famille_panda_df[masque]
pandas_80 = famille_panda_df[famille_panda_df["ventre"] == 80]
pandas_80


# In[21]:


# Inversion du masque
famille_panda_df[~masque]


# In[23]:


quelques_pandas = pd.DataFrame([[105,4,19,80],[100,5,20,80]],      # deux nouveaux pandas
                               columns = famille_panda_df.columns,
                               index = ['tonton','tata'])                                
tous_les_pandas = famille_panda_df.append(quelques_pandas)
tous_les_pandas


# In[25]:


# Déduplication des lignes aux données identiques
pandas_uniques = tous_les_pandas.drop_duplicates()
pandas_uniques


# In[29]:


# accéder aux noms des colonnes
famille_panda_df.columns
# créer une nouvelle colonne, composée de chaînes de caractères - a maman et le bébé sont des femelles, le papa est un mâle 
famille_panda_df["sexe"] = ["f", "f", "m"] 
famille_panda_df


# In[30]:


# obtenir le nombre de lignes
len(famille_panda_df)


# In[31]:


# obtenir les valeurs distinctes d'une colonne - pour la colonne ventre, il y a deux valeurs distinctes : 40 et 80
famille_panda_df.ventre.unique()


# In[33]:


data = pd.read_csv("E:/Data/RawData/IrisData.csv", sep=";")
data.head()


# In[34]:


# Obtenir le répertoire courant
import os
os.getcwd()

