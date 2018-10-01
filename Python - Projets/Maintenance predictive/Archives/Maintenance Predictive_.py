import pandas as pd
import numpy as np

import matplotlib.pyplot as plt
import seaborn as sns

import scipy
from statsmodels.graphics.gofplots import qqplot
from scipy.stats import shapiro
from scipy.stats import anderson
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.stattools import kpss

from statsmodels.tsa.arima_model import ARIMA

path = 'c://users//monne//desktop'
fileName = 'Data_Maintenance.csv'

filePath = '//'.join([path,fileName])

data_maintenance = pd.read_csv(filePath,delimiter=';')

print(data_maintenance.head(5))

"""
data_maintenance.TTV.hist(label="Distribution of wafers thickness")
plt.plot([95, 95], [0, 3500],
         color='red',
         linestyle='--',
         linewidth=3,
         label="Out 6-sigma limit")

plt.legend(loc='upper right');
plt.show()

sns.distplot(data_maintenance.TTV)
plt.show()

g = sns.FacetGrid(data_maintenance, 
                  col="SiliciumType", 
                  size=6)

g.map(sns.kdeplot,
      "TTV",
      shade=True)

plt.xlabel('TTV')
plt.show()

qqplot(data_maintenance.TTV, line='s')
plt.show()

stats,p_value = shapiro(data_maintenance.TTV)
print('Stats = {} - p-value = {}'.format(stats,p_value))

# D'Agostino and Pearson's Test
print(scipy.stats.normaltest(data_maintenance.TTV))

# Anderson's Test
result = anderson(data_maintenance.TTV)
print('Statistic: %.3f' % result.statistic)
for i in range(len(result.critical_values)):
    sl, cv = result.significance_level[i], result.critical_values[i]
	
    if result.statistic < result.critical_values[i]:
        print('%.3f: %.3f, data looks normal (fail to reject H0)' % (sl, cv))
    else:
        print('%.3f: %.3f, data does not look normal (reject H0)' % (sl, cv))

print(mean_TTV)

data_maintenance['year'] = data_maintenance['Date'].apply(lambda x:x[len(x)-4:])
data_maintenance['month'] = data_maintenance['Date'].apply(lambda x:x[len(x)-7:len(x)-5])
data_maintenance['day'] = data_maintenance['Date'].apply(lambda x:x[:2])
     
data_maintenance['date_py'] = pd.to_datetime(data_maintenance[['year','month','day']])

grouped = data_maintenance.groupby('date_py')
mean_TTV = grouped['TTV'].agg(np.mean)
print(mean_TTV)
mean_TTV.plot()
plt.show()

print('--'*20)
print('Augmented Dickey Fuller Test')

results = adfuller(mean_TTV,
                   autolag='AIC')

test_statistics,p_value = results[0],results[1]

print('valeur du test : {} - Valeur de la p-value : {}'.format(test_statistics,
                                                          p_value))

for key,value in results[4].items():
    print('Critical value à {} % : {}'.format(key,value))
print('--'*20)    
if p_value < 0.05:
    print('Reject H0 : the serie of fluctuations of TTV is stationnary...') 
else:
    print('Fail to reject H0 : the serie of fluctuations of TTV is not stationnary...') 
    
print('--'*20)
print('Kwiatkowski-Phillips-Schmidt-Shin Test')    


results = kpss(mean_TTV,
                   regression='c')

test_statistics,p_value = results[0],results[1]

print('valeur du test : {} - Valeur de la p-value : {}'.format(test_statistics,
                                                          p_value))

for key,value in results[3].items():
    print('Critical value à {} % : {}'.format(key,value))
print('--'*20)    
if p_value > 0.05:
    print('Fail to reject H0 : the serie of fluctuations of TTV is stationnary...') 
else:
    print('Reject H0 : the serie of fluctuations of TTV is not stationnary...') 

# Forecast with ARIMA model       
model = ARIMA(mean_TTV, order=(2,0, 0))  
results_ARIMA = model.fit()  

plt.plot(mean_TTV)
plt.plot(results_ARIMA.fittedvalues, color='red')
plt.title('RSS: %.4f'% sum((results_ARIMA.fittedvalues-mean_TTV)**2))

"""

is_emptying =list()
cumul_wafers = list()
day_since_emptying = list()
cumul_ant=0

for index,row in data_maintenance.iterrows():
    if row['Date'][:2]=='01':
        is_emptying.append(1)
        cumul_wafers.append(0)
        cumul_ant=row['WafersProduction']
        day=int(row['LastEmptying'][:2])
        day_since_emptying.append(0)
    else:
        is_emptying.append(0)
        cumul_wafers.append(row['WafersProduction']-cumul_ant)
        day_since_emptying.append(np.abs(int(row['Date'][:2])-day))
        
data_maintenance['day of emptying']  = is_emptying      
data_maintenance['cumul of wafers']  = cumul_wafers  
data_maintenance['day since emptying']  = day_since_emptying  

print(data_maintenance.head(5))
print(data_maintenance.tail(5))





