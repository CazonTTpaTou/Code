
# coding: utf-8

# In[15]:


get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt
plt.style.use('seaborn-whitegrid')
import numpy as np
import pandas as pd


# In[4]:


fig = plt.figure()
ax = plt.axes()
x = np.linspace(0,10,1000)
ax.plot(x,np.sin(x));


# In[5]:


fig = plt.figure()
ax = plt.axes()
x = np.linspace(0,10,1000)

# Changer la taille de police par défaut
plt.rcParams.update({'font.size': 15})
# Couleur spécifiée par son nom, ligne solide
plt.plot(x, np.sin(x - 0), color='blue', linestyle='solid', label='bleu')
# Nom court pour la couleur, ligne avec des traits
plt.plot(x, np.sin(x - 1), color='g', linestyle='dashed', label='vert')
# Valeur de gris entre 0 et 1, des traits et des points
plt.plot(x, np.sin(x - 2), color='0.75', linestyle='dashdot', label='gris')
# Couleur spécifié en RGB, avec des points
plt.plot(x, np.sin(x - 3), color='#FF0000', linestyle='dotted', label='rouge')
# Les limites des axes, essayez aussi les arguments 'tight' et 'equal' pour voir leur effet
plt.axis([-1, 11, -1.5, 1.5]);
# Les labels
plt.title("Un exemple de graphe")
# La légende est générée à partir de l'argument label de la fonction plot - loc spécifie le placement de la légende
plt.legend(loc='lower left');
# Titres des axes
ax = ax.set(xlabel='x', ylabel='sin(x)')


# In[6]:


x = np.linspace(0, 10, 50)
dy = 0.8
y = np.sin(x) + dy * np.random.randn(50)
plt.errorbar(x, y, yerr=dy, fmt='.k');


# In[7]:


plt.errorbar(x, y, yerr=dy, fmt='o', color='black', ecolor='lightgray', elinewidth=3, capsize=0);


# In[8]:


x = np.linspace(0, 10, 50)
dy = 0.8
y = np.sin(x) + dy * np.random.randn(50)
# Représentation graphique
print(plt.style.available[:6])
# Notez la taille de la figure
fig = plt.figure(figsize=(12,8))
for i in range(6):
    # On peut ajouter des sous graphes ainsi
    fig.add_subplot(3,2,i+1)
    plt.style.use(plt.style.available[i])
    plt.plot(x, y)    
    # Pour ajouter du texte
    plt.text(s=plt.style.available[i], x=5, y=2, color='red')


# In[9]:


# On peut aussi tout personnaliser à la main
x = np.random.randn(1000)
plt.style.use('classic')
fig=plt.figure(figsize=(5,3))
ax = plt.axes(facecolor='#E6E6E6')
# Afficher les ticks en dessous de l'axe
ax.set_axisbelow(True)
# Cadre en blanc
plt.grid(color='w', linestyle='solid')
# Cacher le cadre
# ax.spines contient les lignes qui entourent la zone où les données sont affichées.
for spine in ax.spines.values():
    spine.set_visible(False)
# Cacher les marqueurs en haut et à droite
ax.xaxis.tick_bottom()
ax.yaxis.tick_left()
# Nous pouvons personnaliser les étiquettes des marqueurs et leur appliquer une rotation
marqueurs = [-3, -2, -1, 0, 1, 2, 3]
xtick_labels = ['A', 'B', 'C', 'D', 'E', 'F']
plt.xticks(marqueurs, xtick_labels, rotation=30)
# Changer les couleur des marqueurs
ax.tick_params(colors='gray', direction='out')
for tick in ax.get_xticklabels():
    tick.set_color('gray')
for tick in ax.get_yticklabels():
    tick.set_color('gray')
# Changer les couleur des barres
ax.hist(x, edgecolor='#E6E6E6', color='#EE6666');


# In[11]:


import seaborn as sns
sns.set()
x = np.linspace(0, 10, 500)
y = np.random.randn(500)
plt.plot(x,y);


# In[12]:


x = np.linspace(0, 10, 50)
dy = 0.8
y = np.sin(x) + dy * np.random.randn(50)
# Représentation graphique
sns.distplot(y, kde=True);


# In[17]:


raw_data = pd.read_csv("E:/Data/RawData/IrisData.csv",sep=";")
raw_data.head()


# In[18]:


sns.pairplot(raw_data, hue='Species', size=2.5);


# In[22]:


# Regression linéaire
with sns.axes_style('white'):
    sns.jointplot("PetalLength", "PetalWidth", data=raw_data, kind='reg')

