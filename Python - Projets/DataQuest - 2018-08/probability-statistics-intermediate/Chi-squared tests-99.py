## 2. Calculating differences ##

expected = 16280.5
observed = 10771  

female_diff = (observed-expected)/expected

observed = 21790 

male_diff = (observed-expected)/expected




## 3. Updating the formula ##

def chi_square(observed,expected):
    return ((observed-expected)**2)/expected

expected = 16280.5
observed = 10771 

female_diff = chi_square(observed,expected)

observed = 21790 

male_diff = chi_square(observed,expected)

gender_chisq = female_diff + male_diff





## 4. Generating a distribution ##

import numpy as np
import matplotlib.pyplot as plt 

def chi_square(observed,expected):
    return ((observed-expected)**2)/expected

expected = 16280.5

chi_squared_values = []

for loop in range(1000):
    vector = np.random.random((32561,))
    
    for index,number in enumerate(vector):
        if number>0.5:
            vector[index]=0
        else:
            vector[index]=1
    
    Female = sum(vector)
    Male = len(vector) - Female                           
    male_diff = chi_square(Male,expected)        
    female_diff = chi_square(Female,expected)
                              
    chi_squared_values.append(male_diff+female_diff)
                              
plt.hist(chi_squared_values)
                              
plt.show()
                              
  
                              
                              

## 6. Smaller samples ##

def chi_square(observed,expected):
    return ((observed-expected)**2)/expected

expected = 162.805
observed = 107.71 

female_diff = chi_square(observed,expected)

observed = 217.90 

male_diff = chi_square(observed,expected)

gender_chisq = female_diff + male_diff








## 7. Sampling distribution equality ##

import numpy as np

population = 300
chi_squared_values = []

def chi_square(observed,expected):
    return ((observed-expected)**2)/expected

for number in range(1000):
    vector=np.random.random((population,1))
    vector[vector<0.5]=0
    vector[vector>0.5]=1
    
    Female = len(vector[vector==1])
    Male = len(vector[vector==0])
    
    female_diff=chi_square(Female,
                           population/2)
    male_diff=chi_square(Male,
                           population/2)
    
    chi_squared_values.append(female_diff+male_diff)
    
plt.hist(chi_squared_values)

plt.show()


    
    

## 9. Increasing degrees of freedom ##

races_observed = {'White':27816, 
         'Black':3124, 
         'Asian-Pac-Islander':1039, 
         'Amer-Indian-Eskimo':311,  
         'Other':271}

races_expected = {'White':26146.5, 
         'Black':3939.9, 
         'Asian-Pac-Islander':944.3, 
         'Amer-Indian-Eskimo':260.5,  
         'Other':1269.8}

race_chisq = []

def chi_square(observed,expected):
    return ((observed-expected)**2)/expected

for race in races_observed.keys():
    race_chisq.append(chi_square(races_observed[race],
                                 races_expected[race]))
    
    

## 10. Using SciPy ##

from scipy.stats import chisquare
import numpy as np

observed=[]
verified=[]

races_observed = {'White':27816, 
         'Black':3124, 
         'Asian-Pac-Islander':1039, 
         'Amer-Indian-Eskimo':311,  
         'Other':271}

races_expected = {'White':26146.5, 
         'Black':3939.9, 
         'Asian-Pac-Islander':944.3, 
         'Amer-Indian-Eskimo':260.5,  
         'Other':1269.8}

for key in races_observed.keys():
    observed.append(races_observed[key])
    verified.append(races_expected[key])

chisquare_value, race_pvalue = chisquare(np.array(observed), 
                                    np.array(verified))


    