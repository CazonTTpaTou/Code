## 1. Introduction ##

import csv

with open('top100.csv','r') as f:
    music = list(csv.reader(f))
    
artists = [x[1] for x in music[1:]]



## 2. Extract the Artists using a List Comprehension ##

artists = []
for row in music[1:]:
    artists.append(row[1])
    

artists_lc = [row[1] for row in music[1:]]


    

## 3. Getting the Artist Count using a function ##

def counter(liste):
    dict_artist = dict()
    for element in liste:
        try:
            dict_artist[element]+=1
        except:
            dict_artist[element]=1
    
    return dict_artist

counts = counter(artists)




## 4. Getting the artist count using Counter() ##

from collections import Counter

artist_counts = Counter(artists)

## 5. Looping through our counts using the items() method ##

from collections import Counter
artist_counts = Counter(artists)

# Add your code here
artist_counts_list = list()

for artist,number in artist_counts.items():
    artist_counts_list.append([artist,number])
    
print(artist_counts_list)




## 6. Using a List Comprehension ##

from collections import Counter
artist_counts = Counter(artists)
artist_counts_list = []

for artist, count in artist_counts.items():
    artist_counts_list.append([artist,count])

artist_counts_two = [[artist,count] for artist, count in artist_counts.items()]

print(artist_counts_two)



## 7. Sorting our list of lists to extract the top value ##

artist_counts_list.sort()
first_artist = artist_counts_list[0]

## 8. Specifying a key when sorting our list ##

def by_count(tupl):
    return tupl[1]

artist_counts_list.sort(key=by_count,reverse=True)

top_artist = artist_counts_list[0]





## 9. Creating a function using lambda ##

f = open("top100.csv","r")
music = list(csv.reader(f))
artists = []

for row in music[1:]:
    artists.append(row[1])
from collections import Counter

artist_dict = Counter(artists)
artist_counts_lol = [[key,value] for key,value in artist_dict.items()]

artist_counts_lol.sort(key=lambda x : x[1],reverse=True)
lambda_top_artist = artist_counts_lol[0:1]




## 10. Creating a Pipeline using Modularization ##

from collections import Counter
import csv
# Add your functions here
def read_data(filename):
    with open(filename,'r') as f:
        return list(csv.reader(f))

def clean_data(liste):
    liste_artist = [lis[1] for lis in liste]
    data = Counter(liste_artist)
    return [[key,value] for key,value in data.items()]

def top_artist(list_tuple):
    list_tuple.sort(key=lambda x:x[1],reverse=True)
    return list_tuple[0]
              
# Uncomment when ready
music_as_list = read_data("top100.csv")
sorted_lol = clean_data(music_as_list)
most_popular_artist = top_artist(sorted_lol)










## 11. How to deal with errors ##

cleaned_list = []
for row in music_sample[1:]:
    try:
        cleaned_list.append([row[0],row[1],float(row[-1])])
    except:
        "Pass"

## 12. Passing new data into our pipeline ##

f = open("top100.csv","r")
music_all = list(csv.reader(f))

from collections import Counter

def extract_artist(music):
    return [row[1] for row in music[1:]]

def get_count(artists):
    artist_dict = Counter(artists)
    return [[key,value] for key,value in artist_dict.items()]

def sort_by_streams(artist_counts):
    artist_counts.sort(key=lambda x: x[1], reverse=True)
    return artist_counts

# Add your code here
artists = extract_artist(music_all)
artist_counts = get_count(artists)
top = sort_by_streams(artist_counts)