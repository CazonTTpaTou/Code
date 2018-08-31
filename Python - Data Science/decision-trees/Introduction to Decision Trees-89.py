## 2. Overview of the Data Set ##

import pandas

# Set index_col to False to avoid pandas thinking that the first column is row indexes (it's age)
income = pandas.read_csv("income.csv", index_col=False)
print(income.head(5))

## 3. Converting Categorical Variables ##

# Convert a single column from text categories to numbers
col = pandas.Categorical(income["workclass"])
income["workclass"] = col.codes
print(income["workclass"].head(5))

cols = ['education', 
        'marital_status', 
        'occupation', 
        'relationship', 
        'race', 
        'sex', 
        'native_country', 
        'high_income']

for column in cols:
    col = pandas.Categorical(income[column])
    income[column] = col.codes

print(income.head(5))



## 5. Creating Splits ##

# Enter your code here
workclass_4 = income['workclass']==4
workclass_not_4 = income['workclass']!=4

private_incomes = income[workclass_4]
public_incomes  = income[workclass_not_4]



## 9. Overview of Data Set Entropy ##

import math
# We'll do the same calculation we did above, but in Python
# Passing in 2 as the second parameter to math.log will take a base 2 log
entropy = -(2/5 * math.log(2/5, 2) + 3/5 * math.log(3/5, 2))
print(entropy)

nb_value = income['high_income'].count()
nb_value_1 = income['high_income'].sum()
nb_value_0 = nb_value-nb_value_1

prob0 = nb_value_0 / nb_value
prob1 = nb_value_1 / nb_value

income_entropy = -(prob0 * math.log(prob0,2) + prob1*math.log(prob1,2))
print(income_entropy)




## 11. Information Gain ##

import numpy

def calc_entropy(column):
    """
    Calculate entropy given a pandas series, list, or numpy array.
    """
    # Compute the counts of each unique value in the column
    counts = numpy.bincount(column)
    # Divide by the total column length to get a probability
    probabilities = counts / len(column)
    
    # Initialize the entropy to 0
    entropy = 0
    # Loop through the probabilities, and add each one to the total entropy
    for prob in probabilities:
        if prob > 0:
            entropy += prob * math.log(prob, 2)
    
    return -entropy

# Verify that our function matches our answer from earlier
entropy = calc_entropy([1,1,0,0,1])
print(entropy)

information_gain = entropy - ((.8 * calc_entropy([1,1,0,0])) + (.2 * calc_entropy([1])))
print(information_gain)

median_age = income['age'].median()

age_moins=income[income['age']<=median_age]
age_plus=income[income['age']>median_age]

ratio_moins = age_moins.shape[0]/income.shape[0]
ratio_plus = age_plus.shape[0]/income.shape[0]
print(ratio_moins)
print(ratio_plus)

age_information_gain = calc_entropy(income['high_income']) - ((ratio_moins*calc_entropy(age_moins['high_income']))+(ratio_plus*calc_entropy(age_plus['high_income'])))

print(age_information_gain)




## 12. Finding the Best Split ##

def calc_information_gain(data, split_name, target_name):
    """
    Calculate information gain given a data set, column to split on, and target
    """
    # Calculate the original entropy
    original_entropy = calc_entropy(data[target_name])
    
    # Find the median of the column we're splitting
    column = data[split_name]
    median = column.median()
    
    # Make two subsets of the data, based on the median
    left_split = data[column <= median]
    right_split = data[column > median]
    
    # Loop through the splits and calculate the subset entropies
    to_subtract = 0
    for subset in [left_split, right_split]:
        prob = (subset.shape[0] / data.shape[0]) 
        to_subtract += prob * calc_entropy(subset[target_name])
    
    # Return information gain
    return original_entropy - to_subtract

# Verify that our answer is the same as on the last screen
print(calc_information_gain(income, "age", "high_income"))

columns = ["age", "workclass", "education_num", "marital_status", "occupation", "relationship", "race", "sex", "hours_per_week", "native_country"]

information_gains = list()

for col in columns:
    information_gains.append(
        calc_information_gain(income,
                              col,
                              'high_income'))
    
highest_gain = columns[
    information_gains.index(max(information_gains))]  
            
print(highest_gain)
