## 1. Introduction to the Data ##

import pandas as pd
nba = pd.read_csv("nba_2013.csv")

# The names of the columns in the data
print(nba.columns.values)

## 3. Finding Similar Rows With Euclidean Distance ##

selected_player = nba[nba["player"] == "LeBron James"].iloc[0]
distance_columns = ['age', 'g', 'gs', 'mp', 'fg', 'fga', 'fg.', 'x3p', 'x3pa', 'x3p.', 'x2p', 'x2pa', 'x2p.', 'efg.', 'ft', 'fta', 'ft.', 'orb', 'drb', 'trb', 'ast', 'stl', 'blk', 'tov', 'pf', 'pts']

def euclidian_distance(serie1,serie2):
    distance=0
    for index in distance_columns:        
        distance+=(serie2[index]-serie1[index])**2
    return distance**(1/2)
    
lebron_distance = nba.apply(lambda x : euclidian_distance(x,selected_player),axis=1)    

print(lebron_distance)


## 4. Normalizing Columns ##

nba_numeric = nba[distance_columns]

nba_normalized = (nba_numeric-nba_numeric.mean())/nba_numeric.std()



## 5. Finding the Nearest Neighbor ##

from scipy.spatial import distance

# Fill in the NA values in nba_normalized
nba_normalized.fillna(0, inplace=True)

# Find the normalized vector for Lebron James
lebron_normalized = nba_normalized[nba["player"] == "LeBron James"]

# Find the distance between Lebron James and everyone else.
euclidean_distances = nba_normalized.apply(lambda row: distance.euclidean(row, lebron_normalized), axis=1)

index = euclidean_distances.sort_values(ascending=True).index.tolist()[1]

most_similar_to_lebron = nba.loc[index,'player']



## 6. Generating Training and Testing Sets ##

['import random\nfrom numpy.random import permutation\n\n# Randomly shuffle the index of nba\nrandom_indices = permutation(nba.index)\n# Set a cutoff for how many items we want in the test set (in this case 1/3 of the items)\ntest_cutoff = math.floor(len(nba)/3)\n# Generate the test set by taking the first 1/3 of the randomly shuffled indices\ntest = nba.loc[random_indices[1:test_cutoff]]\n# Generate the train set with the rest of the data\ntrain = nba.loc[random_indices[test_cutoff:]]\n\n']

## 7. Using sklearn ##

# The columns that we'll be using to make predictions
x_columns = ['age', 'g', 'gs', 'mp', 'fg', 'fga', 'fg.', 'x3p', 'x3pa', 'x3p.', 'x2p', 'x2pa', 'x2p.', 'efg.', 'ft', 'fta', 'ft.', 'orb', 'drb', 'trb', 'ast', 'stl', 'blk', 'tov', 'pf']
# The column we want to predict
y_column = ["pts"]

from sklearn.neighbors import KNeighborsRegressor
# Create the kNN model
knn = KNeighborsRegressor(n_neighbors=5)
# Fit the model on the training data
knn.fit(train[x_columns], train[y_column])
# Make predictions on the test set using the fit model
predictions = knn.predict(test[x_columns])

## 8. Computing Error ##

import numpy as np

actual = test[y_column]

mse = ((predictions-actual)**2).sum() / len(predictions)

rmse = mse**(1/2)

print(mse)

print(rmse)

print(actual.mean())

print(predictions.mean())

print(predictions.std())






