aviation_data=list()
aviation_list = list()

with open('AviationData.txt','r') as f:
    for row in f:
        aviation_data.append(row)

for row in aviation_data:
    aviation_list.append(row.split('|'))
 
"""
print(aviation_list[3])

for row in aviation_list:
    if row[2].strip() == 'LAX94LA336':
        lax_code = row
        break

print(lax_code)            

import math

aviation_list.sort(key=lambda x:x[2].strip())

def find_value(value,lower,higher):
    
    while(higher>=lower):
        index = math.floor((lower+higher)/2)
        code = aviation_list[index][2].strip()
        #print('lower {} - higher {} - index {} - code {}'.format(lower,higher,index,code))
        
        if value<code:
            higher=index-1
        if value>code:
            lower=index+1
        if value==code:
            return index        
    return -1

print(find_value('LAX94LA336',
                 0,
                 len(aviation_list)-1))
"""

header = aviation_data[0].split('|')

aviation_dict_list = list()
#print(header)
lax_dict =dict()

for row in aviation_data[1:]:
    header_dict = dict()
    for row_split,head in zip(row.split('|'),header):         
        header_dict[head.strip()]=row_split.strip()

    aviation_dict_list.append(header_dict)

"""    
for dictio in aviation_dict_list:
    if dictio['Accident Number']=='LAX94LA336':
        lax_dict=dictio


print(lax_dict)

state_accidents_list = list()

for dicti in aviation_dict_list:
    state = dicti['Location'].split(',')
    try:
        state_accidents_list.append(state[1])
    except:
        pass
    
state_accidents = len(state_accidents_list)

from collections import Counter

state_stats = Counter(state_accidents_list)

most_state = state_stats.most_common(1)

print(state_accidents)
print(most_state)

"""

year_injuries = dict()    
monthly_injuries = dict()
monthly_year_injuries = dict()

for dicti in aviation_dict_list:
    date = dicti['Event Date'].split('/')  
    
    try :
        total = int(dicti['Total Fatal Injuries'])
    except:
        total = 0
    try:
        total += int(dicti['Total Serious Injuries'])
    except:
        total +=0
           
    try:
        year_month = date[2]+'-'+date[0]
        month = date[0]
        year = date[2]
        try:
            year_injuries[year]+=total
        except:
            year_injuries[year]=0
        try:   
            monthly_injuries[month]+=total
        except:
            monthly_injuries[month]=0
        try:
            monthly_year_injuries[year_month]+=total
        except:
            monthly_year_injuries[year_month]=0
    except:        
        pass

max_year = max(year_injuries.keys(),key=(lambda x:year_injuries[x]))
               
max_year_value =  year_injuries[max_year]              

print('---'*25)
print(max_year)               
print(max_year_value)
print('---'*25)
               
max_month = max(monthly_injuries.keys(),key=(lambda x:monthly_injuries[x]))
               
max_month_value =  monthly_injuries[max_month]              

print(max_month)               
print(max_month_value)               
print('---'*25)

max_month_year = max(monthly_year_injuries.keys(),key=(lambda x:monthly_year_injuries[x]))
               
max_month_year_value =  monthly_year_injuries[max_month_year]              

print(max_month_year)               
print(max_month_year_value)  
print('---'*25)






