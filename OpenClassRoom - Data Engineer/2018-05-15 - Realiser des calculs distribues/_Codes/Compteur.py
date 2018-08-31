def count_visits(logs):    
    visits = {}
    for user in logs:
        if user not in visits:
            visits[user] = 1
        else:
            visits[user] += 1
    return visits

################################################################

from collections import defaultdict

def wordCount(text):
    counts=defaultdict(int)
    for word in text.split():
        counts[word.lower()] +=1
    return counts    

################################################################

def map(key,value):
    intermediate=[]
    for word in value.split():
        intermediate.append((word, 1))
    return intermediate    

def reduce(key, values):
    result = 0
    for c in values:
        result = result +c
    return (key, result)  


  