
# coding: utf-8

# # Read in the data

# In[27]:


import matplotlib.pyplot as plt
import pandas as pd
import numpy
import re

data_files = [
    "ap_2010.csv",
    "class_size.csv",
    "demographics.csv",
    "graduation.csv",
    "hs_directory.csv",
    "sat_results.csv"
]

data = {}

for f in data_files:
    d = pd.read_csv("schools/{0}".format(f))
    data[f.replace(".csv", "")] = d


# # Read in the surveys

# In[3]:


all_survey = pd.read_csv("schools/survey_all.txt", delimiter="\t", encoding='windows-1252')
d75_survey = pd.read_csv("schools/survey_d75.txt", delimiter="\t", encoding='windows-1252')
survey = pd.concat([all_survey, d75_survey], axis=0)

survey["DBN"] = survey["dbn"]

survey_fields = [
    "DBN", 
    "rr_s", 
    "rr_t", 
    "rr_p", 
    "N_s", 
    "N_t", 
    "N_p", 
    "saf_p_11", 
    "com_p_11", 
    "eng_p_11", 
    "aca_p_11", 
    "saf_t_11", 
    "com_t_11", 
    "eng_t_11", 
    "aca_t_11", 
    "saf_s_11", 
    "com_s_11", 
    "eng_s_11", 
    "aca_s_11", 
    "saf_tot_11", 
    "com_tot_11", 
    "eng_tot_11", 
    "aca_tot_11",
]
survey = survey.loc[:,survey_fields]
data["survey"] = survey


# # Add DBN columns

# In[4]:


data["hs_directory"]["DBN"] = data["hs_directory"]["dbn"]

def pad_csd(num):
    string_representation = str(num)
    if len(string_representation) > 1:
        return string_representation
    else:
        return "0" + string_representation
    
data["class_size"]["padded_csd"] = data["class_size"]["CSD"].apply(pad_csd)
data["class_size"]["DBN"] = data["class_size"]["padded_csd"] + data["class_size"]["SCHOOL CODE"]


# # Convert columns to numeric

# In[5]:


cols = ['SAT Math Avg. Score', 'SAT Critical Reading Avg. Score', 'SAT Writing Avg. Score']
for c in cols:
    data["sat_results"][c] = pd.to_numeric(data["sat_results"][c], errors="coerce")

data['sat_results']['sat_score'] = data['sat_results'][cols[0]] + data['sat_results'][cols[1]] + data['sat_results'][cols[2]]

def find_lat(loc):
    coords = re.findall("\(.+, .+\)", loc)
    lat = coords[0].split(",")[0].replace("(", "")
    return lat

def find_lon(loc):
    coords = re.findall("\(.+, .+\)", loc)
    lon = coords[0].split(",")[1].replace(")", "").strip()
    return lon

data["hs_directory"]["lat"] = data["hs_directory"]["Location 1"].apply(find_lat)
data["hs_directory"]["lon"] = data["hs_directory"]["Location 1"].apply(find_lon)

data["hs_directory"]["lat"] = pd.to_numeric(data["hs_directory"]["lat"], errors="coerce")
data["hs_directory"]["lon"] = pd.to_numeric(data["hs_directory"]["lon"], errors="coerce")


# # Condense datasets

# In[6]:


class_size = data["class_size"]
class_size = class_size[class_size["GRADE "] == "09-12"]
class_size = class_size[class_size["PROGRAM TYPE"] == "GEN ED"]

class_size = class_size.groupby("DBN").agg(numpy.mean)
class_size.reset_index(inplace=True)
data["class_size"] = class_size

data["demographics"] = data["demographics"][data["demographics"]["schoolyear"] == 20112012]

data["graduation"] = data["graduation"][data["graduation"]["Cohort"] == "2006"]
data["graduation"] = data["graduation"][data["graduation"]["Demographic"] == "Total Cohort"]


# # Convert AP scores to numeric

# In[7]:


cols = ['AP Test Takers ', 'Total Exams Taken', 'Number of Exams with scores 3 4 or 5']

