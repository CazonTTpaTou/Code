## 3. Finding Correlations With the r Value ##

correlations = combined.corr()
#correlations = correlations[abs(correlations["sat_score"])>0.25]

correlations = correlations["sat_score"]

print(correlations)



## 5. Plotting Enrollment With the Plot() Accessor ##

import matplotlib.pyplot as plt

combined.plot(x="total_enrollment",y="sat_score",kind="scatter")

plt.show()



## 6. Exploring Schools With Low SAT Scores and Enrollment ##

under1 = combined["total_enrollment"]<1000 
under2 =  combined["sat_score"]<1000

under = under1 & under2

low_enrollment = combined[under]

print(set(low_enrollment['School Name']))



## 7. Plotting Language Learning Percentage ##

combined.plot(x="ell_percent",y="sat_score",kind="scatter")

plt.show()



## 9. Mapping the Schools With Basemap ##

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

longitude = list(combined["lon"])
latitude  = list(combined["lat"])

m.scatter(longitude,
          latitude,
          s=20,
          zorder=2,
          latlon=True)

plt.show()



## 10. Plotting Out Statistics ##

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

m.scatter(longitudes,
          latitudes,
          s=20,
          zorder=2,
          latlon=True,
          c=combined["ell_percent"],
          cmap="summer")

plt.show()



## 11. Calculating District-Level Statistics ##

import numpy

grouped = combined.groupby("school_dist")
districts = grouped.agg(numpy.mean)

districts.reset_index(inplace=True)

districts.head()





## 12. Plotting Percent Of English Learners by District ##

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

m.scatter(districts["lon"].tolist(),
          districts["lat"].tolist(),
          s=50,
          zorder=2,
          latlon=True,
          c=districts["ell_percent"],
          cmap="summer")

plt.show()

