
# coding: utf-8

# ## Guided Project: Finding the Best Markets to Advertise In

# In[2]:


import pandas as pd

data = pd.read_csv('2017-fCC-New-Coders-Survey-Data.csv')

for col in data.columns:
    print(col)

print(data.head(3))


# In[4]:


distrib = data['JobRoleInterest'].value_counts(normalize=True)
distrib


# ## Development interest

# In[13]:


languages = data['JobRoleInterest'].dropna()
list_langage = languages.str.split(',')

list_langage_number = list_langage.apply(lambda x:len(x))
list_langage_number

list_langage_number.value_counts(normalize=True).sort_values(ascending=False)


# In[19]:


number_langages = list_langage_number.value_counts(normalize=True).sort_index(ascending=True)
number_langages


# In[32]:


diagramme={}
cumul=0
for value in number_langages.items():
    if value[0]<=9:
        chiffre=str(0) + str(value[0]) + ' ' + 'langage(s)'
    else:
        chiffre=str(value[0]) + ' ' + 'langage(s)'
   
    cumul+=value[1]
    diagramme[chiffre]=cumul

diagramme


# ## Interest Visualisation

# In[35]:


df = pd.Series(diagramme)
df


# In[38]:


import matplotlib.pyplot as plt
get_ipython().magic('matplotlib inline')

df.plot.barh()
plt.axvline(x=0.80,color='red',label='Pareto')
plt.legend()
plt.show()


# ## Localisation markets

# In[43]:


data =data.dropna(subset=['JobRoleInterest'])
country = data['CountryLive'].value_counts(normalize=True).sort_values(ascending=False)
country


# In[44]:


country[:2]


# ## Mobile Interests

# In[45]:


interests_no_nulls = data['JobRoleInterest'].dropna()
web_or_mobile = interests_no_nulls.str.contains(
    'Web Developer|Mobile Developer') # returns an array of booleans
freq_table = web_or_mobile.value_counts(normalize = True) * 100
print(freq_table)


get_ipython().magic('matplotlib inline')
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')

freq_table.plot.bar()
plt.title('Most Participants are Interested in \nWeb or Mobile Development',
          y = 1.08) # y pads the title upward
plt.ylabel('Percentage', fontsize = 12)
plt.xticks([0,1],['Web or mobile\ndevelopment', 'Other subject'],
           rotation = 0) # the initial xtick labels were True and False
plt.ylim([0,100])
plt.show()


# ## Money for learning

# In[63]:


data['Money_per_month']=data['MoneyForLearning']/(data['MonthsProgramming'].replace(0,1))


# In[64]:


data['Money_per_month'].isna().value_counts()


# In[65]:


new_data = data.dropna(subset=['CountryLive','Money_per_month'])

condition1=  new_data['CountryLive']== 'United States of America'
condition2=  new_data['CountryLive']== 'United Kingdom'
condition3=  new_data['CountryLive']== 'India'
condition4=  new_data['CountryLive']== 'Canada'

condition = condition1 | condition2 | condition3 | condition4


# In[66]:


new_data = new_data[condition]


# In[68]:


new_data.groupby(['CountryLive'])['Money_per_month'].mean().sort_values(ascending=False)


# In[69]:


new_data.groupby(['CountryLive'])['Money_per_month'].median().sort_values(ascending=False)


# In[72]:


new_data.groupby(['CountryLive'])['Money_per_month'].max().sort_values(ascending=False)


# ## Dealing with extreme Outliers

# In[87]:


box_plot = pd.Series(new_data['Money_per_month'].values
                     ,index=new_data['CountryLive'])

box_plot.head()


# In[93]:


#box_plot.isna().sum()
#box_plot.plot(kind='box',use_index=True)
#new_data[['CountryLive','Money_per_month']].plot(kind='box')
box_plot.plot.box()
plt.show()


# In[94]:


new_data[['CountryLive','Money_per_month']].boxplot(by='CountryLive')


# In[95]:


new_data.groupby(['CountryLive'])['Money_per_month'].max().sort_values(ascending=False)


# In[96]:


condition = new_data['Money_per_month']< 5000
new_data_cap = new_data[condition]



# In[97]:


new_data_cap[['CountryLive','Money_per_month']].boxplot(by='CountryLive')


# In[99]:


condition = new_data['Money_per_month']< 500
new_data_cap = new_data[condition]
new_data_cap[['CountryLive','Money_per_month']].boxplot(by='CountryLive')


# In[102]:


new_data_cap.groupby(['CountryLive'])['Money_per_month'].max().sort_values(ascending=False)


# In[103]:


import seaborn as sns

sns.boxplot(x='CountryLive',
            y='Money_per_month',
           data=new_data_cap)


# ## Z-Score for choosing second market

# In[109]:


def z_score(value,mean,std):
    return (value-mean)/std

mean = new_data_cap['Money_per_month'].mean()
std = new_data_cap['Money_per_month'].std(ddof=1)

new_data_cap['z_score']=new_data_cap['Money_per_month'].apply(lambda x:(x-mean)/std)


# In[111]:


new_data_cap.groupby(['CountryLive'])['z_score'].mean().sort_values(ascending=False)


# In[119]:


for country in new_data_cap['CountryLive'].unique():
    data_country=new_data_cap[new_data_cap['CountryLive']==country]
    mean = data_country['Money_per_month'].mean()
    std = data_country['Money_per_month'].std(ddof=1)
    z_score= (59-mean)/std
    print('Z-score {} : {}'.format(country,z_score))
    
    

