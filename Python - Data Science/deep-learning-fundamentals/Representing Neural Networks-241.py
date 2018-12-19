## 5. Generating Regression Data ##

from sklearn.datasets import make_regression
import pandas as pd

data_set = make_regression(n_samples=100,
                           n_features=3,
                           random_state=1)

features = pd.DataFrame(data_set[0])

labels = pd.Series(data_set[1])



## 6. Fitting A Linear Regression Neural Network ##

from sklearn.datasets import make_regression
from sklearn.linear_model import SGDRegressor
import numpy as np

data = make_regression(n_samples=100, n_features=3, random_state=1)
features = pd.DataFrame(data[0])
labels = pd.Series(data[1])

features["biais"] = np.ones(features.shape[0])

def train(features,labels):
    sgd = SGDRegressor()
    sgd.fit(features,labels)
    return sgd.coef_[0]

def feedforward(features,weights):
    predictions = np.dot(features,
                            np.transpose(weights))
    return predictions

# Uncomment after you've implemented train() and feedforward()
train_weights = train(features, labels)
print(train_weights)
linear_predictions = feedforward(features, train_weights)

# linear_predictions = np.array(train_predictions,copy=True)





## 7. Generating Classification Data ##

from sklearn.datasets import make_classification

data = make_classification(n_samples=100,
                           n_features=4,
                           random_state=1)

data_features = data[0]
data_labels = data[1]

class_features = pd.DataFrame(data_features)

class_labels = pd.Series(data_labels)




## 8. Implementing A Neural Network That Performs Classification ##

from sklearn.linear_model import SGDClassifier
from sklearn.datasets import make_classification

class_data = make_classification(n_samples=100, n_features=4, random_state=1)
class_features = class_data[0]
class_labels = class_data[1]

# Uncomment this code when you're ready to test your functions.
# log_train_weights = log_train(class_features, class_labels)
# log_predictions = log_feedforward(class_features, log_train_weights)
def log_train(class_features, class_labels):
    sg = SGDClassifier()
    sg.fit(class_features, class_labels)
    return sg.coef_

def sigmoid(linear_combination):
    return 1/(1+np.exp(-linear_combination))

def log_feedforward(class_features, log_train_weights):
    linear_combination = np.dot(features, log_train_weights.T)
    log_predictions = sigmoid(linear_combination)
    log_predictions[log_predictions >= 0.5] = 1
    log_predictions[log_predictions < 0.5] = 0
    return log_predictions

log_train_weights = log_train(class_features, class_labels)
log_predictions = log_feedforward(class_features, log_train_weights)