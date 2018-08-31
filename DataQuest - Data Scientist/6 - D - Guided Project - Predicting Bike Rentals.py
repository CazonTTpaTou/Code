
# coding: utf-8

# # Guided Project: Predicting Bike Rentals

# In[1]:


import pandas as pd

bike_rentals = pd.read_csv('bike_rental_hour.csv')


# In[2]:


bike_rentals.head(3)


# ## Data Visualisation

# In[6]:


get_ipython().magic('matplotlib inline')

bike_rentals.hist()


# In[7]:


bike_rentals['cnt'].hist()


# In[8]:


bike_rentals.corr()


# In[9]:


bike_rentals.corr()['cnt']


# In[10]:


corr_cnt = bike_rentals.corr()['cnt']
corr_cnt[corr_cnt >0.3]


# In[12]:


corr_cnt[corr_cnt >0.3].sort_values(ascending=False)


# ## Calculating Features

# In[13]:


def assign_label(hour):
    if hour>=6 and hour<12:
        return 1
    elif hour>=12 and hour<18:
        return 2
    elif hour>=18 and hour<24:
        return 3
    elif hour>=0 and hour<6:
        return 4
    
bike_rentals['time_label'] = bike_rentals['hr'].apply(assign_label)
    


# In[14]:


bike_rentals['time_label'].hist()


# In[15]:


bike_rentals['hr'].hist()


# ## Splitting into train - test

# In[16]:


from sklearn.metrics import mean_squared_error


# In[21]:


train = bike_rentals.sample(frac=0.80)

liste_index_train = bike_rentals.index.isin(train.index)

test = bike_rentals[~liste_index_train]


# In[22]:


test.shape[0]


# In[23]:


train.shape[0]


# ## Applying linear regression

# In[26]:


columns = bike_rentals.columns.tolist()
columns


# In[32]:


cols = list(filter(lambda a: a not in ['cnt',
                                       'casual',
                                       'registered',
                                       'dteday'], columns))
cols


# In[34]:


from sklearn.linear_model import LinearRegression

lr = LinearRegression()

lr.fit(train[cols],train['cnt'])


# In[35]:


predictions = lr.predict(test[cols])

rmse = mean_squared_error(test['cnt'],
                          predictions)**(1/2)

print(rmse)


# In[36]:


bike_rentals['cnt'].mean()


# In[39]:


from sklearn.metrics import mean_absolute_error

mae = mean_absolute_error(test['cnt'],
                           predictions)

print(mae)


# ## Applying Decision Trees

# In[53]:


from sklearn.tree import DecisionTreeRegressor
from sklearn.metrics import roc_auc_score

tree = DecisionTreeRegressor(max_depth=5,
                             min_samples_split=10,
                             min_samples_leaf=15)

target_train = train['cnt'].values.reshape(len(train),1)
target_test = test['cnt'].values.reshape(len(test),1)

tree.fit(train[cols],target_train)

predictions = tree.predict(test[cols])

score = tree.score(test[cols],
                   target_test)

mae = mean_absolute_error(test['cnt'],
                          predictions)

print('score : {} - auc : {}'.format(score,mae))


# In[51]:


predictions.tolist()


# In[55]:


target_train = train['cnt'].values.reshape(len(train),1)
target_test = test['cnt'].values.reshape(len(test),1)

liste_score = list()
liste_mae = list()

depth = range(3,10)
split = range(10,15)
leaf = range(10,15)

for dep in depth:
    for spli in split:
        for lea in leaf:
            
            tree = DecisionTreeRegressor(max_depth=dep,
                                         min_samples_split=spli,
                                         min_samples_leaf=lea)

            tree.fit(train[cols],target_train)

            predictions = tree.predict(test[cols])

            score = tree.score(test[cols],
                               target_test)

            mae = mean_absolute_error(test['cnt'],
                                      predictions)
            
            liste_score.append(score)
            liste_mae.append(mae)
            
            print('score : {} - auc : {}'.format(score,mae))


# In[56]:


import matplotlib.pyplot as plt

plt.plot(liste_mae,color='red')

plt.show()


# In[57]:


plt.plot(liste_score,color='blue')

plt.show()


# In[61]:


target_train = train['cnt'].values.reshape(len(train),1)
target_test = test['cnt'].values.reshape(len(test),1)

liste_score = list()
liste_mae = list()

depth = range(9,10)
split = range(14,15)
leaf = range(1,50)

for dep in depth:
    for spli in split:
        for lea in leaf:
            
            tree = DecisionTreeRegressor(max_depth=dep,
                                         min_samples_split=spli,
                                         min_samples_leaf=lea)

            tree.fit(train[cols],target_train)

            predictions = tree.predict(test[cols])

            score = tree.score(test[cols],
                               target_test)

            mae = mean_absolute_error(test['cnt'],
                                      predictions)
            
            liste_score.append(score)
            liste_mae.append(mae)
            
            print('score : {} - auc : {}'.format(score,mae))


# In[62]:


plt.plot(liste_score,color='green')

plt.show()


# In[63]:


plt.plot(liste_mae,color='purple')

plt.show()


# ## Applying Random Forests

# In[71]:


from sklearn.ensemble import RandomForestRegressor

rf = RandomForestRegressor(n_estimators=10,
                           max_features='sqrt',
                           bootstrap=True)

rf.fit(train[cols],
       train['cnt'])



# In[72]:


preditions = rf.predict(test[cols])

score = rf.score(test[cols],
                 target_test)

mae = mean_absolute_error(test['cnt'],
                          predictions)

print('score : {} - auc : {}'.format(score,mae))


# In[79]:


liste_score = list()
liste_mae = list()

estimator = [10,20]
depth = range(9,12)
split = range(10,11)
leaf = range(10,15)

for esti in estimator:
    for dep in depth:
        for spli in split:
            for lea in leaf:

                rf = RandomForestRegressor(n_estimators=esti,
                                           max_features='sqrt',
                                           bootstrap=True,
                                           max_depth=dep,
                                           min_samples_split=spli,
                                           min_samples_leaf=lea)
                
                rf.fit(train[cols],
                       train['cnt'])
                
                predictions = rf.predict(test[cols])

                score = rf.score(test[cols],
                                 target_test)

                mae = mean_absolute_error(test['cnt'],
                                          predictions)
                
                liste_score.append(score)
                liste_mae.append(mae)
                


# In[80]:


plt.plot(liste_mae,color='red')

plt.show()


# In[81]:


plt.plot(liste_score,color='blue')

plt.show()


# In[82]:


liste_mae


# In[83]:


liste_score

