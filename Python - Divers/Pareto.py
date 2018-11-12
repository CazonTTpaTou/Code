import pandas as pd
import numpy as np

from datetime import datetime
from matplotlib import pyplot as plt

FileName = 'wlobal_rankings.csv'
PathName = 'C:\\SASUniversityEdition\\myfolders'

File = '\\'.join([PathName,FileName])

data = pd.read_csv(File,sep=',')

data_tr = data.groupby(['Track Name'])['Streams'].sum()

def renvoyer_total_stream():
    return data_track['Streams'].sum()

def renvoyer_number_stream():
    return data_track['Streams'].count()

def renvoyer_ratio_stream(stream):
    return stream / renvoyer_total_stream()

def renvoyer_ratio_ligne(stream):
    return stream / renvoyer_number_stream()

data_track = pd.DataFrame({'Track':data_tr.index,'Streams':data_tr.values})
data_track = data_track.sort_values(by='Streams',ascending=False)

data_track['Streams'].dropna()
data_track['Streams'].astype(np.int)

data_track['num_row'] = [num+1 for num in range(data_track.shape[0])]

data_track['ratio_stream'] = data_track['Streams'].apply(renvoyer_ratio_stream)

data_track['ratio_ligne'] = data_track['num_row'].apply(renvoyer_ratio_ligne)
data_track['cumul_ratio_stream'] = data_track['ratio_stream'].rolling(min_periods=1, window=data.shape[0]).sum()

plt.plot(data_track['ratio_ligne'],
         data_track['cumul_ratio_stream'])

plt.plot([0.20,0.20],[0,1],':r')
plt.plot([0,1],[0.80,0.80],':r')

plt.show()         

data_track


