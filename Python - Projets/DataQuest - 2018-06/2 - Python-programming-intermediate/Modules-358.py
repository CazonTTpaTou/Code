## 1. Introduction to Modules ##

import math

root=math.sqrt(99)
flr=math.floor(89.9)

## 2. Importing Using An Alias ##

import math as m

root = m.sqrt(33)

## 3. Importing A Specific Object ##

from math import *

root=sqrt(1001)

## 4. Variables Within Modules ##

import math

print(math.pi)

a = math.sqrt(math.pi)
b = math.ceil(math.pi)
c = math.floor(math.pi)

## 5. The CSV Module ##

import csv

f = open("nfl.csv")
csvreader = csv.reader(f)

nfl = list(csvreader)

## 6. Counting How Many Times a Team Won ##

import csv
f = open("nfl.csv", "r")
nfl = list(csv.reader(f))

patriots_wins = 0

for game in nfl:
    if game[2]=='New England Patriots':
        patriots_wins +=1
        

## 7. Making a Function that Counts Wins ##

import csv

f = open("nfl.csv", 'r')
nfl = list(csv.reader(f))

# Define your function here.
def nfl_wins(name):
    numberVictories = 0
    for game in nfl:
        if game[2]==name:
            numberVictories+=1
    
    return numberVictories          

cowboys_wins=nfl_wins("Dallas Cowboys")
falcons_wins = nfl_wins("Atlanta Falcons")

