#################################################################################
import itertools
from itertools import chain, combinations

stuff = [1, 2, 3]

#################################################################################

for L in range(0, len(stuff)+1):
    for subset in itertools.combinations(stuff, L):
        print(subset)


print('--'*50) 
#################################################################################

def all_subsets(ss):
    return chain(*map(lambda x: combinations(ss, x), range(0, len(ss)+1)))

for subset in all_subsets(stuff):
    print(subset)

print('--'*50) 
#################################################################################

number_arrangement = 2

for subset in itertools.combinations(stuff, number_arrangement):
        print(subset)
        print(type(subset))

#################################################################################

print('--'*50) 
#################################################################################

number_arrangement = 2

for subset in itertools.permutations(stuff, number_arrangement):
        print(subset)

print('--'*50) 
#################################################################################

population = [3, 7, 2]
number_arrangement = 2

sample = []
mean_sample = []

for subset in itertools.permutations(population, number_arrangement):
    sample.append(subset)

for samp in sample:
    moyenne = sum(samp) /len(samp)
    mean_sample.append(moyenne)
        
statistics_mean = (sum(mean_sample)/len(mean_sample))
parameters_mean = (sum(population)/len(population))

unbiased = statistics_mean == parameters_mean

print(unbiased)
print(statistics_mean)
print(parameters_mean)

print('--'*50) 
#################################################################################


