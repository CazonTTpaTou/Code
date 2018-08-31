## 1. Testing quality of predictions ##

import pandas as pd
import numpy as np

dc_listings = pd.read_csv("dc_airbnb.csv")
stripped_commas = dc_listings['price'].str.replace(',', '')
stripped_dollars = stripped_commas.str.replace('$', '')
dc_listings['price'] = stripped_dollars.astype('float')
train_df = dc_listings.iloc[0:2792]
test_df = dc_listings.iloc[2792:]

def predict_price(new_listing):
    
    temp_df = train_df.copy()
    temp_df['distance'] = temp_df['accommodates'].apply(lambda x: np.abs(x - new_listing))
    
    temp_df = temp_df.sort_values('distance')
    nearest_neighbor_prices = temp_df.iloc[0:5]['price']
    predicted_price = nearest_neighbor_prices.mean()

    return(predicted_price)

test_df['predicted_price']=test_df['accommodates'].apply(lambda x : predict_price(x))






## 2. Error Metrics ##

import numpy as np

mae = (sum(np.absolute(test_df['predicted_price']
                      -test_df['price']))
       /len(test_df))





## 3. Mean Squared Error ##

mse = (sum((test_df['predicted_price']-test_df['price'])**2)
       /len(test_df))



## 4. Training another model ##

train_df = dc_listings.iloc[0:2792]
test_df = dc_listings.iloc[2792:]

def predict_price(new_listing,column):
    temp_df = train_df.copy()
    temp_df['distance'] = temp_df[column].apply(lambda x: np.abs(x - new_listing))
    temp_df = temp_df.sort_values('distance')
    nearest_neighbors_prices = temp_df.iloc[0:5]['price']
    predicted_price = nearest_neighbors_prices.mean()
    return(predicted_price)

column = 'bathrooms'

test_df['predicted_price'] = test_df[column].apply(lambda x:predict_price(x,column))

mse = (sum((test_df['predicted_price'] - test_df['price'])**2)
       /len(test_df))

print(mse)




## 5. Root Mean Squared Error ##

def predict_price(new_listing):
    temp_df = train_df.copy()
    temp_df['distance'] = temp_df['bathrooms'].apply(lambda x: np.abs(x - new_listing))
    temp_df = temp_df.sort_values('distance')
    nearest_neighbors_prices = temp_df.iloc[0:5]['price']
    predicted_price = nearest_neighbors_prices.mean()
    return(predicted_price)

test_df['predicted_price'] = test_df['bathrooms'].apply(lambda x: predict_price(x))
test_df['squared_error'] = (test_df['predicted_price'] - test_df['price'])**(2)

mse = test_df['squared_error'].mean()

rmse = mse**(1/2)



## 6. Comparing MAE and RMSE ##

errors_one = pd.Series([5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 10])
errors_two = pd.Series([5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 10, 5, 1000])

mae_one = np.mean(errors_one)

rmse_one = (np.mean(errors_one**2))**(1/2)

mae_two = np.mean(errors_two)

rmse_two = (np.mean(errors_two**2))**(1/2)


