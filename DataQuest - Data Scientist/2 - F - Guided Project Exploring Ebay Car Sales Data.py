
# coding: utf-8

# # Guided Project: Exploring Ebay Car Sales Data

# In[35]:


import pandas as pd
import numpy as np

try:
    autos = pd.read_csv('autos.csv',encoding='Latin-1')
except:
    autos = pd.read_csv('autos.csv',encoding='Windows-1252')


# In[36]:


autos.head(2)


# In[37]:


autos.info()


# ## Cleaning Columns Names

# In[38]:


for col in autos.columns:
    print(col)


# In[39]:


column_name = {
    'yearOfRegistration': 'registration_year',
    'monthOfRegistration':'registration_month',
    'notRepairedDamage': 'unrepaired_damage', 
    'dateCreated': 'ad_created'
}


# In[40]:


autos.rename(column_name,axis=1,inplace=True)


# In[41]:


autos.info()


# ## Initial Exploration and Cleaning

# In[42]:


autos.describe(include='all')


# In[43]:


autos.price.unique()


# In[44]:


autos.price = (autos.price
                           .str.replace('$','')
                           .str.replace('.','')
                           .str.replace(',','')
                           .astype(float))


# In[45]:


autos.odometer.value_counts()


# In[46]:


autos.odometer = (autos.odometer.str.replace('km','')
                                .str.replace(',','')
                                .astype(int))

autos.odometer.value_counts()


# In[47]:


autos.rename({'odometer':'odometer_km'},axis=1,inplace=True)


# ## Exploring the Odometer and Price Columns

# In[48]:


autos.odometer_km.value_counts()


# In[49]:


autos.price.value_counts().sort_index(ascending=False).head(20)


# In[50]:


autos.loc[autos.price>350000.0,'price']=np.nan


# In[51]:


autos.price.value_counts().sort_index(ascending=False).tail(100)


# In[52]:


autos.loc[autos.price<50.0,'price']=np.nan


# In[53]:


autos.shape


# In[56]:


autos.dropna(subset=['price'],inplace=True)
#autos.dropna(axis=0,inplace=True)
autos.shape


# ## Exploring the date columns

# In[62]:


cols = ['dateCrawled', 'ad_created', 'lastSeen']


# In[63]:


for col in cols:
    print('---'*15)
    print(col)
    print('---'*15)
    print(autos[col].value_counts(normalize=True,
                                  dropna=False)
                    .sort_index()
                    .head(5))
    
    print(autos[col].value_counts(normalize=True,
                                  dropna=False)
                    .sort_index()
                    .tail(5))
    


# In[65]:


autos.registration_year.describe()


# ## Dealing with incorrect registration year data

# In[76]:


conditions = ((autos.registration_year >2016)
              |(autos.registration_year <1920))

print(autos.loc[conditions,'registration_year'].value_counts()
                                               .sort_index())


# In[78]:


autos.shape


# In[79]:


autos.loc[conditions,'registration_year'] = np.nan
autos.dropna(subset=['registration_year'],inplace=True)


# In[80]:


autos.shape


# ## Exploring price by brand

# In[81]:


autos.brand.value_counts(normalize=True)


# In[85]:


brand_cars = autos.brand.value_counts(normalize=True)
branding = brand_cars.loc[brand_cars >0.01].index


# In[87]:


branding_price = dict()

for brands in branding:
    condition = autos.brand == brands
    average_price = autos.loc[condition,'price'].mean()
    branding_price[brands]=average_price

print(branding_price)


# ## Storing Aggregate Data in a DataFrame

# In[89]:


branding_mileage = dict()

for brands in branding:
    condition = autos.brand == brands
    average_odometer = autos.loc[condition,'odometer_km'].mean()
    branding_mileage[brands]=average_odometer

print(branding_mileage)


# In[90]:


bmp_series = pd.Series(branding_mileage)


# In[91]:


price_series = pd.Series(branding_price)


# In[93]:


constructor = pd.DataFrame(bmp_series,columns=['mileage'])


# In[94]:


constructor['price'] = price_series


# In[96]:


constructor.sort_values(by='price',ascending=True)


# In[97]:


constructor.sort_values(by='price',ascending=False)


# In[98]:


constructor.sort_values(by='mileage',ascending=False)


# ## Bonus

# In[99]:


autos.unrepaired_damage.unique()     


# In[102]:


traductions = {
    'nein':'no',
    'ja':'yes',
    'no':'no',
    'yes':'yes'
}

autos.unrepaired_damage = autos.unrepaired_damage.map(traductions)


# In[103]:


autos.unrepaired_damage.unique()


# In[105]:


autos.unrepaired_damage.value_counts(normalize=True,
                                     dropna=False)


# In[108]:


get_ipython().magic('matplotlib inline')
(autos.unrepaired_damage.value_counts(normalize=True,
                                     dropna=False)
                        .plot.bar())

