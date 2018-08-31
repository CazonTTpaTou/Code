
# coding: utf-8

# In[1]:


import pandas as pd


# In[4]:


data = pd.read_csv('thanksgiving.csv',encoding="Latin-1")


# In[5]:


data.head(2)


# In[10]:


for column in data.columns.tolist():
    print(column[:60])


# In[14]:


data['Do you celebrate Thanksgiving?'].value_counts()


# In[17]:


positive_answers = data['Do you celebrate Thanksgiving?']=='Yes'
data = data[positive_answers]


# In[18]:


data['Do you celebrate Thanksgiving?'].value_counts()


# In[19]:


column = 'What is typically the main dish at your Thanksgiving dinner?'
data[column].value_counts()


# In[20]:


column_gravy = 'Do you typically have gravy?'
data[column_gravy][data[column]=='Tofurkey']


# In[23]:


column_apple = 'Which type of pie is typically served at your Thanksgiving dinner? Please select all that apply. - Apple'
apple_isnull = data[column_apple].isnull()
apple_isnull[:4]


# In[24]:


column_pumpkin = 'Which type of pie is typically served at your Thanksgiving dinner? Please select all that apply. - Pumpkin'
pumpkin_isnull = data[column_pumpkin].isnull()
pumpkin_isnull[:4]



# In[25]:


column_pecan = 'Which type of pie is typically served at your Thanksgiving dinner? Please select all that apply. - Pecan'
pecan_isnull = data[column_pecan].isnull()
pecan_isnull[:4]


# In[28]:


no_pies = apple_isnull & pecan_isnull & pumpkin_isnull
no_pies.value_counts()


# In[36]:


import numpy as np

def convert_age(value):
    if pd.isnull(value):
        return None
    slices = value.split()
    return int(slices[0].replace('+',''))

print(convert_age(np.nan))
print(convert_age('60+'))
print(convert_age('20 - 30'))
        


# In[37]:


data['int_age'] = data['Age'].apply(convert_age)
data['int_age'].head(5)


# In[38]:


data['int_age'].value_counts()


# In[43]:


data['int_age'].value_counts().sort_values(ascending=False)


# In[44]:


data['int_age'].value_counts().sort_index(ascending=True)


# In[46]:


def convert_revenue(value):
    if pd.isnull(value):
        return None
    
    first_term = value.split()[0]
    
    if(first_term=='Prefer'):
        return None
    else:       
        return int(first_term.replace('$','').replace(',',''))

print(convert_revenue(np.nan))
print(convert_revenue('$100,000 to $124,999'))
print(convert_revenue('Prefer not to answer'))


# In[47]:


column_revenue = 'How much total combined money did all members of your HOUSEHOLD earn last year?'
int_income = data[column_revenue].apply(convert_revenue)
int_income[:5]


# In[49]:


int_income.value_counts().sort_values(ascending=False)


# In[51]:


int_income.value_counts().sort_index(ascending=True)


# In[52]:


data['int_income']=int_income


# In[53]:


column_travel = 'How far will you travel for Thanksgiving?'


# In[59]:


less_150000 = data[column_travel][data['int_income']<=150000]
less_150000.head(5)


# In[60]:


less_150000.value_counts().sort_index()


# In[63]:


more_150000 = data[column_travel][data['int_income']>=150000]
more_150000.head(5)


# In[64]:


more_150000.value_counts().sort_index()


# In[67]:


column_friend = "Have you ever tried to meet up with hometown friends on Thanksgiving night?"
column_friend_giving = 'Have you ever attended a "Friendsgiving?"'

tcd = data.pivot_table(index=column_friend,
                       columns=column_friend_giving,
                       values='int_age')
tcd


# In[68]:


tcd2 = data.pivot_table(index=column_friend,
                       columns=column_friend_giving,
                       values='int_income')
tcd2

