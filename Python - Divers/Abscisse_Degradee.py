import pandas as pd
import numpy as np

from datetime import datetime
from matplotlib import pyplot as plt

FileName = 'wlobal_rankings.csv'
PathName = 'C:\\SASUniversityEdition\\myfolders'

File = '\\'.join([PathName,FileName])

data = pd.read_csv(File,sep=',')

#data.head(5)

def renvoyer_date(date_jour):
    date_day = datetime.strptime(date_jour, "%Y-%m-%d")
    return date_day

def renvoyer_delta_date(date_jour):
    date_du_jour = renvoyer_date(date_jour) 
    date_maximale = renvoyer_date(return_maximum_date()) 
    delta = abs((date_maximale - date_du_jour).days)
    return delta

def return_maximum_date():
    return max(data['Date']) 

def determiner_abscisse(date_jour):
    if date_jour == 0:
        return '0 - Current Day'
    if date_jour == 1:
        return '1 - Day 1'
    if date_jour == 2:
        return '2 - Day 2'
    if date_jour == 3:
        return '3 - Day 3'
    if date_jour == 4:
        return '4 - Day 4'
    if date_jour == 5:
        return '5 - Day 5'
    if date_jour == 6:
        return '6 - Day 6'
    if date_jour > 6 and date_jour <= 14:
        return '7 - Week 2'
    if date_jour > 14 and date_jour <= 21:
        return '8 - Week 3'
    if date_jour > 21 and date_jour <= 28:
        return '9 - Week 4'
    if date_jour > 28 and date_jour <= 60:
        return '10 - Month 2'
    if date_jour > 60 and date_jour <= 90:
        return '11 - Month 3'
    if date_jour > 90 and date_jour <= 180:
        return '12 - Quarter 2'
    if date_jour > 180 and date_jour <= 270:
        return '13 - Quarter 3'
    if date_jour > 270 and date_jour <= 360:
        return '14 - Quarter 4'
    if date_jour > 360 :
        return '15 - Year 2'

data['delta_max']=data['Date'].apply(renvoyer_delta_date)   
data['delta_max'].dropna()
data['delta_max'].astype(np.int)

#print(return_maximum_date())

#print(data.head(5))

data['abscisse_degradee'] = data['delta_max'].apply(determiner_abscisse)

plt.plot(data['abscisse_degradee'],
         data['Streams'])

plt.show()





