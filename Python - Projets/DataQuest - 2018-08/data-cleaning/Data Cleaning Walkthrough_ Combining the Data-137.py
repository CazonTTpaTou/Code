## 3. Condensing the Class Size Data Set ##

class_size = data["class_size"]

class_size = class_size[class_size["GRADE "]=='09-12']

class_size = class_size[class_size["PROGRAM TYPE"]=='GEN ED']

class_size.head()




## 5. Computing Average Class Sizes ##

import numpy as np

grouped = class_size.groupby("DBN")

class_size = grouped.agg(np.mean)

class_size.reset_index(inplace=True)

data["class_size"] = class_size

data["class_size"].head()



## 7. Condensing the Demographics Data Set ##

data["demographics"] = data["demographics"][data["demographics"]["schoolyear"]==20112012]

data["demographics"].head()



## 9. Condensing the Graduation Data Set ##

data["graduation"] = data["graduation"][data["graduation"]["Cohort"]=="2006"]

data["graduation"] = data["graduation"][data["graduation"]["Demographic"]=="Total Cohort"]

data["graduation"].head()





## 10. Converting AP Test Scores ##

cols = ['AP Test Takers ', 'Total Exams Taken', 'Number of Exams with scores 3 4 or 5']

for column in cols:
    data["ap_2010"][column]=pd.to_numeric(data["ap_2010"][column],errors="coerce")
    
print(data["ap_2010"].dtypes)



           

## 12. Performing the Left Joins ##

combined = data["sat_results"]

combined = combined.merge(data["ap_2010"],how="left")
combined = combined.merge(data["graduation"],how="left")

print(combined.shape)

combined.head()






## 13. Performing the Inner Joins ##

sets=['class_size','demographics','survey','hs_directory']

for dset in sets:
    combined = combined.merge(data[dset],on="DBN",how="inner")
    
print(combined.shape)    
    
combined.head(5)    



## 15. Filling in Missing Values ##

combined = combined.fillna(combined.mean())
combined = combined.fillna(0)

print(combined.head(5))




## 16. Adding a School District Column for Mapping ##

def extract_two_first_character(value):
    return value[:2]

combined["school_dist"] = combined["DBN"].apply(extract_two_first_character)

combined["school_dist"][:5]



