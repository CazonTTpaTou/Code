import pandas as pd

Path = 'c:\\users\\monne\\Desktop\\Google Analytics Customers'
Name = 'train.csv'

pathFile = '\\'.join([Path,Name])

data = pd.read_csv(pathFile)

dict_cols = ['trafficSource','totals','geoNetwork','device'] 

for index,row in data[dict_cols].head(1).iterrows():
    print('--'*20)
    print(index)
    print('--'*20)
    for elem in row:
        print(type(elem))
        print(elem)

data.head(20).to_csv(r'C:\\Users\\monne\\Desktop\\Train_Extrait.txt', header=True, index=True, sep=',', mode='a')

