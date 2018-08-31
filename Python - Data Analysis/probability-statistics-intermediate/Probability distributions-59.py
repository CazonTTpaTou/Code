## 3. Bikesharing distribution ##

import pandas
bikes = pandas.read_csv("bike_rental_day.csv")

prob_over_5000 = sum(bikes['cnt']>5000) / len(bikes)



## 4. Computing the distribution ##

from  math import factorial

# Each item in this list represents one k, starting from 0 and going up to and including 30.
outcome_probs=[]
outcome_counts = list(range(31))
proba = 0.39

def binomial(n,k,p,q):
    combinaison = factorial(n)/(factorial(k)*factorial(n-k))
    return (p**k) * (q**(n-k)) * combinaison

for day in outcome_counts:    
    outcome_probs.append(binomial(len(outcome_counts)-1,
                                  day,                                  
                                  proba,
                                  1-proba
                                  ))
    
    


## 5. Plotting the distribution ##

import matplotlib.pyplot as plt

# The most likely number of days is between 10 and 15.
plt.bar(outcome_counts, outcome_probs)
plt.show()

## 6. Simplifying the computation ##

import scipy
from scipy import linspace
from scipy.stats import binom
import matplotlib.pyplot as plt

# Create a range of numbers from 0 to 30, with 31 elements (each number has one entry).
outcome_counts = linspace(0,30,31)

dist = binom.pmf(outcome_counts,30,0.39)

plt.bar(outcome_counts,dist)

plt.show()







## 8. Computing the mean of a probability distribution ##

dist_mean = None

N=30
p=0.39

dist_mean = N*p



## 9. Computing the standard deviation ##

dist_stdev = None

N=30
p=0.39

dist_stdev = (N * p * (1-p))**(1/2)



## 10. A different plot ##

# Enter your answer here.
"""
fig = plt.figure(figsize=(12,12))
ax1 = fig.add_subplot(2,1,1)
ax2 = fig.add_subplot(2,1,2)


dist = binom.pmf(outcome_counts,10,0.39)
ax1.bar(outcome_counts,dist,color='blue')

dist = binom.pmf(outcome_counts,100,0.39)
ax2.bar(outcome_counts,dist,color='green')

plt.show()
"""
outcome_counts=linspace(0,10,11)
dist = binom.pmf(outcome_counts,10,0.39)
plt.bar(outcome_counts,dist,color='blue')
plt.show()

outcome_counts=linspace(0,100,101)
dist = binom.pmf(outcome_counts,100,0.39)
plt.bar(outcome_counts,dist,color='blue')
plt.show()

## 11. The normal distribution ##

# Create a range of numbers from 0 to 100, with 101 elements (each number has one entry).
outcome_counts = scipy.linspace(0,100,101)

# Create a probability mass function along the outcome_counts.
outcome_probs = binom.pmf(outcome_counts,100,0.39)

# Plot a line, not a bar chart.
plt.plot(outcome_counts, outcome_probs)
plt.show()

## 12. Cumulative density function ##

outcome_counts = linspace(0,30,31)

N=30
p=0.39

dist = binom.cdf(outcome_counts,N,p)

plt.plot(outcome_counts,dist)

plt.show()



## 14. Faster way to calculate likelihood ##

left_16 = None
right_16 = None

k=16
N=30
p=0.39

left_16 = binom.cdf(k,N,p)
right_16 = 1 - left_16