for col in cols:
    data["ap_2010"][col] = pd.to_numeric(data["ap_2010"][col], errors="coerce")


# # Combine the datasets

# In[8]:


combined = data["sat_results"]

combined = combined.merge(data["ap_2010"], on="DBN", how="left")
combined = combined.merge(data["graduation"], on="DBN", how="left")

to_merge = ["class_size", "demographics", "survey", "hs_directory"]

for m in to_merge:
    combined = combined.merge(data[m], on="DBN", how="inner")

combined = combined.fillna(combined.mean())
combined = combined.fillna(0)


# # Add a school district column for mapping

# In[9]:


def get_first_two_chars(dbn):
    return dbn[0:2]

combined["school_dist"] = combined["DBN"].apply(get_first_two_chars)


# # Find correlations

# In[10]:


correlations = combined.corr()
correlations = correlations["sat_score"]
print(correlations)


# # Plotting survey correlations

# In[11]:


# Remove DBN since it's a unique identifier, not a useful numerical value for correlation.
survey_fields.remove("DBN")


# In[12]:


get_ipython().magic('matplotlib inline')


# In[19]:


survey_fields.append('sat_score')
correlations = combined[survey_fields].corr()
correlations


# In[23]:


correlations_sat = correlations['sat_score']
significatif = abs(correlations_sat) >0.25
correlations_significatives = correlations_sat[significatif]


# In[24]:


correlations_significatives.plot.barh()


# In[34]:


combined.plot.scatter(x='saf_s_11',y='sat_score')

plt.show()


# In[41]:


safety = combined[['school_dist','saf_s_11','lon','lat']]
#combined.columns


# In[42]:


import numpy as np
safety_dist = safety.groupby('school_dist').agg(np.mean)
safety_dist.reset_index(inplace=True)
safety_dist.head(5)


# In[43]:


from mpl_toolkits.basemap import Basemap

m = Basemap(
    projection='merc', 
    llcrnrlat=40.496044, 
    urcrnrlat=40.915256, 
    llcrnrlon=-74.255735, 
    urcrnrlon=-73.700272,
    resolution='i'
)

m.drawmapboundary(fill_color='#85A6D9')
m.drawcoastlines(color='#6D5F47', linewidth=.4)
m.drawrivers(color='#6D5F47', linewidth=.4)

longitude = list(safety_dist["lon"])
latitude  = list(safety_dist["lat"])

m.scatter(longitude,
          latitude,
          s=50,
          zorder=2,
          latlon=True,
          c=safety_dist["saf_s_11"],
          cmap="summer")

plt.show()


# In[44]:


race = ['white_per','asian_per','black_per','hispanic_per','sat_score']
score_race = combined[race]


# In[45]:


correlations_race = score_race.corr()
correlations_race_score = correlations_race['sat_score']


# In[46]:


correlations_race_score.plot.barh()


# In[48]:


combined.plot(x='hispanic_per',y='sat_score',kind="scatter")


# In[55]:


schools_hispanic = combined['SCHOOL NAME'][combined['hispanic_per']>95]
schools_hispanic


# In[50]:


combined.columns


# In[56]:


less_hispanic = combined['hispanic_per']<10
good_sat = combined['sat_score']>1800
conditions = (less_hispanic) & (good_sat)

schools_less_hispanic = combined['SCHOOL NAME'][conditions]
schools_less_hispanic


# In[57]:


combined['hispanic_per'].head(5)


# In[60]:


gender = combined[['male_per','female_per','sat_score']]
correlations_gender = gender.corr()['sat_score']
correlations_gender.plot.barh()


# In[61]:


combined.plot(x='female_per',y='sat_score',kind="scatter")


# In[63]:


female = combined['female_per']>60
good_sat = combined['sat_score']>1700
conditions = (female) & (good_sat)

schools_female = combined['SCHOOL NAME'][conditions]
schools_female


# In[65]:


combined['ap_per'] = combined['AP Test Takers ']/combined['total_enrollment']
combined.plot(x="ap_per",y="sat_score",kind="scatter")

