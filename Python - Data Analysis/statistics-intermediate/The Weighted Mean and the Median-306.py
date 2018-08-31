## 1. Introduction ##

mean_new = houses_per_year['Mean Price'].mean()

mean_original = houses['SalePrice'].mean()

difference = mean_original - mean_new

print(difference)






## 2. Different Weights ##

print(houses_per_year.head())

houses_per_year['Sum Price']=houses_per_year['Mean Price']*houses_per_year['Houses Sold']

weighted_mean = houses_per_year['Sum Price'].sum() / houses_per_year['Houses Sold'].sum()

mean_original = houses['SalePrice'].mean()

difference = round(mean_original,10) - round(weighted_mean,10)













## 3. The Weighted Mean ##

import numpy as np

def compute_weighth_mean(mean,weight):
    total=0
    for row_weight,row_mean in zip(weight,mean):
        total+=row_weight*row_mean
    return total / sum(weight)

weighted_mean_function = compute_weighth_mean(
                            houses_per_year['Mean Price'],
                            houses_per_year['Houses Sold'])

weighted_mean_numpy = np.average(houses_per_year['Mean Price'],
                                 weights=houses_per_year['Houses Sold'])

equal = round(weighted_mean_function,10) == round(weighted_mean_numpy,10)



## 4. The Median for Open-ended Distributions ##

distribution1 = [23, 24, 22, '20 years or lower,', 23, 42, 35]
distribution2 = [55, 38, 123, 40, 71]
distribution3 = [45, 22, 7, '5 books or lower', 32, 65, '100 books or more']

median1=23
median2=55
median3=32


## 5. Distributions with Even Number of Values ##

houses_new = houses.copy()
houses_new['TotRms AbvGrd'] = houses_new['TotRms AbvGrd'].replace('10 or more',10)
houses_new['TotRms AbvGrd'] = houses_new['TotRms AbvGrd'].astype(int)

sorted_houses = houses_new['TotRms AbvGrd'].sort_values()

if len(sorted_houses) % 2 == 0 :
    index_median=int(len(sorted_houses)/2)
    median=sum(sorted_houses.iloc[[index_median,index_median+1]])/2
else:
    index_median=int(len(sorted_houses)/2)+1
    median=sum(sorted_houses.iloc[[index_median]])
    
print(median)



## 6. The Median as a Resistant Statistic ##

houses['Lot Area'].plot.box()

houses['SalePrice'].plot.box()

lotarea_difference = houses['Lot Area'].mean() - houses['Lot Area'].median()

saleprice_difference = houses['SalePrice'].mean() - houses['SalePrice'].median()




## 7. The Median for Ordinal Scales ##

mean = houses['Overall Cond'].mean()
median = houses['Overall Cond'].median()

houses['Overall Cond'].plot.hist()

more_representative = 'mean'