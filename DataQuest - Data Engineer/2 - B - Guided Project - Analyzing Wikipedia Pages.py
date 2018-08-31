
# coding: utf-8

# # Guided Project - Analyzing Wikipedia Pages

# In[1]:


import os

list_file = os.listdir('wiki')

nb_file = len(list_file)
print(nb_file)

file_name = "wiki/" + list_file[1]

with open(file_name,'r',encoding='utf-8') as f:
    print(f.read())
 


# ## Reading in the Data

# In[2]:


import concurrent.futures
import time

start = time.time()

pool = concurrent.futures.ThreadPoolExecutor(max_workers=10)

def reading_file(file):
    file_name = 'wiki/' + file
    with open(file_name,'r',encoding='utf-8') as f:
        return f.read()
    
def reading_title(file):
    name_file = file[:-5]
    return name_file

content = list(pool.map(reading_file,list_file))
articles = list(pool.map(reading_title,list_file))

end = time.time()

length = end - start

print('Durée exécution : {}'.format(length))
    


# In[3]:


for article in articles[:10]:
    print(article)


# In[20]:


def parallel_threading(number_worker):

    pool = concurrent.futures.ThreadPoolExecutor(
        max_workers=number_worker)

    conten = list(pool.map(reading_file,list_file))
    article = list(pool.map(reading_title,list_file))

    return conten,article

for number in range(1,20):
    start = time.time()
    content,articles = parallel_threading(number)
    end = time.time()
    
    length = end-start
    
    print('Nombre Worker {} - Durée exécution : {}'.format(number,
                                                           length))        


# In[21]:


start = time.time()

content=list()
articles = list()

for file in list_file:
    content.append(reading_file(file))
    articles.append(reading_title(file))

end = time.time()

length = end - start

print('Durée exécution : {}'.format(length))


# ## Remove Extraneous Markup

# In[3]:


from bs4 import BeautifulSoup

def reading_html(page_html):
    soup = BeautifulSoup(page_html, 'html.parser')
    content = str(soup.find_all("div", id="content")[0])
    return content


# In[23]:


def parallel_threading_html(number_worker):

    pool = concurrent.futures.ThreadPoolExecutor(
        max_workers=number_worker)
    
    contents = list(pool.map(reading_file,list_file))
    
    cont = list(pool.map(reading_html,contents))
    
    return cont

for number in range(1,20):
    start = time.time()
    parsed = parallel_threading_html(number)
    end = time.time()
    
    length = end-start
    
    print('Nombre Worker {} - Durée exécution : {}'.format(number,
                                                           length))        


# ## Finding common tags

# In[40]:


from operator import itemgetter

start = time.time()

dict_tags = {}

def count_tags(content_html):
    tags=dict()
    parse_html = BeautifulSoup(content_html, 'html.parser')
    for tag in parse_html.find_all():
        try:
            tags[tag.name]+=1
        except:
            tags[tag.name]=1
    
    return tags

pool = concurrent.futures.ThreadPoolExecutor(
        max_workers=5)

list_page = list(pool.map(reading_file,list_file))
list_tags = list(pool.map(count_tags,list_page))

for dic in list_tags:
    for key,value in dic.items():
        if key in dict_tags.keys():
            dict_tags[key]+=value
        else:
            dict_tags[key]=value
            
top_dict_tag = sorted(dict_tags.items(),
                      key=itemgetter(1),
                      reverse=True)

end = time.time()


print('Temps exécution : {} s '.format(round(end-start),2))
print('--'*15)
print(top_dict_tag)


# In[39]:


dict_tags


# ## Finding Common Words

# In[7]:


import re

def body_page(content_html):
    tags=dict()
    parse_html = BeautifulSoup(content_html, 'html.parser')
    
    return parse_html.find_all('body')

def clean_words(body_html):
    
    data = re.sub("<[^>]*>"," ", str(body_html))
    data = re.sub('\W'," ", data)
    data = re.sub('\d+', " ",data)
    
    words = data.split(" ")
    words = [word for word in words if len(word)>=5]
    
    return words

def count_words(list_words):
    dict_words=dict()
    
    for wd in set(list_words):
        dict_words[wd]=0
    for word in list_words:
        dict_words[word]+=1

    return dict_words
        
body = body_page(reading_file(
                       list_file[1]))

count_words(
            clean_words(body))



# In[14]:


import concurrent.futures
import time

start = time.time()

pool = concurrent.futures.ThreadPoolExecutor(max_workers=5)

liste_html = list(pool.map(reading_file,list_file))
liste_bodies = list(pool.map(body_page,liste_html))
liste_text_clean = list(pool.map(clean_words,liste_bodies))
liste_count_words = list(pool.map(count_words,liste_text_clean))

