import pandas as pd
from pandas.io.json import json_normalize
import json

pd.options.mode.chained_assignment = None
pd.options.display.max_columns = 999

Path = 'c:\\users\\monne\\Desktop'
Name = 'Train_Extrait.txt'

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

saveFile = r'C:\\Users\\monne\\Desktop\\Column_List.txt'

with open(saveFile,'w') as f:
    for index,rows in df.head(1).iterrows():
        for elem,col in zip(rows,cols):
            f.writelines('---'*30)
            f.writelines('\n')       
            f.writelines(col)
            f.writelines(' ------> ')    
            f.writelines(str(elem))
            f.writelines('\n') 

print('--'*30)
print(df.shape)

liste_features = ['Revenue',
                    'fullVisitorId', 
                    'source', 
                    'bounces', 
                    'hits', 
                    'newVisits', 
                    'pageviews', 
                    'visits', 
                    'subContinent', 
                    'browser', 
                    'deviceCategory', 
                    'isMobile', 
                    'operatingSystem']

new_df = df[liste_features]

col_dummies = [     'source',                     
                    'subContinent', 
                    'browser', 
                    'deviceCategory', 
                    'isMobile', 
                    'operatingSystem']

for col in col_dummies:
    dummies = pd.get_dummies(new_df[col],prefix=col)
    new_df = pd.concat([new_df,dummies],axis=1)
    #new_df.drop(col)

liste_id = new_df.pop('fullVisitorId')
new_df = new_df.drop(col_dummies,axis=1)

print(new_df.head(2))
"""

df = pd.read_csv(pathFile,
                 converters={column: json.loads for column in dict_cols}, 
                 dtype={'fullVisitorId': 'str'}, # Important!!
                 nrows=None)

for column in dict_cols:
    column_as_df = json_normalize(df[column])
    print(column_as_df)
    column_as_df.columns = [f"{column}.{subcolumn}" for subcolumn in column_as_df.columns]
    df = df.drop(column, axis=1).merge(column_as_df, right_index=True, left_index=True)

data = pd.read_csv(pathFile,sep=',',header=0)

for index,rows in data.head(1).iterrows():
    for elem,col in zip(rows,cols):
        print('--'*20)        
        print(col)
        print('--'*20)  
        print(elem)
"""





