## 1. Introduction ##

import pandas as pd

columns = ["mpg", "cylinders", "displacement", "horsepower", "weight", "acceleration", "model year", "origin", "car name"]

cars = pd.read_table("auto-mpg.data", delim_whitespace=True, names=columns)

filtered_cars = cars[cars['horsepower'] != '?'].copy()

filtered_cars['horsepower'] = filtered_cars['horsepower'].astype('float')





## 3. Bias-variance tradeoff ##

from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
import numpy as np
import matplotlib.pyplot as plt

def train_and_test(cols):
    X = filtered_cars[cols]
    Y = filtered_cars['mpg']
    
    lr = LinearRegression()
    lr.fit(X,Y)
    
    predictions = lr.predict(X)
    
    mse = mean_squared_error(Y,predictions)
    variance = np.var(predictions)
    
    return (mse,variance)

cyl_mse,cyl_var = train_and_test(['cylinders'])

weight_mse,weight_var = train_and_test(['weight'])




## 4. Multivariate models ##

# Our implementation for train_and_test, takes in a list of strings.
def train_and_test(cols):
    # Split into features & target.
    features = filtered_cars[cols]
    target = filtered_cars["mpg"]
    # Fit model.
    lr = LinearRegression()
    lr.fit(features, target)
    # Make predictions on training set.
    predictions = lr.predict(features)
    # Compute MSE and Variance.
    mse = mean_squared_error(filtered_cars["mpg"], predictions)
    variance = np.var(predictions)
    return(mse, variance)

one_mse, one_var = train_and_test(["cylinders"])

cols = ['cylinders', 'displacement', 'horsepower','weight','acceleration','model year','origin'] 

mse=list()
var=list()
features=list()

for col in cols:
    features.append(col)
    mse_,var_ = train_and_test(features)
    mse.append(mse_)
    var.append(var_)
    
for col,ms,vr in zip(cols,mse,var):
    print('{} colonne(s) : mse = {} - var = {}'.format(cols.index(col),
                                                       ms,
                                                       vr))
    
one_mse, one_var = train_and_test(["cylinders"])
two_mse, two_var = train_and_test(["cylinders", "displacement"])
three_mse, three_var = train_and_test(["cylinders", "displacement", "horsepower"])
four_mse, four_var = train_and_test(["cylinders", "displacement", "horsepower", "weight"])
five_mse, five_var = train_and_test(["cylinders", "displacement", "horsepower", "weight", "acceleration"])
six_mse, six_var = train_and_test(["cylinders", "displacement", "horsepower", "weight", "acceleration", "model year"])
seven_mse, seven_var = train_and_test(["cylinders", "displacement", "horsepower", "weight", "acceleration","model year", "origin"])   






## 5. Cross validation ##

from sklearn.model_selection import KFold
from sklearn.metrics import mean_squared_error
import numpy as np

def train_and_cross_val(cols): 
    mse=list()
    var=list()
    X = filtered_cars[cols]
    y = filtered_cars['mpg']
    lr = LinearRegression()
    kf = KFold(n_splits=10, random_state=3, shuffle=True)

    for train_index,test_index in kf.split(X):
        train_x, train_y = X.iloc[train_index], y.iloc[train_index]
        test_x, test_y = X.iloc[test_index],  y.iloc[test_index] 
            
        lr.fit(train_x,train_y)
        predictions = lr.predict(test_x)
        
        mse.append(mean_squared_error(test_y,predictions))
        var.append(np.var(predictions))
                                 
    return (np.average(mse),np.average(var))

one_mse, one_var = train_and_cross_val(["cylinders"])
two_mse, two_var = train_and_cross_val(["cylinders", "displacement"])
three_mse, three_var = train_and_cross_val(["cylinders", "displacement", "horsepower"])
four_mse, four_var = train_and_cross_val(["cylinders", "displacement", "horsepower", "weight"])
five_mse, five_var = train_and_cross_val(["cylinders", "displacement", "horsepower", "weight", "acceleration"])
six_mse, six_var = train_and_cross_val(["cylinders", "displacement", "horsepower", "weight", "acceleration", "model year"])
seven_mse, seven_var = train_and_cross_val(["cylinders", "displacement", "horsepower", "weight", "acceleration","model year", "origin"])   
                                 
                                 
                                 

## 6. Plotting cross-validation error vs. cross-validation variance ##

# We've hidden the `train_and_cross_val` function to save space but you can still call the function!
import matplotlib.pyplot as plt
        
cols = ['displacement', 'horsepower','weight','acceleration','model year','origin'] 

mse=list()
var=list()
features=list()
features.append('cylinders')

for col in cols:
    features.append(col)
    mse_,var_ = train_and_cross_val(features)
    mse.append(mse_)
    var.append(var_)
    
plt.scatter(x=range(2,8),
            y=mse,
            color='red')

plt.scatter(x=range(2,8),
            y=var,
            color='blue')

plt.show()

