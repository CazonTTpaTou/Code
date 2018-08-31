## 1. Introduction to the data ##

import pandas as pd
cars = pd.read_csv("auto.csv")

unique_regions = cars['origin'].unique()

print(unique_regions)




## 2. Dummy variables ##

dummy_cylinders = pd.get_dummies(cars["cylinders"], prefix="cyl")
cars = pd.concat([cars, dummy_cylinders], axis=1)

dummy_years = pd.get_dummies(cars['year'],prefix='year')
cars = pd.concat([cars,dummy_years],axis=1)

cars = cars.drop(columns=['cylinders',
                          'year'])

print(cars[:5])



## 3. Multiclass classification ##

shuffled_rows = np.random.permutation(cars.index)
shuffled_cars = cars.iloc[shuffled_rows]

index = int(len(shuffled_rows)*0.70)

train = shuffled_cars[:index]

test = shuffled_cars[index:]






## 4. Training a multiclass logistic regression model ##

from sklearn.linear_model import LogisticRegression

unique_origins = cars["origin"].unique()
unique_origins.sort()

models = {}

X_columns = [x for x in cars.columns if x.startswith("year") or x.startswith("cyl")]

X = cars[X_columns]

for origin in unique_origins:
    Y = cars['origin']==origin
    lr = LogisticRegression()
    
    models[origin] = lr.fit(X,Y)
    
print(models)




## 5. Testing the models ##

testing_probs = pd.DataFrame(columns=unique_origins)  

for origin in unique_origins:
    # Select testing features.
    X_test = test[features]   
    # Compute probability of observation being in the origin.
    testing_probs[origin] = models[origin].predict_proba(X_test)[:,1]
    
print(testing_probs)



## 6. Choose the origin ##

predicted_origins = testing_probs.idxmax(axis=1)

print(predicted_origins)

