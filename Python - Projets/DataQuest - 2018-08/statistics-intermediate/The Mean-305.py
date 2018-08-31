## 2. The Mean ##

distribution = [0,2,3,3,3,4,13]
above = []
below = []

mean= sum(distribution)/len(distribution)

center = int(mean) == int((distribution[0]+distribution[-1])/2)

for value in distribution:
    if value < mean:
        below.append(mean-value)
    else:
        above.append(value-mean)
        
equal_distances = sum(below) == sum(above)


        

## 3. The Mean as a Balance Point ##

from numpy.random import randint, seed

equal_distances = []

def mean_value(dist):
    return sum(dist)/len(dist)

def check_egality_below_above_mean(distribution):
    mean = mean_value(distribution)
    for value in distribution:
        if value < mean:
            below.append(mean-value)
        else:
            above.append(value-mean)
    return (round(sum(below),1) == round(sum(above),1))

def random_distribution_generator(number):
    seed(number)
    
    return randint(0,1000,10)

for number_trial in range(5000):
    equal_distances.append(
            check_egality_below_above_mean(
                            random_distribution_generator(number_trial)))
    
print(sum(equal_distances))


    
                        
    
    

## 4. Defining the Mean Algebraically ##

one = False
two = False
three = False

## 5. An Alternative Definition ##

distribution_1 = [42, 24, 32, 11]
distribution_2 = [102, 32, 74, 15, 38, 45, 22]
distribution_3 = [3, 12, 7, 2, 15, 1, 21]

def sigma(numbers):
    total = 0
    for number in numbers:
        total+=number
    return total

mean_1 = sigma(distribution_1)/len(distribution_1)
mean_2 = sigma(distribution_2)/len(distribution_2)
mean_3 = sigma(distribution_3)/len(distribution_3)




## 6. Introducing the Data ##

import pandas as pd

AmesHousing = pd.read_table('AmesHousing_1.txt',sep='\t')

one = True
two = False
three = True




## 7. Mean House Prices ##

import pandas as pd

AmesHousing = pd.read_table('AmesHousing_1.txt',sep='\t')

def mean(distribution):
    sum_distribution = 0
    for value in distribution:
        sum_distribution += value
        
    return sum_distribution / len(distribution)

function_mean = mean(AmesHousing['SalePrice'])

pandas_mean = AmesHousing['SalePrice'].mean()

means_are_equal = function_mean == pandas_mean



## 8. Estimating the Population Mean ##

parameter = houses['SalePrice'].mean()
sample_size = 5

sample_sizes = []
sampling_errors = []

for i in range(100):
    sample = houses['SalePrice'].sample(sample_size , random_state = i)
    statistic = sample.mean()
    sampling_error = parameter - statistic
    sampling_errors.append(sampling_error)
    sample_sizes.append(sample_size)
    sample_size += 29
    
import matplotlib.pyplot as plt
plt.scatter(sample_sizes, sampling_errors)
plt.axhline(0)
plt.axvline(2930)
plt.xlabel('Sample size')
plt.ylabel('Sampling error')

## 9. Estimates from Low-Sized Samples ##

import pandas as pd
import matplotlib.pyplot as plt

AmesHousing = pd.read_table('AmesHousing_1.txt',sep='\t')
parameter = AmesHousing['SalePrice'].mean()

error_sampling = []

def generate_mean_sample(number):
    sample = AmesHousing.sample(100,random_state=number)
    return sample['SalePrice'].mean()

for num in range(10000):
    error_sampling.append(generate_mean_sample(num))
    
plt.hist(error_sampling)
plt.axvline(x=parameter)

plt.xlabel('Sample mean')
plt.ylabel('Frequency')
plt.xlim(0,500000)

plt.show()



## 11. The Sample Mean as an Unbiased Estimator ##

population = [3, 7, 2]
samples = [[3, 7], [3, 2],
           [7, 2], [7, 3],
           [2, 3], [2, 7]
          ]

sample_means = []
for sample in samples:
    sample_means.append(sum(sample) / len(sample))
    
population_mean = sum(population) / len(population)
mean_of_sample_means = sum(sample_means) / len(sample_means)

unbiased = (population_mean == mean_of_sample_means)