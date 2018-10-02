
# coding: utf-8

# In[1]:


import pandas as pd
from pandas.io.json import json_normalize
import json
import numpy as np

from sklearn.linear_model import LinearRegression
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.feature_selection import RFECV
from sklearn.model_selection import GridSearchCV

pd.options.mode.chained_assignment = None
pd.options.display.max_columns = 999


# In[2]:



def dataset(Path,Name):

    pathFile = '\\'.join([Path,Name])

    dict_cols = ['trafficSource','totals','geoNetwork','device'] 

    df = pd.read_csv(pathFile, dtype={'fullVisitorId': 'str'}, nrows=None)

    for column in dict_cols:
        df = df.join(pd.DataFrame(df.pop(column).apply(pd.io.json.loads).values.tolist(), index=df.index))

    try:
        df['Revenue']=df['transactionRevenue']
    except:    
        df['Revenue']=0

    cols = df.columns.tolist()

    print('--'*30)
    print(df.shape)

    liste_features = ['Revenue',
                        'fullVisitorId', 
                        'bounces', 
                        'hits', 
                        'newVisits', 
                        'pageviews', 
                        'visits', 
                        'subContinent', 
                        'deviceCategory', 
                        'isMobile']

    new_df = df[liste_features]

    col_dummies = [                     
                        'subContinent', 
                        'deviceCategory', 
                        'isMobile']

    for col in col_dummies:
        dummies = pd.get_dummies(new_df[col],prefix=col)
        new_df = pd.concat([new_df,dummies],axis=1)
        #new_df.drop(col)


    new_df = new_df.drop(col_dummies,axis=1)

    return new_df


# In[3]:


Path = 'c:\\users\\monne\\Desktop\\Google Analytics Customers'
Name = 'train.csv'

train_features = dataset(Path,Name)


# In[4]:


train_features = train_features.fillna(0)
print(train_features.shape)


# In[5]:


train_target = train_features.pop('Revenue')
train_id = train_features.pop('fullVisitorId')
print(train_target.shape)
print(train_id.shape)


# In[6]:


train_targets = train_target.copy()
print(type(train_targets))


# In[7]:


train_targets = train_targets.fillna(0)
print(train_targets.isna().sum())
train_targets = train_targets.astype(np.float)
train_targets = train_targets + 1
print(train_targets.unique())
print(train_targets.max())
print(train_targets.min())


# In[8]:


train_targets = np.log(train_targets)
print(train_targets.unique())


# In[9]:


train_target_shape = train_targets.values.reshape(-1,1)
print(train_target_shape)


# In[10]:


train_targets.describe()


# In[11]:


X = train_features.as_matrix().astype(np.float)
y = train_targets.as_matrix().astype(np.float)


# In[13]:


from sklearn.tree import DecisionTreeRegressor 
#lr = LinearRegression()
lr = DecisionTreeRegressor()

lr.fit(train_features,train_targets)


# In[14]:


Name = 'test.csv'

test_features = dataset(Path,Name)


# In[15]:


test_features = test_features.fillna(0)
print(test_features.shape)


# In[16]:


test_target = test_features.pop('Revenue')
test_id = test_features.pop('fullVisitorId')
print(test_target.shape)
print(test_id.shape)


# In[17]:


test_targets = test_target.copy()
print(type(test_targets))


# In[18]:


test_targets = test_targets.fillna(0)
print(test_targets.isna().sum())
test_targets = test_targets.astype(np.float)
test_targets = test_targets + 1
print(test_targets.unique())
print(test_targets.max())
print(test_targets.min())


# In[19]:


test_targets = np.log(test_targets)
print(test_targets.unique())


# In[20]:


print(test_features.shape)
print(train_features.shape)
for col in train_features.columns.tolist():
    print(col)


# In[21]:


for col in test_features.columns.tolist():
    print(col)


# In[22]:


predictions_revenue = lr.predict(test_features)


# In[23]:


mse = np.array((test_targets - predictions_revenue)**2).sum()
rmse = np.sqrt(mse)

print('--'*20)
print(f"Mean square error : .{mse}")
print(f"Root mean square error : .{rmse}")
print('--'*20)


# In[24]:


sub_df = pd.DataFrame({"fullVisitorId":test_id})
predictions_revenue[predictions_revenue < 0] = 0


# In[25]:


sub_df["PredictedLogRevenue"] = np.expm1(predictions_revenue)
sub_df = sub_df.groupby("fullVisitorId")["PredictedLogRevenue"].sum().reset_index()
sub_df.columns = ["fullVisitorId", "PredictedLogRevenue"]


# In[26]:


sub_df["PredictedLogRevenue"] = np.log1p(sub_df["PredictedLogRevenue"])

print('--'*20)
print(sub_df.head())
print('--'*20)


# In[27]:


Path = 'c:\\users\\monne\\Desktop'
Name = 'Submission 2018-10-02.csv'
pathFile = '\\'.join([Path,Name])
sub_df.to_csv(pathFile, index=False)

