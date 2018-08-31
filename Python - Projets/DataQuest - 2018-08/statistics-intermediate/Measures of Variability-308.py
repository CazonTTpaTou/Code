## 1. The Range ##

import pandas as pd
houses = pd.read_table('AmesHousing_1.txt')

range_by_year = {}

def calcul_etendue(array):
    return array.max() - array.min()

for value in set(houses['Yr Sold']):
    condition_year = houses['Yr Sold'] == value
    data_year=houses['SalePrice'][condition_year]                  
    range_by_year[value]=calcul_etendue(data_year)

maxi_variability =max(range_by_year.keys(),key=(lambda x: range_by_year[x]))                 
                 
one = maxi_variability == 2008

two = ((range_by_year[2007]>range_by_year[2008])
       &
       (range_by_year[2007]>range_by_year[2009])
       &
       (range_by_year[2010]>range_by_year[2009])
       )

                 
     

## 2. The Average Distance ##

C = [1,1,1,1,1,1,1,1,1,21]

def compute_distance(array):
    distances=[]
    mean=sum(array)/len(array)
    for value in array:
        distances.append(value-mean)
    return sum(distances)/len(distances)

avg_distance = compute_distance(C)

print(avg_distance)


## 3. Mean Absolute Deviation ##

C = [1,1,1,1,1,1,1,1,1,21]

def mean_absolute_deviation(array):
    distances=[]
    mean=sum(array)/len(array)
    for value in array:
        distances.append(abs(value-mean))
    return sum(distances)/len(distances)

mad = mean_absolute_deviation(C)

print(mad)




## 4. Variance ##

C = [1,1,1,1,1,1,1,1,1,21]

def mean_squared_distance(array):
    distances=[]
    mean=sum(array)/len(array)
    for value in array:
        distances.append((value-mean)*(value-mean))
    return sum(distances)/len(distances)

variance_C = mean_squared_distance(C)

print(variance_C)




## 5. Standard Deviation ##

from math import sqrt
C = [1,1,1,1,1,1,1,1,1,21]

def standard_deviation(array):
    distances=[]
    mean=sum(array)/len(array)
    for value in array:
        distances.append((value-mean)**2)
    return (sum(distances)/len(distances))**(1/2)

standard_deviation_C = standard_deviation(C)

print(standard_deviation_C)



## 6. Average Variability Around the Mean ##

year_variability = {}

def standard_deviation(array):
    reference_point = sum(array) / len(array)
    
    distances = []
    for value in array:
        squared_distance = (value - reference_point)**2
        distances.append(squared_distance)
        
    variance = sum(distances) / len(distances)
    
    return sqrt(variance)

for year in houses['Yr Sold'].unique():
    prices_year = houses['SalePrice'][houses['Yr Sold']==year]
    year_variability[year]=standard_deviation(prices_year)
    
greatest_variability = max(year_variability.keys(),key=(lambda x: year_variability[x]))

lowest_variability = min(year_variability.keys(),key=(lambda x : year_variability[x]))

    
    
    

## 7. A Measure of Spread ##

sample1 = houses['Year Built'].sample(50, random_state = 1)
sample2 = houses['Year Built'].sample(50, random_state = 2)

def standard_deviation(array):
    reference_point = sum(array) / len(array)
    
    distances = []
    for value in array:
        squared_distance = (value - reference_point)**2
        distances.append(squared_distance)
    
    variance = sum(distances) / len(distances)
    
    return sqrt(variance)

bigger_spread = 'sample 2'

st_dev1 = standard_deviation(sample1)
st_dev2 = standard_deviation(sample2)

## 8. The Sample Standard Deviation ##

import matplotlib.pyplot as plt

list_sd = []

def standard_deviation(array):
    reference_point = sum(array) / len(array)
    
    distances = []
    for value in array:
        squared_distance = (value - reference_point)**2
        distances.append(squared_distance)
    
    variance = sum(distances) / len(distances)
    
    return sqrt(variance)



for number in range(5000):
    echantillon = houses.sample(10,random_state=number)
    list_sd.append(standard_deviation(echantillon['SalePrice']))
    
plt.hist(list_sd)

plt.axvline(x=standard_deviation(houses['SalePrice']))




    
    



## 9. Bessel's Correction ##

def standard_deviation(array):
    reference_point = sum(array) / len(array)
    
    distances = []
    for value in array:
        squared_distance = (value - reference_point)**2
        distances.append(squared_distance)
    
    variance = sum(distances) / len(distances)
    
    return sqrt(variance)

import matplotlib.pyplot as plt
st_devs = []

for i in range(5000):
    sample = houses['SalePrice'].sample(10, random_state = i)
    st_dev = standard_deviation(sample)
    st_devs.append(st_dev)
    
#plt.hist(st_devs)
#plt.axvline(standard_deviation(houses['SalePrice']))
def standard_deviation(array):
    reference_point = sum(array) / len(array)
    
    distances = []
    for value in array:
        squared_distance = (value - reference_point)**2
        distances.append(squared_distance)
    
    variance = sum(distances) / (len(distances) - 1)
    
    return sqrt(variance)

import matplotlib.pyplot as plt
st_devs = []

for i in range(5000):
    sample = houses['SalePrice'].sample(10, random_state = i)
    st_dev = standard_deviation(sample)
    st_devs.append(st_dev)
    
plt.hist(st_devs)
plt.axvline(standard_deviation(houses['SalePrice']))

## 10. Standard Notation ##

sample = houses.sample(100, random_state = 1)
from numpy import std, var

pandas_stdev = sample['SalePrice'].std(ddof=1)

numpy_stdev = std(sample['SalePrice'],ddof=1)

equal_stdevs = pandas_stdev == numpy_stdev

pandas_var = sample['SalePrice'].var(ddof=1)

numpy_var = var(sample['SalePrice'],ddof=1)

equal_vars = pandas_var == numpy_var






## 11. Sample Variance — Unbiased Estimator ##

from numpy import std,var

population = [0, 3, 6]

samples = [[0,3], [0,6],
           [3,0], [3,6],
           [6,0], [6,3]
          ]

stds=[]
variances=[]

for sample in samples:
    stds.append(std(sample,ddof=1))
    variances.append(var(sample,ddof=1))

equal_var = sum(variances)/len(variances) == var(population)    
 
equal_stdev = sum(stds)/len(stds) == std(population)    
  
    
    