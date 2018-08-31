## 1. Recap ##

import pandas as pd

loans = pd.read_csv('cleaned_loans_2007.csv')

print(loans.info())



## 3. Picking an error metric ##

import pandas as pd

tn = sum((predictions==0) & (loans["loan_status"]==0))

tp = sum((predictions==1) & (loans["loan_status"]==1))

fn = sum((predictions==0) & (loans["loan_status"]==1))

fp = sum((predictions==1) & (loans["loan_status"]==0))







## 5. Class imbalance ##

import pandas as pd
import numpy

# Predict that all loans will be paid off on time.
predictions = pd.Series(numpy.ones(loans.shape[0]))

loan_status = loans['loan_status']

tn = sum((predictions==0) & (loan_status==0))

tp = sum((predictions==1) & (loan_status==1))

fn = sum((predictions==0) & (loan_status==1))

fp = sum((predictions==1) & (loan_status==0))

fpr = fp/(fp+tn)

tpr = tp/(tp+fn)

print(fpr)

print(tpr)



## 6. Logistic Regression ##

from sklearn.linear_model import LogisticRegression
lr = LogisticRegression()

features = loans.drop(['loan_status'],axis=1)

target= loans['loan_status']

lr.fit(features,target)

predictions = lr.predict(features)




## 7. Cross Validation ##

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_predict

lr = LogisticRegression()

predictions = cross_val_predict(lr,
                                features,
                                target)


loan_status = target

tn = sum((predictions==0) & (loan_status==0))
tp = sum((predictions==1) & (loan_status==1))
fn = sum((predictions==0) & (loan_status==1))
fp = sum((predictions==1) & (loan_status==0))

fpr = fp/(fp+tn)

tpr = tp/(tp+fn)

print(fpr)
print(tpr)



## 9. Penalizing the classifier ##

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_predict

lr=LogisticRegression(class_weight='balanced')

predictions = cross_val_predict(lr,
                                features,
                                target)

pred = pd.Series(predictions)

tp = sum((pred==1) & (target==1))
tn = sum((pred==0) & (target==0))
fp = sum((pred==1) & (target==0))
fn = sum((pred==0) & (target==1))

tpr = tp/(tp+fn)
fpr = fp/(fp+tn)

print(tpr)
print(fpr)




## 10. Manual penalties ##

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_predict

penalty = {
    0:10,
    1:1
}

lr=LogisticRegression(class_weight=penalty)

predictions = cross_val_predict(lr,
                                features,
                                target,
                                cv=3)

pred = pd.Series(predictions)

tp = sum((pred==1) & (target==1))
tn = sum((pred==0) & (target==0))
fp = sum((pred==1) & (target==0))
fn = sum((pred==0) & (target==1))

tpr = tp/(tp+fn)
fpr = fp/(fp+tn)

print(tpr)
print(fpr)




## 11. Random forests ##

from sklearn.ensemble import RandomForestClassifier
from sklearn.cross_validation import cross_val_predict

rf = RandomForestClassifier(n_estimators=10,
                            random_state=1,
                            class_weight='balanced')

predictions = cross_val_predict(rf,
                                features,
                                target,
                                cv=3)

pred = pd.Series(predictions)

tp = sum((pred==1) & (target==1))
tn = sum((pred==0) & (target==0))
fp = sum((pred==1) & (target==0))
fn = sum((pred==0) & (target==1))

tpr = tp/(tp+fn)
fpr = fp/(fp+tn)

print(tpr)
print(fpr)





