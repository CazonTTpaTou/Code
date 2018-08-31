## 2. Introduction to the Data Set ##

import pandas as pd

rawData = pd.read_csv('train.csv')
trainData = rawData[['Survived','Pclass','Sex','Age','SibSp','Parch','Fare','Embarked']]

titanic = trainData.dropna() 


## 3. Creating Histograms In Seaborn ##

import seaborn as sns
import matplotlib.pyplot as plt

sns.distplot(titanic["Age"])
plt.show()

## 4. Generating A Kernel Density Plot ##

sns.kdeplot(titanic["Age"],shade=True)
plt.xlabel("Age")

plt.show()


## 5. Modifying The Appearance Of The Plots ##

sns.set_style("white")
sns.kdeplot(titanic["Age"],shade=True)

sns.despine(left=True,bottom=True)
plt.xlabel("Age")

plt.show()




## 6. Conditional Distributions Using A Single Condition ##

g = sns.FacetGrid(titanic, col="Pclass", size=6)
g.map(sns.kdeplot, "Age", shade=True)
sns.despine(left=True, bottom=True)
plt.show()