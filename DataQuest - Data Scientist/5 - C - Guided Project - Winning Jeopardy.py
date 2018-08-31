
# coding: utf-8

# In[2]:


import pandas as pd

jeopardy = pd.read_csv('jeopardy.csv')

print(jeopardy.head(5))


# ## Jeopardy questions

# In[5]:


new_col=[]

for col in jeopardy.columns:
    new_col.append(col.lstrip())

jeopardy.columns = new_col


# In[7]:


jeopardy.dtypes


# In[10]:


jeopardy['Air Date'] = pd.to_datetime(jeopardy['Air Date'])
jeopardy.dtypes


# ## Normalize Text

# In[17]:


import string

def normalize(texte):
    text = texte.lower()
    table_puntuation = {ord(char): None for char in string.punctuation}
    text = text.translate(table_puntuation)
    return text
    


# In[19]:


jeopardy['clean_question'] = jeopardy['Question'].apply(normalize)

jeopardy['clean_answer'] = jeopardy['Answer'].apply(normalize)


# In[20]:


jeopardy['clean_question'].head(5)


# ## Columns normalizing

# In[23]:


def normalize_dollars(text):
    table_puntuation = {ord(char): None for char in string.punctuation}
    text = text.translate(table_puntuation)
    try:
        value = int(text)
    except:
        value=0
    return value

jeopardy['clean_value'] = jeopardy['Value'].apply(normalize_dollars)
jeopardy['clean_value'].head(5)


# In[21]:


string.punctuation


# ## Answer in questions

# In[29]:


def question_answer(row):
    split_answer = row['clean_answer'].split(' ')
    
    try:
        split_answer.remove('the')
    except:
        pass
        
    split_question = row['clean_question'].split(' ')
    
    match_count=0
    
    for word in split_answer:
        if word in split_question:
            match_count+=1
    try:
        ratio = match_count / len(split_answer)        
    except:
        ratio = 0
    
    return ratio
   
jeopardy['answer_in_question'] = jeopardy.apply(question_answer,axis=1)

mean_answer_in_question = jeopardy['answer_in_question'].mean()

mean_answer_in_question
    


# ## Recycled questions

# In[33]:


jeopardy_sorted = jeopardy.sort_values(by='Air Date',ascending=True)


# In[45]:


terms_used = set()
question_overlap = []

for row in jeopardy_sorted.iterrows():
    split_question = row[1]['clean_question'].split(' ')
    new_split_question = [word for word in split_question if len(word)>6]
    match_count=0
    
    for wd in new_split_question:
        if terms_used.intersection(wd)==set():
            match_count+=1
            terms_used.add(wd)
    
    if len(new_split_question)>0:
        ratio = match_count/len(new_split_question)
        
    else:
        ratio=0
        
    question_overlap.append(ratio)
    
jeopardy_sorted['question_overlaps'] = question_overlap
    
mean_jeopardy_question_overlap = jeopardy_sorted['question_overlaps'].mean()

print(mean_jeopardy_question_overlap)    


# ## Low values vs high values questions

# In[46]:


len(terms_used)


# In[47]:


def high_value(row):
    if row['clean_value']>800:
        value=1
    else:
        value=0
    return value

jeopardy_sorted['high_value'] = jeopardy_sorted.apply(high_value,axis=1)


# In[63]:


def high_low_count(word):
    low_count = 0
    high_count = 0
    for row in jeopardy_sorted.iterrows():
        if word in row[1]['clean_question'].split(' '):
            if row[1]['high_value']==1:
                high_count+=1
            else:
                low_count+=1
    return low_count,high_count

observed_expected = []
comparaison_terms = list(terms_used)[:5]


# In[64]:


comparaison_terms


# In[65]:


for word in comparaison_terms:
    observed_expected.append(high_low_count(word))
        


# In[66]:


observed_expected


# ## Applying the chi-squared test

# In[57]:


high_value_count = jeopardy_sorted['high_value'].sum()
low_value_count = len(jeopardy_sorted['high_value'])-high_value_count


# In[58]:


low_value_count


# In[59]:


high_value_count


# In[62]:


low_value_count = len(jeopardy_sorted[jeopardy_sorted['high_value']==0])
low_value_count


# In[71]:


from scipy.stats import chisquare

chi_squared = []

for liste in observed_expected:
    total = liste[0] + liste[1]
    total_prop = total / len(jeopardy_sorted)
    
    expected_high_value = total_prop * high_value_count
    expected_low_value = total_prop * low_value_count
                                 
    chi_high,p_value_high = chisquare(liste[1],expected_high_value)   
    chi_low,p_value_low = chisquare(liste[0],expected_low_value)                                     
   
    chi_squared.append([chi_high,p_value_high])                             
    chi_squared.append([chi_low,p_value_low])  
                             


# ## Next steps

# In[72]:


chi_squared

