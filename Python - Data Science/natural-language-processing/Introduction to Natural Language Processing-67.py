## 2. Overview of the Data ##

import pandas as pd
submissions = pd.read_csv("sel_hn_stories.csv")
submissions.columns = ["submission_time", "upvotes", "url", "headline"]
submissions = submissions.dropna()

## 3. Tokenizing the Headlines ##

import re

tokenized_headlines = []

for row in submissions['headline'] :
    #row_split = re.split('\s+',row)
    row_split = row.split()
    tokenized_headlines.append(row_split)
    
    
    

## 4. Preprocessing Tokens to Increase Accuracy ##

import string

punctuation = [",", ":", ";", ".", "'", '"', "’", "?", "/", "-", "+", "&", "(", ")"]
clean_tokenized = []

for headline in tokenized_headlines:
    head=list()
    for word in headline:
        word_lower = word.lower()
        clean_word = "".join([w for w in word_lower if w not in punctuation])
        #clean_word = word_lower.translate(string.punctuation)
        head.append(clean_word)
    clean_tokenized.append(head)
    
    
    

## 5. Assembling a Matrix of Unique Words ##

import numpy as np
from collections import Counter

unique_tokens = []
single_tokens = []

for headline in clean_tokenized:
    for word in headline:
        if word not in single_tokens:
            single_tokens.append(word)
        else:
            unique_tokens.append(word)

unique = set(unique_tokens)

matrice = np.zeros((len(clean_tokenized),len(unique)))

counts = pd.DataFrame(data=matrice,
                      index=np.arange(len(clean_tokenized)),
                      columns=unique)





## 6. Counting Token Occurrences ##

# We've already loaded in clean_tokenized and counts

for index,headline in enumerate(clean_tokenized):
    for word in headline:
        if word in counts.columns.tolist():
            counts.loc[index,word]+=1

            

## 7. Removing Columns to Increase Accuracy ##

# We've already loaded in clean_tokenized and counts

word_counts = counts.sum()

conditions_keeping = (word_counts >=5) & (word_counts<=100)

counts = counts.loc[:,conditions_keeping]



## 8. Splitting the Data Into Train and Test Sets ##

from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(counts,
                                                    submissions["upvotes"], 
                                                    test_size=0.2, 
                                                    random_state=1)





## 9. Making Predictions With fit() ##

from sklearn.linear_model import LinearRegression

clf = LinearRegression()

clf.fit(X_train,
        y_train)

predictions = clf.predict(X_test)




## 10. Calculating Prediction Error ##

mse = ((y_test-predictions)**2).sum() / len(y_test)

rmse = mse ** (1/2)

print('---'*20)
print(mse)
print('---'*20)
print(rmse)
print('---'*20)
print(y_test.mean())
print('---'*20)
print(y_test.std())
print('---'*20)

