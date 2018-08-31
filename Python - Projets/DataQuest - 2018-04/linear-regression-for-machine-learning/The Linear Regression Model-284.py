## 2. Introduction To The Data ##

import pandas as pd

data = pd.read_csv('AmesHousing.txt',delimiter='\t')

train = data.iloc[:1460,:]
test = data.iloc[1460:,:]

print(train.info())

target = 'SalePrice'


## 3. Simple Linear Regression ##

import matplotlib.pyplot as plt
# For prettier plots.
import seaborn as sns

fig = plt.figure(figsize=(7,15))

ax1 = fig.add_subplot(3,1,1)
ax2 = fig.add_subplot(3,1,2)
ax3 = fig.add_subplot(3,1,2)

train.plot(x='Garage Area',y='SalePrice',kind="scatter")
train.plot(x='Gr Liv Area',y='SalePrice',kind="scatter")
train.plot(x='Overall Cond',y='SalePrice',kind="scatter")

plt.show()





## 5. Using Scikit-Learn To Train And Predict ##

from sklearn.linear_model import  LinearRegression

regr = LinearRegression()
regr.fit(train[['Gr Liv Area']],train['SalePrice'])

a0 = regr.intercept_
a1 = regr.coef_

# DataFrame
s1=type(train[['Gr Liv Area']])
# Series
s2=type(train['Gr Liv Area'])


## 6. Making Predictions ##

import numpy as np

lr = LinearRegression()
lr.fit(train[['Gr Liv Area']], train['SalePrice'])

train_predictions = lr.predict(train[['Gr Liv Area']])
test_predictions = lr.predict(test[['Gr Liv Area']])

train_rmse = np.sqrt(
    np.array((train_predictions-train['SalePrice'])**2).sum()
    /train.shape[0])

test_rmse = np.sqrt(
    np.array((test_predictions-test['SalePrice'])**2).sum()
    /test.shape[0])







## 7. Multiple Linear Regression ##

cols = ['Overall Cond', 'Gr Liv Area']

lr = LinearRegression()
lr.fit(train[cols], train['SalePrice'])


train_predictions = lr.predict(train[cols])
test_predictions = lr.predict(test[cols])

train_mse = mean_squared_error(train_predictions, train['SalePrice'])
test_mse = mean_squared_error(test_predictions, test['SalePrice'])

train_rmse_2 = np.sqrt(train_mse)
test_rmse_2 = np.sqrt(test_mse)

print(train_rmse)
print(test_rmse)