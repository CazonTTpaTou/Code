import pandas as pd
import numpy as np
from datetime import datetime


data = pd.read_csv('sphist.csv')

data['Date'] = pd.to_datetime(data['Date'])

data_sorted = data.sort_values(by='Date',
                               ascending=False)

data_sorted['Number'] = data_sorted.index + 1

def historique(index,horizon):

    length = data_sorted.shape[0]
    start = np.min([length,index+1])
    end = np.min([length,index+horizon])
    return (start,end)

def row_historique(col,index,horizon):
    ind_start,ind_end = historique(index,horizon)
    rows=((data_sorted['Number']>=ind_start) 
          & (data_sorted['Number']<=ind_end))
    df = data_sorted[rows]
    return df[col]

def mean_rolling(col,index,horizon):
    return np.mean(row_historique(col,index,horizon))

def std_rolling(col,index,horizon):
    return np.std(row_historique(col,index,horizon))
                   
data_sorted['avg_5'] = data_sorted['Number'].apply(lambda x:mean_rolling('Close',x,5))

data_sorted['avg_30'] = data_sorted['Number'].apply(lambda x:mean_rolling('Close',x,30))

data_sorted['avg_365'] = data_sorted['Number'].apply(lambda x:mean_rolling('Close',x,365))

data_sorted['std_5'] = data_sorted['Number'].apply(lambda x:std_rolling('Close',x,5))

data_sorted['std_30'] = data_sorted['Number'].apply(lambda x:std_rolling('Close',x,30))

data_sorted['std_365'] = data_sorted['Number'].apply(lambda x:std_rolling('Close',x,365))

data_sorted['avg_ratio'] = data_sorted['avg_5'] /data_sorted['avg_365'] 

data_sorted['std_ratio'] = data_sorted['std_5'] /data_sorted['std_365'] 

data_sorted['avg_vol_5'] = data_sorted['Number'].apply(lambda x:mean_rolling('Volume',x,5))

data_sorted['avg_vol_365'] = data_sorted['Number'].apply(lambda x:mean_rolling('Volume',x,365))

data_sorted['avg_ratio_vol'] = data_sorted['avg_vol_5'] /data_sorted['avg_vol_365'] 

#print(row_historique('Volume',1,5))

#print(data_sorted.head(5))
#print(data_sorted.tail(5))

condition = data_sorted['Date'] > datetime(year=1951,month=1,day=2)

data_new = data_sorted[condition]

data_new = data_new.dropna(axis=0)

def make_data_set(y,m,d):

    condition_new = data_sorted['Date'] >= datetime(year=y,month=m,day=d) 

    condition_old = data_sorted['Date'] < datetime(year=y,month=m,day=d) 

    trains = data_new[condition_old]

    tests = data_new[condition_new]

    return trains,tests

def make_data_set_unique(y,m,d):

    condition_new = data_sorted['Date'] == datetime(year=y,month=m,day=d) 

    condition_old = data_sorted['Date'] < datetime(year=y,month=m,day=d) 

    trains = data_new[condition_old]

    tests = data_new[condition_new]

    return trains,tests

def make_predicition(y,m,d,equ):
    if equ==True:
        train,test = make_data_set_unique(y,m,d)
    else:
        train,test = make_data_set(y,m,d)
    
    train_target = train['Close']
    test_target = test['Close']

    train = train.drop(columns=['Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close', 'Date'])

    test = test.drop(columns=['Close', 'High', 'Low', 'Open', 'Volume', 'Adj Close', 'Date'])

    from sklearn.linear_model import LinearRegression
    from sklearn.metrics import mean_absolute_error
    from sklearn.metrics import mean_squared_error

    lr = LinearRegression()

    lr.fit(train,train_target)

    predictions = lr.predict(test)

    mae = mean_absolute_error(test_target,predictions)

    mse = mean_squared_error(test_target,predictions)
    
    return mae,mse**(1/2)

print(make_predicition(2015,
                    12,
                    7,
                    True))  
print('---'*20)
print(make_predicition(2013,
                    1,
                    3,
                    False)) 
print('---'*20)
print(make_predicition(2013,
                    1,
                    3,
                    True))   


    
    