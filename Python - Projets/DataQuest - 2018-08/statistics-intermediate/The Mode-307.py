## 1. Introduction ##

import pandas as pd

houses = pd.read_table('AmesHousing_1.txt',sep='\t')

land_slope = houses['Land Slope']
land_slope.head()
scale_land = 'ordinal'

roof_style = houses['Roof Style']
roof_style.unique()
scale_roof = 'nominal'

kitchen = houses['Kitchen AbvGr']
kitchen.unique()
kitchen_variable = 'discrete'


## 2. The Mode for Ordinal Variables ##

def mode_function(array):
    dict_values={}
    unique_array = set(array)
    
    for value in unique_array:
        dict_values[value]=0
        
    for row in array:
        dict_values[row]+=1
        
    return max(dict_values.keys(),key=(lambda k: dict_values[k]))
        
mode_function = mode_function(houses['Land Slope'])

mode_method = houses['Land Slope'].mode()

same = mode_function == mode_method



## 3. The Mode for Nominal Variables ##

# The function we wrote (you can copy-paste yours from the previous screen)
def mode(array):
    counts = {}
    
    for value in array:
        if value in counts:
            counts[value] += 1
        else:
            counts[value] = 1
    
    return max(counts, key = counts.get)
def mode(array):
    counts = {}
    
    for value in array:
        if value in counts:
            counts[value] += 1
        else:
            counts[value] = 1
    
    return (max(counts, key = counts.get),
            counts
           )

mode, value_counts = mode(houses['Roof Style'])

## 4. The Mode for Discrete Variables ##

bedroom_variable = 'discrete'

bedroom_mode = houses['Bedroom AbvGr'].mode()

price_variable = 'continuous'

price_mode = houses['SalePrice'].mode()

## 5. Special Cases ##

intervals = pd.interval_range(start = 0, end = 800000, freq = 100000)
gr_freq_table = pd.Series([0,0,0,0,0,0,0,0], 
                          index = intervals)

for value in houses['SalePrice']:
    for interval in intervals:
        if value in interval:
            gr_freq_table.loc[interval] += 1
            break

print(gr_freq_table)

eff = gr_freq_table.reset_index()
maxi = 0
print(eff)

for row in gr_freq_table.items():     
    if row[1] > maxi:
        maxi = row[1]
        mode = int((row[0].left + row[0].right) / 2)

midpoint = mode

mean = houses['SalePrice'].mean()

median = houses['SalePrice'].median()

sentence_1 = True
sentence_2 = True

        
    

## 6. Skewed Distributions ##

distribution_1 = {'mean': 3021 , 'median': 3001, 'mode': 2947}
distribution_2 = {'median': 924 , 'mode': 832, 'mean': 962}
distribution_3 = {'mode': 202, 'mean': 143, 'median': 199}

shape_1 = 'right skew'
shape_2 = 'right skew'
shape_3 = 'left skew'

## 7. Symmetrical Distributions ##

import matplotlib.pyplot as plt

houses['Mo Sold'].plot.kde(xlim=(1,12))

plt.axvline(x=houses['Mo Sold'].mode().item(),label='Mode')

plt.axvline(x=houses['Mo Sold'].median(),label='Median')

plt.axvline(x=houses['Mo Sold'].mean(),label='Mean')

plt.legend()

plt.show()

