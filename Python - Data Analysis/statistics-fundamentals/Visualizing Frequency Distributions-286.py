## 2. Bar Plots ##

wnba['Exp_ordinal'].value_counts().sort_index().iloc[[2,1,0,3,4]].plot.bar()




## 3. Horizontal Bar Plots ##

title_graph = 'Number of players in WNBA by level of experience'
wnba['Exp_ordinal'].value_counts().sort_index().iloc[[2,1,0,3,4]].plot.barh(title=title_graph)







## 4. Pie Charts ##

wnba['Exp_ordinal'].value_counts().plot.pie()

## 5. Customizing a Pie Chart ##

title_chart="Percentage of players in WNBA by level of experience"
wnba['Exp_ordinal'].value_counts().plot.pie(figsize=(6,6),autopct='%.2f%%',title=title_chart)

plt.ylabel('')



## 6. Histograms ##

wnba['PTS'].plot.hist()

## 7. The Statistics Behind Histograms ##

from numpy import arange

wnba['Games Played'].describe()
"""
wnba['Games Played'].plot.hist(grid = True, 
                               xticks = arange(0,40,5), 
                               rot = 30)
"""
wnba['Games Played'].plot.hist()


## 9. Binning for Histograms ##

from numpy import arange

title_graph="The distribution of players by games played"

wnba['Games Played'].plot.hist(bins=8,
                               range=(0,32),
                               xticks=arange(0,36,4),
                               title=title_graph)

plt.xlabel('Games played')



## 10. Skewed Distributions ##

#wnba['AST'].plot.hist()
wnba['FT%'].plot.hist()

assists_distro = 'right skewed'

ft_percent_distro = 'left skewed'



## 11. Symmetrical Distributions ##

wnba['Age'].plot.hist()
#wnba['Height'].plot.hist()
#wnba['MIN'].plot.hist()

normal_distribution = 'Height'