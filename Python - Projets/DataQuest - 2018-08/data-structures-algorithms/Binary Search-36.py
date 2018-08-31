## 4. Implementing Binary Search: Part 1 ##

# A function to extract a player's last name
def format_name(name):
    return name.split(" ")[1] + ", " + name.split(" ")[0]

# The length of the data set
length = len(nba)

# Implement the player_age function. For now, just return what the instructions specify
def player_age(name):
    # We need to format our name appropriately for successful comparison
    name = format_name(name)
    # First guess halfway through the list
    first_guess_index = math.floor(length/2)
    first_guess = format_name(nba[first_guess_index][0])
    # Check where we should continue searching
    if name==first_guess:
        return "found"
    elif name[0]<first_guess[0]:
        return "earlier"
    else:
        return "later"
    
johnson_odom_age = player_age("Darius Johnson-Odom")
young_age = player_age("Nick Young")
adrien_age = player_age("Jeff Adrien")


    

## 5. Implementing Binary Search: Part 2 ##

# A function to extract a player's last name
def format_name(name):
    return name.split(" ")[1] + ", " + name.split(" ")[0]

# The length of the data set
length = len(nba)

# Implement the player_age function. For now, just return what the instructions specify
def player_age(name):
    # We need to format our name appropriately for successful comparison
    name = format_name(name)
    # Initial bounds of the search
    upper_bound = length - 1
    lower_bound = 0
    # Index of first split
    first_guess_index = math.floor(length/2)
    first_guess = format_name(nba[first_guess_index][0])
    
    if name<first_guess:
            upper_bound = math.floor((upper_bound+1+lower_bound)/2)-1
            lower_bound = lower_bound 
    elif name>first_guess:
            lower_bound = math.floor((upper_bound+1+lower_bound)/2)+1
            upper_bound = upper_bound
    else:
        return first_guess
    
    second_guess_index = math.floor((upper_bound+lower_bound)/2)
    second_guess = format_name(nba[second_guess_index][0])
    
    return second_guess

gasol_age = player_age("Pau Gasol")
pierce_age = player_age("Paul Pierce")


## 7. Implementing Binary Search: Part 3 ##

# A function to extract a player's last name
def format_name(name):
    return name.split(" ")[1] + ", " + name.split(" ")[0]

# The length of the data set
length = len(nba)


def player_age(name):
    name = format_name(name)        
    upper_bound = length - 1
    lower_bound = 0
    
    while(upper_bound>=lower_bound):      
        index = math.floor((upper_bound + lower_bound) / 2)
        guess = format_name(nba[index][0])
        
        if name<guess:
            upper_bound = index-1            
        elif name>guess:
            lower_bound = index+1            
        else:
            return "found"
    return -1

carmelo_age = player_age("Carmelo Anthony")




## 8. Implementing Binary Search: Part 4 ##

# A function to extract a player's last name
def format_name(name):
    return name.split(" ")[1] + ", " + name.split(" ")[0]

# The length of the data set
length = len(nba)

def player_age(name):
    name = format_name(name)        
    upper_bound = length - 1
    lower_bound = 0
    
    while(upper_bound>=lower_bound):      
        index = math.floor((upper_bound + lower_bound) / 2)
        guess = format_name(nba[index][0])
        
        if name<guess:
            upper_bound = index-1            
        elif name>guess:
            lower_bound = index+1            
        else:
            return nba[index][2]
    return -1

curry_age = player_age("Stephen Curry")
griffin_age = player_age("Blake Griffin")
jordan_age = player_age("Michael Jordan")


