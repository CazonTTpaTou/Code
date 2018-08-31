## 3. Exploring the Data ##

import pandas as pd

avengers = pd.read_csv("avengers.csv")
avengers.head(5)

## 4. Filtering Out Bad Data ##

import matplotlib.pyplot as plt
true_avengers = pd.DataFrame()

avengers['Year'].hist()

true_avengers = avengers[avengers['Year']>=1960]



## 5. Consolidating Deaths ##

def count_death(df):
    total = 0
    columns = ['Death1','Death2','Death3','Death4','Death5']
    
    for col in columns:
        if df[col] == 'YES':
            total +=1
    
    return total

true_avengers['Deaths'] = true_avengers.apply(count_death,axis=1)

#verif = true_avengers[['Death1','Death2','Deaths']]
#print(verif.head(15))


## 6. Verifying Years Since Joining ##

joined_accuracy_count  = int()

def check_year_joining(df):
    delta = df['Years since joining']-df['Year']
    if interval == 0:
        return 1
    else:
        return 0

#joined_accuracy_count = true_avengers[true_avengers['Years since joining']==true_avengers['Year']].count()

joined_accuracy_count = len(true_avengers[true_avengers['Years since joining']==(2015-true_avengers['Year'])])
