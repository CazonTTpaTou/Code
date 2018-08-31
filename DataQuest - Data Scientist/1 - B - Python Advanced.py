
# coding: utf-8

# In[2]:


import csv

with open("guns.csv","r") as f:
    data = list(csv.reader(f))
    
print(data[:5])    
    


# In[3]:


headers = data[0]
data = data[1:]

data[:5]


# In[6]:


years = [row[1] for row in data]

year_counts = {}

for year in years:
    try:
        year_counts[year]+=1
    except:
        year_counts[year]=1
        
print(year_counts)


# In[7]:


import datetime 

dates = [datetime.datetime(year=int(row[1]),month=int(row[2]),day=1) for row in data]

print(dates[:5])

date_counts = {}

for date in dates:
    try:
        date_counts[date]+=1
    except:
        date_counts[date]=1
        
print(date_counts)        


# In[8]:


headers


# In[12]:


def counter(number):
    count = {}
    for row in data:
        try:
            count[row[number]]+=1
        except:
            count[row[number]]=1
    return count

sex_counts = counter(5)
race_counts = counter(7)

print(sex_counts)
print('-'*30)
print(race_counts)


# In[13]:


with open("census.csv","r") as f:
    census = list(csv.reader(f))
    
print(census)    


# In[34]:


population=[3739506,40250635,15159516 + 674625,44618105,197318956]

mapping = {}
races = []

for index,race in enumerate(race_counts):
    races.insert(index,race)
    
for index,race in enumerate(races):
    mapping[race] = population[index]
    
race_per_hundredk = {}    
    
for race in mapping:
    race_per_hundredk[race] = (race_counts[race] / mapping[race]) * 100000
    
mapping
    


# In[33]:


race_counts


# In[32]:


race_per_hundredk


# In[36]:


intents = [row[3] for row in data]


# In[42]:


races = [row[7] for row in data]


# In[43]:


homicide_race_counts = {}

for index,race in enumerate(races):
    if intents[index] == 'Homicide':
        try:
            homicide_race_counts[race] += 1
        except:
            homicide_race_counts[race] = 1

homicide_race_rate = {}            
            
for race in homicide_race_counts:
    homicide_race_rate[race] = (homicide_race_counts[race] / mapping[race]) * 100000

homicide_race_rate


# In[48]:


def stats_intent(intent):

    homicide_race_counts = {}

    for index,race in enumerate(races):
        if intents[index] == intent:
            try:
                homicide_race_counts[race] += 1
            except:
                homicide_race_counts[race] = 1

    homicide_race_rate = {}            

    for race in homicide_race_counts:
        homicide_race_rate[race] = (homicide_race_counts[race] / mapping[race]) * 100000
        
    return homicide_race_rate


# In[49]:


for intent in set(intents):
    stats = stats_intent(intent)
    print('-'*35)
    print(intent)
    print(stats)
    

