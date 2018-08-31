
# coding: utf-8

# # Guided Project: Predicting House Sale Prices
# 

# In[128]:


import pandas as pd
import numpy as np

from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import KFold

import matplotlib.pyplot as plt


# In[4]:


data = pd.read_csv('AmesHousing.tsv',delimiter="\t")


# In[120]:


def transform_features(train):
    copie_train = train.copy()
    
    cols_suppr = list()
    ratio_null_cols = copie_train.isna().sum() / copie_train.count()
    
    for index,value in ratio_null_cols.items():
        if value>0.05:
            cols_suppr.append(index)
        
        elif value<0.05 and value>0:
            if (copie_train[index].dtypes =='float' 
                or copie_train[index].dtypes =='int'):
                copie_train[index] = copie_train[index].fillna(copie_train[index].mode())
            else:
                cols_suppr.append(index)
                
    ## Drop columns that aren't useful for ML
    cols_suppr.extend(["PID", "Order"])

    ## Drop columns that leak info about the final sale
    cols_suppr.extend(["Mo Sold", "Sale Condition", "Sale Type", "Yr Sold"])                
    
    copie_train = copie_train.drop(columns=cols_suppr)
    
    copie_train['years_until_remod'] = copie_train['Year Remod/Add']-copie_train['Year Built']
    
    return copie_train


# In[121]:


def select_features(train):
    copy = transform_features(train)
    coeff_corr = 0.3
    
    mat_corr = copy.corr()['SalePrice'].abs().sort_values()
    features = mat_corr[mat_corr>=coeff_corr].index.tolist()
    
    dataset = copy[features]
    
    dummies_col = ['Alley', 'Land Contour', 'Lot Config', 'Bldg Type', 'Mas Vnr Type', 'Misc Feature']
    
    for col in dummies_col:
        new_col = pd.get_dummies(train[col])
        dataset = pd.concat([dataset,new_col],axis=1)
        
    return dataset


# In[129]:


def train_and_test(data,k=0):
    list_rmse = list()
    
    df = select_features(data)
    
    df[['Garage Cars','Mas Vnr Area',
          'Total Bsmt SF',
          'BsmtFin SF 1',
          'Garage Area']] = df[['Garage Cars','Mas Vnr Area',
          'Total Bsmt SF',
          'BsmtFin SF 1',
          'Garage Area']].fillna(0)
    
    num_cols = df.select_dtypes(include=['float','integer'])
    features = num_cols.columns.drop(['SalePrice'])
    
    if k==0:
        train = df[:1460]
        test = df[1460:]

        lr = LinearRegression()
        lr.fit(train[features],train['SalePrice'])

        prediction = lr.predict(test[features])

        mse = mean_squared_error(prediction,test['SalePrice'])

        list_rmse.append(mse**(1/2))
    
    if k==1:
        # Randomize *all* rows (frac=1) from `df` and return
        shuffled_df = df.sample(frac=1, )
        
        train = df[:1460]
        test = df[1460:]
        
        lr = LinearRegression()
        lr.fit(train[features],train['SalePrice'])

        prediction = lr.predict(test[features])
        mse = mean_squared_error(prediction,test['SalePrice'])
        list_rmse.append(mse**(1/2))
    
        test = df[:1460]
        train = df[1460:]
        
        lr = LinearRegression()
        lr.fit(train[features],train['SalePrice'])

        prediction = lr.predict(test[features])
        mse = mean_squared_error(prediction,test['SalePrice'])
        list_rmse.append(mse**(1/2))
    
    if k>=2:
        kf = KFold(n_splits=k, shuffle=True)
        for train_index,test_index in kf.split(df):
            train = df.iloc[train_index]
            test = df.iloc[test_index]
            
            lr = LinearRegression()
            lr.fit(train[features],train['SalePrice'])

            prediction = lr.predict(test[features])
            mse = mean_squared_error(prediction,test['SalePrice'])
            list_rmse.append(mse**(1/2))
    
    return list_rmse


# In[58]:


print(select_features(data).isna().sum())


# In[59]:


print(select_features(data).max())


# In[130]:


print(train_and_test(data))


# In[131]:


print(train_and_test(data,1))


# In[132]:


print(train_and_test(data,5))


# ## Feature Engineering

# In[69]:


print(transform_features(data).info())


# ## Feature Selection

# In[71]:


import seaborn as sns
get_ipython().magic('matplotlib inline')
corr_mat = transform_features(data).corr()

sns.heatmap(corr_mat)


# In[86]:


select_features(data)
#print(train_and_test(data))


# In[81]:


nominal_features = ["PID", "MS SubClass", "MS Zoning", "Street", "Alley", "Land Contour", "Lot Config", "Neighborhood", 
                    "Condition 1", "Condition 2", "Bldg Type", "House Style", "Roof Style", "Roof Matl", "Exterior 1st", 
                    "Exterior 2nd", "Mas Vnr Type", "Foundation", "Heating", "Central Air", "Garage Type", 
                    "Misc Feature", "Sale Type", "Sale Condition"]

chosen_feature = list()

for feature in nominal_features:
    ratio = data[feature].value_counts()/data[feature].count()
    if len(ratio)<6 and ratio.max()<0.9:
        chosen_feature.append(feature)

print(chosen_feature)
    
    


# In[5]:


data.head(3)


# In[7]:


data.info()


# ## Train and Test

# In[136]:


liste_rmse=list()

for k in range(0,20):
    rmse = np.average(train_and_test(data,k))
    print(rmse)
    liste_rmse.append(rmse)
    
print('--'*25)    
print(liste_rmse.index(min(liste_rmse)))


# In[137]:


plt.plot(liste_rmse)
plt.show()

