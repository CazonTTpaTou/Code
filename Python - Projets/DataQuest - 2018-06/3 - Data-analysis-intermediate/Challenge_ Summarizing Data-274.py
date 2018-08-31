## 2. Introduction to the Data ##

import pandas as pd

all_ages = pd.read_csv('all-ages.csv')
recent_grads = pd.read_csv('recent-grads.csv')

all_ages.iloc[:5,:]
recent_grads.iloc[:5,:]





## 3. Summarizing Major Categories ##

# Unique values in Major_category column.
print(all_ages['Major_category'].unique())

aa_cat_counts = dict()
rg_cat_counts = dict()

for major in all_ages['Major_category'].unique():
    aa_cat_counts[major] = all_ages['Total'][all_ages['Major_category']==major].sum()

for major in recent_grads['Major_category'].unique():
    rg_cat_counts[major] = recent_grads['Total'][recent_grads['Major_category']==major].sum()

    
    
    

## 4. Low-Wage Job Rates ##

low_wage_proportion = recent_grads['Low_wage_jobs'].sum() / recent_grads['Total'].sum()

print(low_wage_proportion)



## 5. Comparing Data Sets ##

# All majors, common to both DataFrames
majors = recent_grads['Major'].unique()
rg_lower_count = 0

def comparaison_note(row):
    if row['Unemployment_rate'] > row['Unemployment_rate_recent']:
        return 1
    all_ages['Unemployment_rate_recent']=0    
    
for major in majors:
    
    if all_ages['Unemployment_rate'][all_ages['Major']==major].max()>recent_grads['Unemployment_rate'][recent_grads['Major']==major].max():
        
        rg_lower_count += 1
    
print(rg_lower_count)        
        