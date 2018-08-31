
# coding: utf-8

# # Guided Project - Predicting Car Prices

# In[1]:


import pandas as pd


# In[75]:


cols = ['symboling', 'normalized-losses', 'make', 'fuel-type', 'aspiration', 'num-of-doors', 'body-style', 
        'drive-wheels', 'engine-location', 'wheel-base', 'length', 'width', 'height', 'curb-weight', 'engine-type', 
        'num-of-cylinders', 'engine-size', 'fuel-system', 'bore', 'stroke', 'compression-rate', 'horsepower', 'peak-rpm', 'city-mpg', 'highway-mpg', 'price']

data = pd.read_csv('imports-85.data',names=cols)


# In[76]:


data.head(3)


# In[77]:


continuous_values_cols = ['normalized-losses', 'wheel-base', 'length', 'width', 'height', 'curb-weight', 'bore', 'stroke', 'compression-rate', 'horsepower', 'peak-rpm', 'city-mpg', 'highway-mpg', 'price']

numeric_cars = data[continuous_values_cols]

numeric_cars.head(3)


# ## Data Cleaning

# In[78]:


import numpy as np

numeric_cars = numeric_cars.replace('?', np.nan)


# In[79]:


numeric_cars = numeric_cars.astype('float')


# In[80]:


numeric_cars.isnull().sum()


# In[81]:


numeric_cars = numeric_cars.dropna(subset=['price'])


# In[82]:


numeric_cars = numeric_cars.fillna(numeric_cars.mean())


# In[83]:


numeric_cars.isnull().sum()


# ## Re-scaling

# In[84]:


price_col = numeric_cars['price']

etendue = numeric_cars.max() - numeric_cars.min()
numeric_cars = (numeric_cars-numeric_cars.min()) / etendue

numeric_cars['price'] = price_col


# In[85]:


numeric_cars.head(3)


# ## Univariate Model

# In[86]:


from sklearn.neighbors import KNeighborsRegressor
from sklearn.metrics import mean_squared_error

def knn_train_test(features,target,dataframe):
    number_test = int(dataframe.shape[0]*0.75)
    train = dataframe.iloc[:number_test,:]
    test = dataframe.iloc[number_test:,:]
    
    knn = KNeighborsRegressor()
    knn.fit(train[features],train[target])
    predictions = knn.predict(test[features])
    
    mse = mean_squared_error(predictions,test[target])
    
    return mse**(1/2)

rmses = dict()

for col in numeric_cars.columns:
    if col != 'price':
        rmses[col]=knn_train_test([col],'price',numeric_cars)
    
best_col = min(rmses.keys(),key=(lambda x:rmses[x]))

print('Meilleure colonne : {} avec rmse de {}'.format(best_col,rmses[best_col]))

    


# In[87]:


from sklearn.model_selection import cross_val_score, KFold
import numpy as np

def knn_train_test(features,target,dataframe,k_value):
    kf = KFold(n_splits=k_value,
           shuffle=True,
           random_state=1)

    mses = cross_val_score(KNeighborsRegressor(),
                       dataframe[features],
                       dataframe[target],
                       scoring="neg_mean_squared_error",
                       cv=kf)
 
    return np.mean(np.sqrt(np.absolute(mses)))

print(knn_train_test(['curb-weight'],'price',numeric_cars,5))


# In[103]:


import matplotlib.pyplot as plt
get_ipython().magic('matplotlib inline')

labels=list()
rmse=list()

for col in numeric_cars.columns:
    if col != 'price':
        values=list()
        for k in [2, 3, 5, 7, 9]: 
            values.append(knn_train_test([col],
                          'price',
                          numeric_cars,
                          k))
            
        labels.append(col)
        rmse.append(np.mean(values))
            
fig,ax = plt.subplots()

ax.set_yticklabels(labels,rotation=0)

ax.barh(range(len(labels)),rmse,0.5)

plt.show()


# ## Multivariate

# In[106]:


results = pd.Series(rmse,index=labels)
results = results.sort_values()


# In[107]:


results


# In[113]:


default_k_value = 10
rmses = list()

for num_features in range(1,6):
    rmses.append(knn_train_test(results.index.tolist()[:num_features],
                                'price',
                                numeric_cars,
                                default_k_value))
                                
print(rmses)


# In[114]:


results.index.tolist()[:3]


# ## Optimizing the k neighbors value

# In[130]:


get_ipython().magic('matplotlib inline')

def colors(array):
    array_color=list()
    ind = array.index(min(array))
    for value in array:
        array_color.append('blue')
    array_color[ind]='red'
    return array_color

for num in range(2,5):
    k_rmse=list()
    title = str(results.index.tolist()[:num])
    for k_value in range(2,26):
        k_rmse.append(knn_train_test(results.index.tolist()[:num],
                                'price',
                                numeric_cars,
                                k_value))

    fig,ax = plt.subplots()
    
    ax.set_yticklabels(range(2,26),rotation=0)
    ax.set_yticks(range(2,26))
    ax.barh(range(2,26),k_rmse,0.5,color=colors(k_rmse))
    plt.title(title)
    plt.show()
    


# In[117]:


str(results.index.tolist()[:3])


# In[126]:


li=[1,2,4,5,8,0,9]

def colors(array):
    array_color=list()
    ind = array.index(min(array))
    for value in array:
        array_color.append('blue')
    array_color[ind]='red'
    return array_color

colors(li)

