## 2. Introduction To The Data ##

import pandas as pd

df = pd.read_csv('unrate.csv')

df['DATE'] = pd.to_datetime(df['DATE'])
                 
unrate = df

print(unrate.head(12))

                 
            

## 6. Introduction to Matplotlib ##

import matplotlib.pyplot as plt

plt.plot()
plt.show()

## 7. Adding Data ##

plt.plot(unrate['DATE'].head(12),unrate['VALUE'].head(12))


## 8. Fixing Axis Ticks ##

plt.plot(unrate['DATE'].head(12),unrate['VALUE'].head(12))
plt.xticks(rotation=90)

## 9. Adding Axis Labels And A Title ##

plt.plot(unrate['DATE'].head(12),unrate['VALUE'].head(12))
plt.xticks(rotation=90)

plt.xlabel('Month')
plt.ylabel('Unemployment Rate')
plt.title('Monthly Unemployment Trends, 1948')

plt.show()
