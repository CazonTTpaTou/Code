## 1. Recap ##

import pandas as pd

train_df = pd.read_csv('dc_airbnb_train.csv')

test_df = pd.read_csv('dc_airbnb_test.csv')



## 2. Hyperparameter optimization ##

from sklearn.neighbors import KNeighborsRegressor
from sklearn.metrics import mean_squared_error

features = [
    'accommodates',
    'bedrooms',
    'bathrooms',
    'number_of_reviews']

hyper_params = [1,2,3,4,5]
mse_values = []

for param in hyper_params:
    knn = KNeighborsRegressor(n_neighbors=param,
                              algorithm='brute')
    knn.fit(train_df[features],
            train_df['price'])
    
    predictions = knn.predict(test_df[features])
    
    mse = mean_squared_error(predictions,
                                    test_df['price'])
    
    mse_values.append(mse)
    
print(mse_values)




## 3. Expanding grid search ##

from sklearn.neighbors import KNeighborsRegressor
from sklearn.metrics import mean_squared_error

features = [
    'accommodates',
    'bedrooms',
    'bathrooms',
    'number_of_reviews']

hyper_params = range(1,21)
mse_values = list()

for param in hyper_params:
    knn = KNeighborsRegressor(n_neighbors=param,
                              algorithm='brute')
    knn.fit(train_df[features],
            train_df['price'])
    
    predictions = knn.predict(test_df[features])
    
    mse = mean_squared_error(predictions,
                                    test_df['price'])
    
    mse_values.append(mse)
    
print(mse_values)



## 4. Visualizing hyperparameter values ##

import matplotlib.pyplot as plt
%matplotlib inline

features = ['accommodates', 'bedrooms', 'bathrooms', 'number_of_reviews']
hyper_params = [x for x in range(1, 21)]
mse_values = list()

for hp in hyper_params:
    knn = KNeighborsRegressor(n_neighbors=hp, algorithm='brute')
    knn.fit(train_df[features], train_df['price'])
    predictions = knn.predict(test_df[features])
    mse = mean_squared_error(test_df['price'], predictions)
    mse_values.append(mse)
    
plt.scatter(x=hyper_params,
            y=mse_values)

plt.show()



## 5. Varying features and hyperparameters ##

hyper_params = [x for x in range(1,21)]
mse_values = list()

all_features = train_df.columns.tolist()
all_features.remove('price')

hyper_params = [x for x in range(1,21)]

for param in hyper_params:
    knn = KNeighborsRegressor(n_neighbors=param,
                              algorithm='brute',
                              metric='euclidean')
    knn.fit(train_df[all_features],train_df['price'])
    predictions = knn.predict(test_df[all_features])
    
    mse_values.append(mean_squared_error(predictions,
                                         test_df['price']))

plt.scatter(x=hyper_params,
            y=mse_values)

plt.show()


    

## 6. Practice the workflow ##

two_features = ['accommodates', 'bathrooms']
three_features = ['accommodates', 'bathrooms', 'bedrooms']
hyper_params = [x for x in range(1,21)]

def grid_knn(features):
    mse_values = list()
    
    for param in hyper_params:
        knn = KNeighborsRegressor(n_neighbors=param,
                                  algorithm='brute',
                                  metric='euclidean')
        
        knn.fit(train_df[features],train_df['price'])
        predictions = knn.predict(test_df[features])

        mse_values.append(mean_squared_error(predictions,
                                             test_df['price']))
    return mse_values

two_mse_values = grid_knn(two_features)

three_mse_values = grid_knn(three_features)

two_hyp_mse = dict()
two_hyp_mse[1+two_mse_values.index(min(two_mse_values))] = min(two_mse_values)

three_hyp_mse = dict()
three_hyp_mse[1+three_mse_values.index(min(three_mse_values))] = min(three_mse_values)

print(two_hyp_mse)

print(three_hyp_mse)



