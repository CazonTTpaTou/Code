# -*- coding: utf-8 -*-
"""
Created on Mon Dec 11 13:52:52 2017

@author: fmonnery
"""

from sklearn.datasets import make_moons
from sklearn.model_selection import train_test_split
from sklearn.ensemble import BaggingClassifier

import matplotlib.pyplot as plt

from plot_helpers import discrete_scatter
from plot_2d_separator import plot_2d_separator
from plot_interactive_tree import plot_tree_partition

X, y = make_moons(n_samples=100, noise=0.25)

X_train, X_test, y_train, Y_test = train_test_split(X,y,stratify=y)

bagging = BaggingClassifier(n_estimators=5)
bagging.fit(X_train,y_train)

pythonfig, axes = plt.subplots(2, 3, figsize=(20, 10))

for i, (ax, tree) in enumerate(zip(axes.ravel(), bagging.estimators_)):
    ax.set_title("Tree {}".format(i))
    plot_tree_partition(X_train, y_train, tree, ax=ax)
    
plot_2d_separator(bagging, X_train, fill=True, ax=axes[-1, -1],alpha=.4)

axes[-1, -1].set_title("Bagging")
discrete_scatter(X_train[:, 0], X_train[:, 1], y_train)


