global_dic_words = dict()

for dic in liste_count_words:
    for key,value in dic.items():
        if key in global_dic_words.keys():
            global_dic_words[key]+=value
        else:
            global_dic_words[key]=value

sorted_words = sorted(global_dic_words.items(),
                      key=(lambda x:global_dic_words[x[0]]),
                      reverse=True)            
end = time.time()

print('Temps exécution : {} s '.format(round(end-start,2)))
print('--'*20)

for line in sorted_words[:25]:
    print(line)
    


# ## Parallel Excution with Process

# In[9]:


import concurrent.futures
import time

start = time.time()

pool = concurrent.futures.ProcessPoolExecutor(max_workers=3)

liste_html = list(pool.map(reading_file,list_file))
liste_bodies = list(pool.map(body_page,liste_html))
liste_text_clean = list(pool.map(clean_words,liste_bodies))
liste_count_words = list(pool.map(count_words,liste_text_clean))

global_dic_words = dict()

for dic in liste_count_words:
    for key,value in dic.items():
        if key in global_dic_words.keys():
            global_dic_words[key]+=value
        else:
            global_dic_words[key]=value

sorted_words = sorted(global_dic_words.items(),
                      key=(lambda x:global_dic_words[x[0]]),
                      reverse=True)            
end = time.time()

print('Temps exécution : {} s '.format(round(end-start,2)))
print('--'*20)

for line in sorted_words[:25]:
    print(line)
    


# ## Improving performances

# In[6]:


import re

def body_page(content_html):
    tags=dict()
    parse_html = BeautifulSoup(content_html, 'html.parser')
    
    return parse_html.find_all('body')

def clean_words(body_html):
    
    data = re.sub("<[^>]*>"," ", str(body_html))
    data = re.sub('\W'," ", data)
    data = re.sub('\d+', " ",data)
    
    words = data.split(" ")
    words = [word for word in words if len(word)>=7]
    
    return words

def count_words(list_words):
    dict_words=dict()
    
    for wd in set(list_words):
        dict_words[wd]=0
    for word in list_words:
        dict_words[word]+=1

    return dict_words        


# In[7]:


import concurrent.futures
import time

start = time.time()

pool = concurrent.futures.ThreadPoolExecutor(max_workers=5)

liste_html = list(pool.map(reading_file,list_file))
liste_bodies = list(pool.map(body_page,liste_html))
liste_text_clean = list(pool.map(clean_words,liste_bodies))
liste_count_words = list(pool.map(count_words,liste_text_clean))

global_dic_words = dict()

for dic in liste_count_words:
    for key,value in dic.items():
        if key in global_dic_words.keys():
            global_dic_words[key]+=value
        else:
            global_dic_words[key]=value

sorted_words = sorted(global_dic_words.items(),
                      key=(lambda x:global_dic_words[x[0]]),
                      reverse=True)            
end = time.time()

print('Temps exécution : {} s '.format(round(end-start,2)))
print('--'*20)

for line in sorted_words[:25]:
    print(line)
    


# In[4]:


import re

def body_page(content_html):
    tags=dict()
    parse_html = BeautifulSoup(content_html, 'html.parser')
    
    return parse_html.find_all('body')

def clean_words(body_html):
    
    data = re.sub("<[^>]*>"," ", str(body_html))
    data = re.sub('\W'," ", data)
    data = re.sub('\d+', " ",data)
    
    words = data.split(" ")
    words = [word for word in words if len(word)>=7]
    
    return words

def count_words(list_words):
    dict_words=dict()
    
    for wd in set(list_words):
        dict_words[wd]=0
    for word in list_words:
        dict_words[word]+=1

    top_word = max(dict_words.keys(),key=(lambda x:dict_words[x]))
    
    top_word_dict = dict()
    top_word_dict[top_word]  = dict_words[top_word]   
    
    return top_word_dict        


# In[5]:


import concurrent.futures
import time

start = time.time()

pool = concurrent.futures.ThreadPoolExecutor(max_workers=5)

liste_html = list(pool.map(reading_file,list_file))
liste_bodies = list(pool.map(body_page,liste_html))
liste_text_clean = list(pool.map(clean_words,liste_bodies))
liste_count_words = list(pool.map(count_words,liste_text_clean))

global_dic_words = dict()

for dic in liste_count_words:
    for key,value in dic.items():
        if key in global_dic_words.keys():
            global_dic_words[key]+=value
        else:
            global_dic_words[key]=value

sorted_words = sorted(global_dic_words.items(),
                      key=(lambda x:global_dic_words[x[0]]),
                      reverse=True)            
end = time.time()

print('Temps exécution : {} s '.format(round(end-start,2)))
print('--'*20)

for line in sorted_words[:25]:
    print(line)
    

