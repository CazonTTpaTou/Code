
# coding: utf-8

# # Guided Project: Creating The SimpleFrame Class

# In[49]:


import pandas as pd
import numpy as np

import statistics as stats
import csv


# In[2]:


data = pd.read_csv('music_data.csv')


# In[3]:


data.head(3)


# In[157]:


class SimpleFrame():
    
    def __init__(self,filename):        
        self.name = filename
        self.data = list()
        self.columns = list()
        self.index = list()
        
        self.load()
        
    def load(self):        
        with open(self.name,'r') as f:
            raw = list(csv.reader(f))
            
        self.columns = raw[0]
        
        for row in raw[1:]:
            dict_row = dict()
            for index,col in enumerate(self.columns):
                dict_row[col]= row[index]
            self.data.append(dict_row)
            
        #self.data = raw[1:]
        
        for row in raw[1:]:
            self.index.append(row[1])
            
    def head(self,number):
        row_col = ' || '
        for col in self.columns:
            row_col+= col
            row_col+= ' || '
        print(row_col)   
        
        for row in self.data[:number]:
            row_str = ' || '
            for col in self.columns:
                row_str+=str(row[col])
                row_str+=' || '
            print(row_str)

    def shape(self):        
        self.length = len(self.columns)
        self.width = len(self.index)
        
        return [self.length,self.width]
   
    def add_new_column(self,name_col):
        self.columns.append(name_col)
        
        for row in self.data:
            row[name_col] = np.nan
            
    def apply(self,col,new_col,func,):
        self.add_new_column(new_col)
        for row in self.data:
            #row[new_col]=round(int(row[col])/1000,0)*1000
            row[new_col]=func(int(row[col]))
    
    def apply_col(self,col,func):
        values=list()
        for row in self.data:
            try:
                values.append(int(row[col]))
            except:
                pass
            
        return func(values)
    
    def subset(self,column,row):
        indice = self.index.index(row)
        ligne = self.data[indice]
        return ligne[column]
    
    def libelle(self,operation,value):
        message = 'The {} is about {}'.format(operation,value)
        print(message)
    
    def summary_stats(self):
        self.libelle('mean',self.apply_col('Streams',stats.mean))
        self.libelle('median',self.apply_col('Streams',stats.median))
        self.libelle('mode',self.apply_col('Streams',stats.mode))
        self.libelle('stdev',self.apply_col('Streams',stats.stdev))
        
        self.libelle('maximum',self.maximum('Streams'))
        self.libelle('minimum',self.minimum('Streams'))
        
    def maximum(self,col):
        maxi=0
        for row in self.data:
            if maxi < int(row[col]) :
                maxi=int(row[col])
        return maxi
        
    def minimum(self,col):
        mini=0
        for row in self.data:
            if mini > int(row[col]) :
                mini=int(row[col])
        return mini
    
    def top_song(self,year):
        maxi_song = 0
        for row in self.data:
            date_song = int(row['Date'][:4])        
            if date_song == year:
                if maxi_song < int(row['Streams']):
                    maxi_song = int(row['Streams'])
                    song = row['Track Name']
        return song
    
    def top_artist(self,year):
        maxi_song = 0
        for row in self.data:
            date_song = int(row['Date'][:4])        
            if date_song == year:
                if maxi_song < int(row['Streams']):
                    maxi_song = int(row['Streams'])
                    artist = row['Artist']
        return artist
        
    def top_artist_month(self,year,month):
        maxi_song = 0
        artist = ''
        for row in self.data:
            date_song = int(row['Date'][:4]) 
            position = row['Date'][5:].find('-')+5
            month_song = int(row['Date'][5:position])              
                
            if date_song == year and month_song==month:
                if maxi_song < int(row['Streams']):
                    maxi_song = int(row['Streams'])
                    artist = row['Artist']
        return artist
    
    def top_list(self,year):
        for month in range(1,13):
            top = self.top_artist_month(year,month)
            message = 'Mois n° {} - Top artist : {}'.format(month,top)
            print(message)
            
    def info(self):
        data_first = self.data[0]
        for col in self.columns:            
            type_data = type(data_first[col])
            print('Colonne {} - Type {}'.format(col,type_data))
            
        


# In[158]:


spotify = SimpleFrame('music_data.csv')


# In[159]:


spotify.info()


# In[154]:


spotify.top_song(2017)


# In[155]:


spotify.top_artist(2017)


# In[156]:


spotify.top_list(2017)


# In[114]:


spotify.summary_stats()


# In[83]:


def rounded(value):
    return round(int(value)/1000,0)*1000

spotify.apply('Streams','Streams_round',rounded)


# In[84]:


spotify.head(3)


# In[86]:


spotify.subset("Streams", "Thinking Out Loud")


# In[27]:


spotify.shape()


# In[12]:


spotify.columns


# In[13]:


spotify.index


# In[137]:


mot='2017-01-01'
mot[5:].find('-')


# In[151]:


row=dict()
row['Date']='2017-01-01'
position = row['Date'][5:].find('-')
#month_song = int(row['Date'][5:position])
print(position)

