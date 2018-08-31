## 1. Simplifying Data ##

import pandas as pd

pd.options.display.max_rows = 200
pd.options.display.max_columns = 50

data = pd.read_csv('wnba.csv')
data.shape


## 2. Frequency Distribution Tables ##

wnba = pd.read_csv('wnba.csv')

freq_distro_pos = wnba['Pos'].value_counts()

freq_distro_height = wnba['Height'].value_counts()

## 3. Sorting Frequency Distribution Tables ##

wnba = pd.read_csv('wnba.csv')

age_ascending = wnba['Age'].value_counts().sort_index()

age_descending = wnba['Age'].value_counts().sort_index(ascending=False)




## 4. Sorting Tables for Ordinal Variables ##

def make_pts_ordinal(row):
    if row['PTS'] <= 20:
        return 'very few points'
    if (20 < row['PTS'] <=  80):
        return 'few points'
    if (80 < row['PTS'] <=  150):
        return 'many, but below average'
    if (150 < row['PTS'] <= 300):
        return 'average number of points'
    if (300 < row['PTS'] <=  450):
        return 'more than average'
    else:
        return 'much more than average'
    
wnba['PTS_ordinal_scale'] = wnba.apply(make_pts_ordinal, axis = 1)

pts_ordinal_desc = wnba['PTS_ordinal_scale'].value_counts().iloc[[4,3,0,2,1,5]]

## 5. Proportions and Percentages ##

wnba = pd.read_csv('wnba.csv')

def over_30(value):
    if value<=23:
        return "below_23"
    if value>=30:
        return "over_30"
    else:
        return "other"

wnba['Age_classe'] = wnba['Age'].apply(over_30)    
    
proportion_25 = round(wnba['Age'].value_counts(normalize=True).loc[25] * 100,2)

percentage_30 = round(wnba['Age'].value_counts(normalize=True).loc[30]*100,2)

percentage_over_30 = round(wnba['Age_classe'].value_counts(normalize=True).loc['over_30']*100,3)

percentage_below_23 = round(wnba['Age_classe'].value_counts(normalize=True).loc['below_23']*100,3)




## 6. Percentiles and Percentile Ranks ##

from scipy.stats import percentileofscore

wnba = pd.read_csv('wnba.csv')

percentile_rank_half_less = percentileofscore(a = wnba['Games Played'], 
                                              score = 17, 
                                              kind = 'weak')

percentage_half_more = 100-percentile_rank_half_less



## 7. Finding Percentiles with pandas ##

wnba = pd.read_csv('wnba.csv')

age_upper_quartile = wnba.describe().iloc[6]

age_middle_quartile = wnba.describe().iloc[5]

age_95th_percentile = wnba.describe(percentiles=[.95]).iloc[4]

question_1 = True

question_2 = False

question_3 = True



## 8. Grouped Frequency Distribution Tables ##

wnba = pd.read_csv('wnba.csv')

grouped_freq_table = wnba['PTS'].value_counts(bins=10,normalize=True).sort_index(ascending=False) *100





## 9. Information Loss ##

import pandas as pd

numbers=[1,2,3,5,10,15,20,40]
for number in numbers:
    value = wnba['MIN'].value_counts(bins=number).sort_index(ascending=True) 
    print('---'*10)
    print(value)


## 10. Readability for Grouped Frequency Tables ##

import numpy as np

wnba = pd.read_csv('wnba.csv')

intervals = pd.interval_range(start = 0, end = 600, freq = 60)

gr_freq_table_10 = pd.Series(np.zeros(10,dtype=np.int8),index=intervals)

for value in wnba['PTS']:
    for interval in intervals:
        if value in interval:
            gr_freq_table_10.loc[interval]+=1
            
print(gr_freq_table_10)

print(gr_freq_table_10.sum())

