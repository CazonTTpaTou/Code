## 1. Movie Quotes Data ##

import os

def open_file(filename):
    with open(filename,'r',encoding='UTF-8') as f:
        print(f.readlines())
    print('--'*20)

open_file('lines/theprincessbride.txt')    
    
open_file('lines/theroadwarrior.txt')  

print(os.listdir())
        










## 2. The Concurrent Futures Package ##

import concurrent.futures
import math

numbers = [1,10,20,50]

def square(number):
    return math.sqrt(number)

pool = concurrent.futures.ProcessPoolExecutor(max_workers=5)

roots = list(pool.map(square,numbers))





## 3. Reading In Files ##

import concurrent.futures

pool = concurrent.futures.ThreadPoolExecutor(max_workers=5)

def count_line(filename):
    filename_dir = 'lines/'+ filename
    with open(filename_dir,'r',encoding='utf-8') as f:
        return len(f.readlines())

list_files = list(os.listdir('lines'))
    
lengths = list(pool.map(count_line,list_files))

movie_lengths = dict()

for length,filename in zip (lengths,list_files):
    movie_lengths[filename] = length
    
most_lines = max(movie_lengths.keys(),key=(lambda x : movie_lengths[x]))

print('Movie : {} - with {} lines'.format(most_lines,movie_lengths[most_lines]))


    

## 4. Finding The Longest Lines ##

import concurrent.futures

lo = [('rt',2,'rt'),
      ('oioj',4,'rt'),
      ('hgf',3,'rt'),
      ('hhhhhhhhhhhh',9,'rt'),
      ('olm',3,'rt')]

pool = concurrent.futures.ThreadPoolExecutor(max_workers=5)

def longest(list_lines):
    return max(list_lines,key=(lambda x:len(x)))

def longest_line(filename):
    filename_dir = 'lines/' + filename
    
    with open(filename_dir,'r',encoding='utf-8') as f:
        the_longest_line = longest(f.readlines())
    
    return filename,len(the_longest_line),the_longest_line

list_dir = list(os.listdir('lines'))

longest_movie = list(pool.map(longest_line,list_dir))

line_movie = max(longest_movie,key=(lambda x:x[1]))
#line_movie = max(lo,key=(lambda x:x[1]))
longest_line_movie = line_movie[0]
longest_line = line_movie[2]

print(longest_line_movie)
print(longest_line)
               

## 5. Finding The Most Commonly Used Word ##

import concurrent.futures
import time

start = time.time()
common_words = dict()

pool = concurrent.futures.ThreadPoolExecutor(max_workers=2)

list_dir = list(os.listdir('lines'))

def most_common_word(filename):
    file = 'lines/' + filename
    
    with open(file,'r',encoding='UTF-8') as f:
        dict_words=dict()        
        words = f.read().split(" ")
        
    for word in words:
            try:
                dict_words[word.strip()]+=1
            except:
                dict_words[word.strip()]=1
    
    return filename,max(dict_words.keys(),key=(lambda x:dict_words[x]))

words = list(pool.map(most_common_word,list_dir))

common_words = {word[0] : word[1] for word in words}

#for file in list_dir[:1]:
    #print(most_common_word(file))
    #common_words[word[0]] =word[1]
    
end = time.time()

length = end - start

print(length)

print(common_words)



## 7. Debugging Errors ##

import concurrent.futures
from collections import Counter

def most_common_word(filename):
    with open(filename) as f:
        words = f.read().split(" ")
    count = Counter(words)

    return count.most_common()[0][0]

results = []
pool = concurrent.futures.ProcessPoolExecutor(max_workers=2)
filenames = ["lines/{}".format(f) for f in os.listdir("lines")]
words = pool.map(most_common_word, filenames)
words = list(words)

common_words = {}
for i in range(len(lengths)):
    common_words[filenames[i].replace("lines/", "")] = words[i]

## 8. Removing Punctuation ##

import concurrent.futures
import time
import re

start = time.time()
common_words = dict()

pool = concurrent.futures.ThreadPoolExecutor(max_workers=2)

list_dir = list(os.listdir('lines'))

def most_common_word(filename):
    file = 'lines/' + filename
    dict_words=dict()        
    with open(file,'r',encoding='UTF-8') as f:
        data = f.read().lower()
    
    data = re.sub('\W'," ",data)
    words = data.split(" ")
    words = [word for  word in words if len(word)>=5]

    for word in words:
        try:
            dict_words[word]+=1
        except:
            dict_words[word]=1
    
    return filename,max(dict_words.keys(),key=(lambda x:dict_words[x]))

words = list(pool.map(most_common_word,list_dir))

common_words = {word[0] : word[1] for word in words}
    
end = time.time()
length = end - start

print(length)


## 9. Finding Word Frequencies ##

import concurrent.futures
import time
import re
from operator import itemgetter

start = time.time()
total_word_counts = dict()

pool = concurrent.futures.ThreadPoolExecutor(max_workers=2)

list_dir = list(os.listdir('lines'))

def most_common_word(filename):
    file = 'lines/' + filename
    dict_words=dict()        
    with open(file,'r',encoding='UTF-8') as f:
        data = f.read().lower()
    
    data = re.sub('\W'," ",data)
    words = data.split(" ")
    words = [word for  word in words if len(word)>=5]

    for word in words:
        try:
            dict_words[word]+=1
        except:
            dict_words[word]=1
    
    return dict_words

words = list(pool.map(most_common_word,list_dir))

for word in words:
    for key,value in word.items():
        try:
            total_word_counts[key]+=value
        except:
            total_word_counts[key]=value

top = sorted(total_word_counts.items(),
             key=itemgetter(1),
             reverse=True)

top_200 = top[:200]

end = time.time()
length = end - start

print(length)
print('--'*20)
print(top_200)
