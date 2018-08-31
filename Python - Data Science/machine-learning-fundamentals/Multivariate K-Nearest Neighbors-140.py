## 1. Recap ##

import pandas as pd
import numpy as np
np.random.seed(1)

dc_listings = pd.read_csv('dc_airbnb.csv')
dc_listings = dc_listings.loc[np.random.permutation(len(dc_listings))]

stripped_commas = dc_listings['price'].str.replace(',', '')
stripped_dollars = stripped_commas.str.replace('$', '')
dc_listings['price'] = stripped_dollars.astype('float')

dc_listings.info()


## 2. Removing features ##

columns=['room_type',
        'city',
        'state',
        'latitude',
        'longitude',
        'zipcode',
        'host_response_rate',
        'host_acceptance_rate',
        'host_listings_count']

dc_listings = dc_listings.drop(columns=columns)

dc_listings.info()

    

## 3. Handling missing values ##

print(dc_listings.shape)

column_drop = ['cleaning_fee','security_deposit']

column_miss = ['bedrooms','bathrooms','beds']

dc_listings = dc_listings.drop(columns=column_drop)

dc_listings = dc_listings.dropna(subset=column_miss,axis=0)

print(dc_listings.isnull().sum())

print(dc_listings.shape)



## 4. Normalize columns ##

normalized_listings = (dc_listings - dc_listings.mean())/dc_listings.std()

normalized_listings['price'] = dc_listings['price']

normalized_listings.head(3)



## 5. Euclidean distance for multivariate case ##

from scipy.spatial import distance

first_line = normalized_listings.iloc[0][['accommodates','bathrooms']]

fifth_line = normalized_listings.iloc[4][['accommodates','bathrooms']]

first_fifth_distance = distance.euclidean(
                        first_line,
                        fifth_line)

print(first_fifth_distance)





## 7. Fitting a model and making predictions ##

from sklearn.neighbors import KNeighborsRegressor

train_df = normalized_listings.iloc[0:2792]
test_df = normalized_listings.iloc[2792:]

knn = KNeighborsRegressor(n_neighbors=5,
                          algorithm='brute')

knn.fit(train_df[['accommodates','bathrooms']],
        train_df['price'])

predictions = knn.predict(test_df[['accommodates','bathrooms']])




## 8. Calculating MSE using Scikit-Learn ##

from sklearn.metrics import mean_squared_error

train_columns = ['accommodates', 'bathrooms']

knn = KNeighborsRegressor(n_neighbors=5, 
                          algorithm='brute', 
                          metric='euclidean')

knn.fit(train_df[train_columns], train_df['price'])
predictions = knn.predict(test_df[train_columns])

two_features_mse = mean_squared_error(predictions,test_df['price'])

two_features_rmse = two_features_mse**(1/2)

print(two_features_mse)

print(two_features_rmse)







## 9. Using more features ##

from sklearn.neighbors import KNeighborsRegressor

features = ['accommodates', 'bedrooms', 'bathrooms', 'number_of_reviews']

knn = KNeighborsRegressor(n_neighbors=5, 
                          algorithm='brute')

knn.fit(train_df[features],train_df['price'])

four_predictions = knn.predict(test_df[features])

four_mse = mean_squared_error(four_predictions,
                                      test_df['price'])

four_rmse = four_mse ** (1/2)

print(four_mse)

print(four_rmse)




## 10. Using all features ##

all_features = list(train_df.columns)
all_features.remove('price')

knn = KNeighborsRegressor(n_neighbors=5,
                          algorithm='brute',
                          metric='euclidean')

knn.fit(train_df[all_features],
        train_df['price'])

all_features_predictions = knn.predict(test_df[all_features])

all_features_mse = mean_squared_error(all_features_predictions,
                                      test_df['price'])

all_features_rmse = all_features_mse**(1/2)

print(all_features_mse)

print(all_features_rmse)


                                       
