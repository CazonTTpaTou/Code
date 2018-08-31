import pandas as pd
import matplotlib.pyplot as plt

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


