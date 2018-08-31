## 1. Individual Values ##

import pandas as pd
import matplotlib.pyplot as plt

houses = pd.read_table('AmesHousing_1.txt')

houses['SalePrice'].plot.kde(xlim=(houses['SalePrice'].min(),
                                   houses['SalePrice'].max()))
                             
plt.axvline(x=houses['SalePrice'].mean(),
            label='Mean',
            color='black')  
                             
plt.axvline(x=houses['SalePrice'].mean()+houses['SalePrice'].std(ddof=0),
            label='Standard deviation',
            color='red')  
                             
plt.axvline(x=220000,
            label='220000',
            color='orange')  
                             
plt.legend()

plt.show()                             
                             
very_expensive = False

                             

## 2. Number of Standard Deviations ##

st_devs_away = (220000-houses['SalePrice'].mean())/houses['SalePrice'].std(ddof=0)

print(st_devs_away)



## 3. Z-scores ##

min_val = houses['SalePrice'].min()
mean_val = houses['SalePrice'].mean()
max_val = houses['SalePrice'].max()

def z_score(value,array,ddl):
    return (value-array.mean())/array.std(ddof=ddl)

min_z = z_score(min_val,houses['SalePrice'],0)

mean_z = z_score(mean_val,houses['SalePrice'],0)

max_z = z_score(max_val,houses['SalePrice'],0)




## 4. Locating Values in Different Distributions ##

def z_score(value, array, bessel = 0):
    mean = sum(array) / len(array)
    
    from numpy import std
    st_dev = std(array, ddof = bessel)
    
    distance = value - mean
    z = distance / st_dev
    
    return z

Neighborhood = {'North Ames' : 'NAmes', 
                'College Creek' : 'CollgCr', 
                'Old Town' : 'OldTown', 
                'Edwards' : 'Edwards', 
                'Somerset' : 'Somerst'}

response = {}    
    
for key,value in Neighborhood.items():
    data = houses[houses['Neighborhood']==value]
    response[key]=z_score(200000,data['SalePrice'])

print(response)    
    
best_investment = min(response.keys(),key=(lambda x:abs(response[x])))


    
    

## 5. Transforming Distributions ##

mean = houses['SalePrice'].mean()

st_dev = houses['SalePrice'].std(ddof = 0)

houses['z_prices'] = houses['SalePrice'].apply(
    lambda x: ((x - mean) / st_dev)
    )

z_mean_price = houses['z_prices'].mean()

z_stdev_price = houses['z_prices'].std(ddof=0)

houses['z_area'] = houses['Lot Area'].apply(lambda x:((x-houses['Lot Area'].mean())/houses['Lot Area'].std(ddof=0)))
                                                                                        
z_mean_area = houses['z_area'].mean()
                                            
z_stdev_area = houses['z_area'].std(ddof=0)                                            
                                            
                                            


## 6. The Standard Distribution ##

from numpy import std, mean
population = [0,8,0,8]

z_population = (population - mean(population)) / std(population,ddof=0)
                
mean_z = mean(z_population)
                
stdev_z = std(z_population,ddof=0)
                
                

## 7. Standardizing Samples ##

from numpy import std, mean
sample = [0,8,0,8]

x_bar = mean(sample)
s = std(sample, ddof = 1)

standardized_sample = []
for value in sample:
    z = (value - x_bar) / s
    standardized_sample.append(z)
    
stdev_sample = std(standardized_sample,ddof=1)




## 8. Using Standardization for Comparisons ##

houses['z_index1']=(houses['index_1']-houses['index_1'].mean())/houses['index_1'].std(ddof=0)

houses['z_index2']=(houses['index_2']-houses['index_2'].mean())/houses['index_2'].std(ddof=0)

houses['z_index1']=houses['z_index1'].fillna(0)
houses['z_index2']=houses['z_index2'].fillna(0)

print(houses[['z_index1','z_index2']].head(2))

if (houses['z_index1'][0]+houses['z_index2'][0])>(houses['z_index1'][1]+houses['z_index2'][1]):
    better = 'first'
else:
    better='second'
    
    

## 9. Converting Back from Z-scores ##

houses['z_merged_tr']=houses['z_merged']*10+50

mean_transformed = houses['z_merged_tr'].mean()

stdev_transformed = houses['z_merged_tr'].std(ddof=0)


