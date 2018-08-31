import read

df = read.load_data()

domains = df['url'].value_counts().sort_values(ascending=False)

for name,row in domains[0:100].items():
    print('{0}: {1}'.format(name,row))



