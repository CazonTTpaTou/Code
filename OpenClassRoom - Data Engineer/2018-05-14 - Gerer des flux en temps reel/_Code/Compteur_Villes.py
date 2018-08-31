
villes = {}
empty_stations = [{'contract_name':'Marseille'},
                {'contract_name':'Paris'},
                {'contract_name':'Paris'},
                {'contract_name':'Marseille'},
                {'contract_name':'Marseille',}]

for stations in empty_stations:
    city = stations["contract_name"] 
    if city not in villes:
        villes[city]={'nombre-station-vide':1}
    else:
        villes[city]['nombre-station-vide']+=1

print(villes)



