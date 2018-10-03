import pandas as pd

Categories = {
        "EDF": "Charges",
        "FREE": "Charges",
        "SFR": "Charges",
        "LECLERC": "Courses",
        "DRFIP": "Impôts",
        "DUPRONT": "Loyer",
        "SNCF": "Transport",
        }

def map_categorie(words):
    cat = 'Autres'
    for wd,val in Categories.items():
        if wd in str(words):
            return val
    return cat

def convert_integer(text):
    if type(text)==float:
        return text
    else:
        text_int = text.replace(',','.')
        return float(text_int)

path = 'c:\\users\\monne\\desktop'
name = 'Historique.csv'
fileName = '\\'.join([path,name])

data = pd.read_csv(fileName,encoding='latin-1',delimiter=';')

data['type'] = data['Libellé'].apply(map_categorie)

data[['Débit','Crédit']].fillna(0)
data['Débit'] = data['Débit'].apply(convert_integer)
data['Crédit'] = data['Crédit'].apply(convert_integer)

print(data.head())

func = lambda x : round(100*x.sum()/data['Débit'].sum(),2)

tcd_depenses = data.pivot_table(index='type',values='Débit',aggfunc=sum,margins=True)
tcd_depenses_ratio = data.pivot_table(index='type',values='Débit',aggfunc=func,margins=True)

print(tcd_depenses)
print(tcd_depenses_ratio)

saveFile = 'C:\\Users\\monne\\Desktop\\Budget.txt'

with open(saveFile,'w') as f:
    f.writelines('--'*20)
    f.writelines('\n')
    tcd_depenses.to_string(f)
    
    f.writelines('\n')
    f.writelines('--'*20)
    f.writelines('\n')
    tcd_depenses_ratio.to_string(f)




