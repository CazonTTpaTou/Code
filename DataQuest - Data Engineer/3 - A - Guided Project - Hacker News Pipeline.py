
# coding: utf-8

# # Guided Project - Hacker News Pipeline

# In[9]:


from pipeline import Pipeline

pipeline = Pipeline()


import json

@pipeline.task()
def file_to_json():
    file_name='hn_stories_2014.json'
    with open(file_name,'r') as f:
        data = json.load(f)
        stories = data['stories']
        
    return stories
          


# In[10]:


@pipeline.task(depends_on=file_to_json)
def filter_stories(stories):
    for story in stories:
        if (story['points']>=50
            and story['num_comments']>1
            and story['title'][:6] != 'Ask HN'):
            
            yield story


# In[11]:


from datetime import datetime
from pipeline import build_csv
import io

@pipeline.task(depends_on=filter_stories)
def json_to_csv(filtered):
    def parse(inputs):
        for data in inputs:
            yield (data['objectID'],
                   datetime.strptime(data['created_at'], "%Y-%m-%dT%H:%M:%SZ"),
                   data['url'],
                   data['points'],
                   data['title'])               
    return build_csv(
            parse(filtered),
            header=['objectID', 'created_at', 'url', 'points', 'title'],
            file=io.StringIO())


# In[12]:


import csv

@pipeline.task(depends_on=json_to_csv)
def extract_titles(file):
    reader = csv.reader(file)
    header = next(reader)
    idx = header.index('title')

    return (line[idx] for line in reader)


# In[13]:


import string

@pipeline.task(depends_on=extract_titles)
def clean_titles(titles):
    def clean(words):
        word = words.lower()
        table = str.maketrans({key: None for key in string.punctuation})
        return word.translate(table)
    
    return (clean(wd) for wd in titles)


# In[14]:


from stop_words import stop_words

@pipeline.task(depends_on=clean_titles)
def build_keyword_dictionary(titles):
    dict_words = dict()
    for title in titles:
        for word in title.split(' '):
            if len(word)>0 and word not in stop_words:
                if word in dict_words.keys():
                    dict_words[word]+=1
                else:
                    dict_words[word]=1
                    
    return dict_words


# In[15]:


@pipeline.task(depends_on=build_keyword_dictionary)
def sort_word_frequency(frequency):
    sort_frequencies = sorted(frequency,
                              key=lambda x:frequency[x],
                              reverse=True)
    
    freq_tupe = [(word,frequency[word]) for word in sort_frequencies] 
    
    return freq_tupe[:100]


# In[20]:


top_words = pipeline.run()

print(top_words[sort_word_frequency])

