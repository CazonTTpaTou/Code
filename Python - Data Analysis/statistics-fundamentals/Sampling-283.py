## 3. Populations and Samples ##

question1 = 'population'
question2 = 'population'
question3 = 'sample'
question4 = 'population'
question5 = 'sample'

## 4. Sampling Error ##

import pandas as pd
wnba = pd.read_csv('wnba.csv')

print(wnba.head())
print(wnba.tail())

print(wnba.shape)

parameter = wnba['Games Played'].max()

sample = wnba.sample(random_state=1)

statistic = sample['Games Played'].max()

sampling_error = parameter - statistic



## 5. Simple Random Sampling ##

import pandas as pd
import matplotlib.pyplot as plt

wnba = pd.read_csv('wnba.csv')
sample_means = []

for number in range(0,100):
    sample_means.append(wnba['PTS'].sample(10,random_state=number).mean())
    
sample_error = sample_means - wnba['PTS'].mean()    

plt.scatter(range(1,101),sample_means)

plt.axhline(wnba['PTS'].mean())

plt.show()


## 7. Stratified Sampling ##

import operator 

wnba['points_player']=wnba['PTS']/wnba['Games Played']
liste_strate = {}
means_points_position = {}

for strate in wnba['Pos'].unique():
    liste_strate[strate] = wnba[wnba['Pos']==strate]
                             
for key,stratum in liste_strate.items():
    sample = stratum.sample(10,random_state=0)                             
    means_points_position[key] = sample['points_player'].mean()
    
position_most_points = max(means_points_position.items(), key=operator.itemgetter(1))[0]    

print(max(means_points_position.items(), key=operator.itemgetter(1)))



## 8. Proportional Stratified Sampling ##

effectifs = wnba['Games Played'].value_counts(bins = 3, normalize = True) *10

intervalle = []
liste_pts_mean = []

eff = effectifs.reset_index()

for index,lig in enumerate(eff['index']):
    inter={}
    
    inter['borne_inf']=lig.left
    inter['borne_sup']=lig.right
    inter['effectif']=round(effectifs.values[index],0)
    
    intervalle.append(inter)

for number in range(100): 
    strate_liste=[]
    for inter in intervalle:

        condition1 = (wnba['Games Played']>inter['borne_inf']) 
        condition2 = (wnba['Games Played']<=inter['borne_sup'])
        condition = condition1 & condition2
        
        strate=wnba[condition].sample(int(round(inter['effectif'],0)),
                                      random_state=number)
        strate_liste.append(strate)
        
    population = pd.concat(strate_liste)
    liste_pts_mean.append(population['PTS'].mean())
     
plt.scatter(range(1,101),liste_pts_mean)
plt.axhline(wnba['PTS'].mean())

plt.show()


## 9. Choosing the Right Strata ##

effectifs = wnba['MIN'].value_counts(bins = 3, normalize = True) *12

intervalle = []
liste_pts_mean = []

eff = effectifs.reset_index()

for index,lig in enumerate(eff['index']):
    inter={}
    
    inter['borne_inf']=lig.left
    inter['borne_sup']=lig.right
    inter['effectif']=round(effectifs.values[index],0)
    
    intervalle.append(inter)

for number in range(100): 
    strate_liste=[]
    for inter in intervalle:

        condition1 = (wnba['MIN']>inter['borne_inf']) 
        condition2 = (wnba['MIN']<=inter['borne_sup'])
        condition = condition1 & condition2
        
        strate=wnba[condition].sample(int(round(inter['effectif'],0)),
                                      random_state=number)
        strate_liste.append(strate)
        
    population = pd.concat(strate_liste)
    liste_pts_mean.append(population['PTS'].mean())
     
plt.scatter(range(1,101),liste_pts_mean)
plt.axhline(wnba['PTS'].mean())

plt.show()

## 10. Cluster Sampling ##

cluster = pd.Series(wnba['Team'].unique()).sample(4,random_state=0)
listeclust = []

for clust in cluster.values:
    condition = wnba['Team']==clust
    data = wnba[condition]
    listeclust.append(data)
    
population = pd.concat(listeclust)

def calcul_error(criterion):
    return wnba[criterion].mean() - population[criterion].mean() 

sampling_error_height = calcul_error('Height')
sampling_error_age = calcul_error('Age')
sampling_error_BMI = calcul_error('BMI')
sampling_error_points = calcul_error('PTS')


