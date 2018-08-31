
# coding: utf-8

# # Analyse Python - Chargement de données

# ## Ecrire données au format texte

# In[ ]:


pd.read_csv('texte.txt',na_values=['NULL'])
sentinels = {'colonne1':['foo','NA'],'colonne2':['two']}
pd.read_csv('texte.txt',na_values=sentinels)

pd.read_csv('texte.txt',header=0)
pd.read_csv('texte.txt',header=None)

pd.read_csv('texte.txt',index_col=5)

pd.read_csv('texte.txt',names=[col1,col2,col3])

pd.read_csv('texte.txt',skiprows=3)

pd.read_csv('texte.txt',skip_footer=2)

pd.read_csv('texte.txt',encoding='utf-8')


# ## Lire un fichier en petits morceaux

# In[ ]:


chunker pd.read_csv('texte.txt',chunksize=1000)
tot = Series([])
for piece in chunker:
    tot = tot.add(piece['key'].value_counts(),fill_value=0)

tot = tot.order(ascending=False)


# ## Ecrire des données

# In[ ]:


data.to_csv('texte.csv')
data.to_csv('texte.csv',sep='|')


# In[ ]:


import csv
f = open('fichier.txt')
reader = csv.reader(f)

for line in reader:
    print line
    
lines = list(csv.reader(open('texte2.txt')))
header, values = lines[0], lines[1:]

data_dict = {h : v for h,v in zip(header,zip(*values))}



# ## Données JSON

# In[ ]:


import json
result = json.loads(obj)

asjson = json.dumps(result)


# ## Données Web

# In[2]:


from lxml.html import parse
from urllib.request import urlopen

parsed = parse(urlopen('http://finance.yahoo.com/q/op?s=AAPL+Options'))
doc = parsed.getroot()


# In[5]:


links = doc.findall('.//a')
lnk = links[28]
lnk.get('href')


# In[6]:


lnk.text_content()


# In[7]:


urls = [lnk.get('href') for lnk in doc.findall('.//a')]
urls[-10:]


# In[10]:


tables = doc.findall('.//table')
calls = tables[0]
puts = tables[0]


# In[ ]:


from pandas.io.parsers import TextParser

def parse_options_data(table):
    rows = table.findall('.//tr')
    header=_unpack(rows[0],kind='th')
    data=[_unpack(r) for r in rows[1:]]
    
    return TextParser(data,names=header).get_chunk()

call_data = parse_options_data(calls)
put_data = parse_options_data(puts)


# ## Fichiers Excel

# In[ ]:


xls_file = pd.ExcelFile('data.xls')
table = xls_file.parse('Sheet1')

