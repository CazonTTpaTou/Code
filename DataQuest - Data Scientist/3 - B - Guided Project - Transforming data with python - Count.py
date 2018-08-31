import read
import collections

df = read.load_data()
headlines=[]

for index,line in df.iterrows():
    headlines.append(str(line['headline']))
    
headline=' '.join(headlines)

words=headline.lower().split(" ")

counter={}

for word in words:
    try:
        counter[word]+=1
    except:
        counter[word]=1
        
print(collections.Counter(counter).most_common(100))

    
