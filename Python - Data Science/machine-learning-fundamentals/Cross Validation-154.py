## 1. Introduction ##

import numpy as np
import pandas as pd

dc_listings = pd.read_csv("dc_airbnb.csv")

stripped_commas = dc_listings['price'].str.replace(',', '')
stripped_dollars = stripped_commas.str.replace('$', '')
dc_listings['price'] = stripped_dollars.astype('float')

dc_listings = dc_listings.loc[np.random.permutation(len(dc_listings))].copy()

split_one = dc_listings.iloc[0:1862].copy()
split_two = dc_listings.iloc[1862:].copy()




## 2. Holdout Validation ##

from sklearn.neighbors import KNeighborsRegressor
from sklearn.metrics import mean_squared_error

train_one = split_one
test_one = split_two
train_two = split_two
test_two = split_one

def knn_train(feature,train,test):
    
    knn = KNeighborsRegressor(algorithm='auto',
                              n_neighbors=5)
    
    knn.fit(train[feature],train['price'])
    
    return mean_squared_error(knn.predict(test[feature]),
                              test['price'])

iteration_one_rmse = knn_train(['accommodates'],
                               train_one,
                               test_one)**(1/2)

iteration_two_rmse = knn_train(['accommodates'],
                               train_two,
                               test_two)**(1/2)

avg_rmse = np.mean([iteration_one_rmse,iteration_two_rmse])





## 3. K-Fold Cross Validation ##

dc_listings.loc[dc_listings.index[0:745], "fold"] = 1
dc_listings.loc[dc_listings.index[745:1490], "fold"] = 2
dc_listings.loc[dc_listings.index[1490:2234], "fold"] = 3
dc_listings.loc[dc_listings.index[2234:2978], "fold"] = 4
dc_listings.loc[dc_listings.index[2978:3723], "fold"] = 5

print(dc_listings['fold'].value_counts())
print("\n Num of missing values: ", dc_listings['fold'].isnull().sum())

## 4. First iteration ##

from sklearn.neighbors import KNeighborsRegressor
from sklearn.metrics import mean_squared_error
   
knn = KNeighborsRegressor(algorithm='auto',
                          n_neighbors=5)

def knn_train(feature,train,test):
    
    knn.fit(train[feature],train['price'])
    
    return mean_squared_error(knn.predict(test[feature]),
                              test['price'])**(1/2)

def df_train(fold_test):
    condition = dc_listings['fold']!=fold_test    
    return dc_listings[condition]

def df_test(fold_test):
    condition = dc_listings['fold']==fold_test    
    return dc_listings[condition]

iteration_one_rmse = knn_train(['accommodates'],
                               df_train(1),
                               df_test(1))



## 5. Function for training models ##

# Use np.mean to calculate the mean.
import numpy as np
fold_ids = [1,2,3,4,5]

knn = KNeighborsRegressor(algorithm='auto',
                          n_neighbors=5)

def knn_train(feature,train,test):
    
    knn.fit(train[feature],train['price'])
    
    return mean_squared_error(knn.predict(test[feature]),
                              test['price'])**(1/2)

def df_train(df_,fold_test):
    condition = df_['fold']!=fold_test    
    return df_[condition]

def df_test(df_,fold_test):
    condition = df_['fold']==fold_test    
    return df_[condition]

def train_and_validate(df,folds):
    values_rmse=list()
    for fold in folds:
        values_rmse.append(knn_train(['accommodates'],
                                     df_train(df,fold),
                                     df_test(df,fold)))
    return values_rmse
                           
rmses = train_and_validate(dc_listings,
                           fold_ids)
                           
avg_rmse = np.mean(rmses)
                           
                           
                           
                           

## 6. Performing K-Fold Cross Validation Using Scikit-Learn ##

from sklearn.model_selection import cross_val_score, KFold

kf = KFold(n_splits=5,
           shuffle=True,
           random_state=1)

mses = cross_val_score(KNeighborsRegressor(),
                       dc_listings[['accommodates']],
                       dc_listings['price'],
                       scoring="neg_mean_squared_error",
                       cv=kf)

rmses = list()

rmses = np.sqrt(np.absolute(mses))

avg_rmse = np.mean(rmses)

print(rmses)
print(avg_rmse)
    

## 7. Exploring Different K Values ##

from sklearn.model_selection import cross_val_score, KFold

num_folds = [3, 5, 7, 9, 10, 11, 13, 15, 17, 19, 21, 23]

for fold in num_folds:
    kf = KFold(fold, shuffle=True, random_state=1)
    model = KNeighborsRegressor()
    mses = cross_val_score(model, dc_listings[["accommodates"]], dc_listings["price"], scoring="neg_mean_squared_error", cv=kf)
    rmses = np.sqrt(np.absolute(mses))
    avg_rmse = np.mean(rmses)
    std_rmse = np.std(rmses)
    print(str(fold), "folds: ", "avg RMSE: ", str(avg_rmse), "std RMSE: ", str(std_rmse))