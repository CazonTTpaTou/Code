## 3. Statistical significance ##

import numpy as np
import matplotlib.pyplot as plt

mean_group_a = np.mean(weight_lost_a)

mean_group_b = np.mean(weight_lost_b)

print(mean_group_a)
print(mean_group_b)

plt.hist(weight_lost_a,color='red')
plt.show()

plt.hist(weight_lost_b,color='blue')
plt.show()




## 4. Test statistic ##

mean_difference = mean_group_b - mean_group_a

print(mean_difference)

## 5. Permutation test ##

import numpy as np

mean_difference = 2.52
print(all_values)

mean_differences = []

for number in range(1000):
    group_a=[]
    group_b=[]
    for value in all_values:
        if(np.random.rand(1)[0]>0.5):
            group_a.append(value)
        else:
            group_b.append(value)
    iteration_mean_difference = np.mean(group_b)-np.mean(group_a)
    mean_differences.append(iteration_mean_difference)
    
plt.hist(mean_differences)

plt.show()





## 7. Dictionary representation of a distribution ##

sampling_distribution = {}

for value in mean_differences:
    if sampling_distribution.get(value,False):
        sampling_distribution[value]+=1
    else:
        sampling_distribution[value]=1

        



## 8. P value ##

frequencies = []
number_permuatations = 1000

for key,value in sampling_distribution.items():
    if key >= 2.52:
        frequencies.append(value)
        
p_value = sum(frequencies) / number_permuatations

print(p_value)

