## 1. Introduction ##

import pandas as pd

train = pd.read_csv('train.csv')
holdout = pd.read_csv('test.csv')

def process_age(df):
    df["Age"] = df["Age"].fillna(-0.5)
    cut_points = [-1,0,5,12,18,35,60,100]
    label_names = ["Missing","Infant","Child","Teenager","Young Adult","Adult","Senior"]
    df["Age_categories"] = pd.cut(df["Age"],cut_points,labels=label_names)
    return df

def create_dummies(df,column_name):
    dummies = pd.get_dummies(df[column_name],prefix=column_name)
    df = pd.concat([df,dummies],axis=1)
    return df

columns = ["Age_categories", "Pclass","Sex"]

train = process_age(train)
holdout = process_age(holdout)

for col in columns:
    train = create_dummies(train,col)
    holdout = create_dummies(holdout,col)    

print(train.columns)



## 2. Preparing More Features ##

from sklearn.preprocessing import minmax_scale
# The holdout set has a missing value in the Fare column which
# we'll fill with the mean.
holdout["Fare"] = holdout["Fare"].fillna(train["Fare"].mean())

train["Embarked"] = train["Embarked"].fillna("S")
train = create_dummies(train,"Embarked")

holdout["Embarked"] = holdout["Embarked"].fillna("S")
holdout = create_dummies(holdout,"Embarked")

train["SibSp_scaled"] = minmax_scale(train["SibSp"])
train["Parch_scaled"] = minmax_scale(train["Parch"])
train["Fare_scaled"] = minmax_scale(train["Fare"])

holdout["SibSp_scaled"] = minmax_scale(holdout["SibSp"])
holdout["Parch_scaled"] = minmax_scale(holdout["Parch"])
holdout["Fare_scaled"] = minmax_scale(holdout["Fare"])



## 3. Determining the Most Relevant Features ##

import matplotlib.pyplot as plt
from sklearn.linear_model import LogisticRegression

columns = ['Age_categories_Missing', 'Age_categories_Infant',
       'Age_categories_Child', 'Age_categories_Teenager',
       'Age_categories_Young Adult', 'Age_categories_Adult',
       'Age_categories_Senior', 'Pclass_1', 'Pclass_2', 'Pclass_3',
       'Sex_female', 'Sex_male', 'Embarked_C', 'Embarked_Q', 'Embarked_S',
       'SibSp_scaled', 'Parch_scaled', 'Fare_scaled']

lr = LogisticRegression()
lr.fit(train[columns],train['Survived'])

coefficients=lr.coef_
feature_importance=pd.Series(coefficients[0],index=columns)

feature_importance.plot.barh()




## 4. Training a model using relevant features. ##

from sklearn.model_selection import cross_val_score

columns = ['Age_categories_Infant', 'SibSp_scaled', 'Sex_female', 'Sex_male',
       'Pclass_1', 'Pclass_3', 'Age_categories_Senior', 'Parch_scaled']

lro = LogisticRegression()

scores = cross_val_score(lro,train[columns],train['Survived'],cv=10)

accuracy = scores.mean()

print(accuracy)




## 5. Submitting our Improved Model to Kaggle ##

columns = ['Age_categories_Infant', 'SibSp_scaled', 'Sex_female', 'Sex_male',
       'Pclass_1', 'Pclass_3', 'Age_categories_Senior', 'Parch_scaled']

all_X = train[columns]
all_y = train['Survived']

lro = LogisticRegression()
lro.fit(all_X,all_y)

holdout_predictions = lro.predict(holdout[columns])

holdout_df = {'PassengerId':holdout['PassengerId'],
              'Survived':holdout_predictions}

submission = pd.DataFrame(holdout_df)

submission.to_csv('submission_1.csv',
                 header=['PassengerId','Survived'],
                 index=False)








## 6. Engineering a New Feature Using Binning ##

def process_age(df,cut_points,label_names):
    df["Age"] = df["Age"].fillna(-0.5)
    df["Age_categories"] = pd.cut(df["Age"],cut_points,labels=label_names)
    return df

def process_fare(df,cut_points,label_names):   
    df["Fare_categories"] = pd.cut(df["Fare"],cut_points,labels=label_names)
    return df

cut_points=[0,12,50,100,1000]
label_names=['0-12','12-50','50-100','100+']

train = process_fare(train,cut_points,label_names)
holdout = process_fare(holdout,cut_points,label_names)

train=create_dummies(train,'Fare_categories')
holdout=create_dummies(holdout,'Fare_categories')




## 7. Engineering Features From Text Columns ##

