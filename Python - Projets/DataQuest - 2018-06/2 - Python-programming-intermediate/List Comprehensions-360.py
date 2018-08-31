## 2. Enumerate ##

ships = ["Andrea Doria", "Titanic", "Lusitania"]
cars = ["Ford Edsel", "Ford Pinto", "Yugo"]

for index, ship in enumerate(ships):
    print(ship)
    print(cars[index])
    
    

## 3. Adding Columns ##

things = [["apple", "monkey"], ["orange", "dog"], ["banana", "cat"]]
trees = ["cedar", "maple", "fig"]

for index, item in enumerate(things):
    item.append(trees[index])
    
print(things)    
    
    
    

## 4. List Comprehensions ##

apple_prices = [100, 101, 102, 105]

apple_prices_doubled = [price*2 for price in apple_prices]

print(apple_prices_doubled)

apple_prices_lowered = [price-100 for price in apple_prices]

print(apple_prices_lowered)





## 5. Counting Female Names ##

name_counts = {}

for row in legislators:
    if row[3]=='F'and row[7]>1940 :
        name = row[1]
        try:
            name_counts[name] += 1
        except:
            name_counts[name] = 1

print(name_counts)


            
        

## 7. Comparing with None ##

values = [None, 10, 20, 30, None, 50]
checks = []

for value in values:
    checks.append((value is not None) and (value > 30))
    
print(checks)




## 8. Highest Female Name Count ##

max_value = None

for key, value in name_counts.items():
    count = value
    if max_value is None or count > max_value:
        max_value = count
        
print(max_value)



## 9. The Items Method ##

plant_types = {"orchid": "flower", "cedar": "tree", "maple": "tree"}

for plant,typep in plant_types.items():
    print(plant)
    print(typep)
    
    

## 10. Finding the Most Common Female Names ##

top_female_names = []

for name,count in name_counts.items():
    if count==2:
        top_female_names.append(name)
        
top_female_names = set(top_female_names)

print(top_female_names)




## 11. Finding the Most Common Male Names ##

top_male_names = []
highest_male_count = None
male_name_counts={}

for legis in legislators:
    if legis[3]=='M' and legis[7]>1940:
        try:
            male_name_counts[legis[1]]+=1
            
            if (highest_male_count is None 
                or male_name_counts[legis[1]] >highest_male_count) :
                
                highest_male_count = male_name_counts[legis[1]]
                
        except:
            male_name_counts[legis[1]]=1

top_male_names = [key for key,value in  male_name_counts.items() if value == highest_male_count]


