## 2. Calculating expected values ##

population = 32561  

males_over50k = 0.241*0.669 * population

males_under50k = 0.669*0.759 * population

females_over50k = 0.331 * 0.241 * population

females_under50k = 0.331 * 0.759 * population





## 3. Calculating chi-squared ##

population = 32561  

males_over50k = 0.241*0.669 * population

males_under50k = 0.669*0.759 * population

females_over50k = 0.331 * 0.241 * population

females_under50k = 0.331 * 0.759 * population

def chi2(observed,expected):
    return ((observed-expected)**2)/expected

chisq_gender_income = (chi2(6662,round(males_over50k,1))
                      +chi2(15128,round(males_under50k,1))
                      +chi2(1179,round(females_over50k,1))
                      +chi2(9592,round(females_under50k,1)))



## 4. Finding statistical significance ##

import numpy as np
from scipy.stats import chisquare

observed = [6662, 1179, 15128, 9592]
expected = [5249.8, 2597.4, 16533.5, 8180.3]

chisq_value, pvalue_gender_income = chisquare(np.array(observed),
                                              np.array(expected))





## 5. Cross tables ##

import pandas as pd

table = pd.crosstab(income['sex'],[income['race']])

print(table)





## 6. Finding expected values ##

import numpy as np
from scipy.stats import chi2_contingency

table = pd.crosstab(income['sex'],[income['race']])

chisq_value, pvalue_gender_race,df,expected = chi2_contingency(table)
                                   
                                   