titles = {
    "Mr" :         "Mr",
    "Mme":         "Mrs",
    "Ms":          "Mrs",
    "Mrs" :        "Mrs",
    "Master" :     "Master",
    "Mlle":        "Miss",
    "Miss" :       "Miss",
    "Capt":        "Officer",
    "Col":         "Officer",
    "Major":       "Officer",
    "Dr":          "Officer",
    "Rev":         "Officer",
    "Jonkheer":    "Royalty",
    "Don":         "Royalty",
    "Sir" :        "Royalty",
    "Countess":    "Royalty",
    "Dona":        "Royalty",
    "Lady" :       "Royalty"
}

extracted_titles = train["Name"].str.extract(' ([A-Za-z]+)\.',expand=False)
train["Title"] = extracted_titles.map(titles)

extracted_titles =holdout["Name"].str.extract(' ([A-Za-z]+)\.',expand=False)
holdout["Title"] = extracted_titles.map(titles)

train['Cabin_type']=train['Cabin'].str[0]
train['Cabin_type']=train['Cabin_type'].fillna('Unknown')

holdout['Cabin_type']=holdout['Cabin'].str[0]
holdout['Cabin_type']=holdout['Cabin_type'].fillna('Unknown')

for col in ['Title','Cabin_type']:
    train=create_dummies(train,col)
    holdout=create_dummies(holdout,col)




## 8. Finding Correlated Features ##

import numpy as np
import seaborn as sns

def plot_correlation_heatmap(df):
    corr = df.corr()
    
    sns.set(style="white")
    mask = np.zeros_like(corr, dtype=np.bool)
    mask[np.triu_indices_from(mask)] = True

    f, ax = plt.subplots(figsize=(11, 9))
    cmap = sns.diverging_palette(220, 10, as_cmap=True)


    sns.heatmap(corr, mask=mask, cmap=cmap, vmax=.3, center=0,
            square=True, linewidths=.5, cbar_kws={"shrink": .5})
    plt.show()

columns = ['Age_categories_Missing', 'Age_categories_Infant',
       'Age_categories_Child', 'Age_categories_Teenager',
       'Age_categories_Young Adult', 'Age_categories_Adult',
       'Age_categories_Senior', 'Pclass_1', 'Pclass_2', 'Pclass_3',
       'Sex_female', 'Sex_male', 'Embarked_C', 'Embarked_Q', 'Embarked_S',
       'SibSp_scaled', 'Parch_scaled', 'Fare_categories_0-12',
       'Fare_categories_12-50','Fare_categories_50-100', 'Fare_categories_100+',
       'Title_Master', 'Title_Miss', 'Title_Mr','Title_Mrs', 'Title_Officer',
       'Title_Royalty', 'Cabin_type_A','Cabin_type_B', 'Cabin_type_C', 'Cabin_type_D',
       'Cabin_type_E','Cabin_type_F', 'Cabin_type_G', 'Cabin_type_T', 'Cabin_type_Unknown']

plot_correlation_heatmap(train[columns])

## 9. Final Feature Selection using RFECV ##

from sklearn.feature_selection import RFECV

columns = ['Age_categories_Missing', 'Age_categories_Infant',
       'Age_categories_Child', 'Age_categories_Young Adult',
       'Age_categories_Adult', 'Age_categories_Senior', 'Pclass_1', 'Pclass_3',
       'Embarked_C', 'Embarked_Q', 'Embarked_S', 'SibSp_scaled',
       'Parch_scaled', 'Fare_categories_0-12', 'Fare_categories_50-100',
       'Fare_categories_100+', 'Title_Miss', 'Title_Mr', 'Title_Mrs',
       'Title_Officer', 'Title_Royalty', 'Cabin_type_B', 'Cabin_type_C',
       'Cabin_type_D', 'Cabin_type_E', 'Cabin_type_F', 'Cabin_type_G',
       'Cabin_type_T', 'Cabin_type_Unknown']

all_X = train[columns]

all_y = train["Survived"]

lr = LogisticRegression()
selector=RFECV(lr,cv=10)
selector.fit(all_X,all_y)
optimized_columns = all_X.columns[selector.support_]



## 10. Training A Model Using our Optimized Columns ##

all_X = train[optimized_columns]
all_y = train["Survived"]

lr = LogisticRegression()
scores = cross_val_score(lr,all_X,all_y,cv=10)

accuracy = scores.mean()




## 11. Submitting our Model to Kaggle ##

lr = LogisticRegression()
lr.fit(all_X,all_y)

holdout_predictions = lr.predict(holdout[optimized_columns])

holdout_df = {'PassengerId':holdout['PassengerId'],
              'Survived':holdout_predictions}

submission = pd.DataFrame(holdout_df)

submission.to_csv('submission_2.csv',
                 header=['PassengerId','Survived'],
                 index=False)



