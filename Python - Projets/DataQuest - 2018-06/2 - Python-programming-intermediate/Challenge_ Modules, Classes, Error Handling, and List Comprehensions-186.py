## 2. Introduction to the Data ##

import csv

with open('nfl_suspensions_data.csv', 'r') as f:
    nfl_suspensions = list(csv.reader(f))

nfl_suspensions.pop(0)

years = {}

for suspension in nfl_suspensions:
    try:
        years[suspension[5]] +=1
    except:
        years[suspension[5]] =1
        
print(years)




        

        
        

## 3. Unique Values ##

teams = [row[1] for row in nfl_suspensions]
unique_teams = set(teams)

games = [row[2] for row in nfl_suspensions]
unique_games = set(games)

print(unique_teams)

print(unique_games)



## 4. Suspension Class ##

class Suspension:
    
    def __init__(self,row):
        self.name = row[0]
        self.team =row[1]
        self.games = row[2]
        self.year = row[5]
        
third_suspension = Suspension(nfl_suspensions[2])

        

## 5. Tweaking the Suspension Class ##

class Suspension():
    def __init__(self,row):
        self.name = row[0]
        self.team = row[1]
        self.games = row[2]
        self.year = row[5]
        
    def get_year(self):
        try:
            return int(self.year)
        except:
            return 0

missing_year = Suspension(nfl_suspensions[22])

twenty_third_year = missing_year.get_year()
                          
print(twenty_third_year)
                          
                          
                          