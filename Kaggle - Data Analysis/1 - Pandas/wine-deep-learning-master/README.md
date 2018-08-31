# Wine Deep Learning

After watching [Somm](http://www.imdb.com/title/tt2204371/) (a documentary on master sommeliers) I wondered how I could create a predictive model to identify wines through blind tasting like a master sommelier. My overall goal is to create a model that can identify the variety, winery, and location of a wine based on a description that a sommelier could give after tasting a wine. Another fun future project would be to give wine recommendations based on food dishes. If anyone has any ideas or insights please share them.

---

### WineEnthusiast review data

As a first step to creating my sommelier model was gathering some data. I started by scraping ~150k wine reviews from [WineEnthusiast](http://www.winemag.com/?s=&drink_type=wine). 

The data consists of 10 fields:

- *Points*: the number of points WineEnthusiast rated the wine on a scale of 1-100 (though they say they only post reviews for wines that score >=80)
- *Title*: the title of the wine review, which often contains the vintage if you're interested in extracting that feature
- *Variety*: the type of grapes used to make the wine (ie Pinot Noir)
- *Description*: a few sentences from a sommelier describing the wine's taste, smell, look, feel, etc.
- *Country*: the country that the wine is from
- *Province*: the province or state that the wine is from
- *Region 1*: the wine growing area in a province or state (ie Napa)
- *Region 2*: sometimes there are more specific regions specified within a wine growing area (ie Rutherford inside the Napa Valley), but this value can sometimes be blank
- *Winery*: the winery that made the wine
- *Designation*: the vineyard within the winery where the grapes that made the wine are from
- *Price*: the cost for a bottle of the wine 
- *Taster Name*: name of the person who tasted and reviewed the wine
- *Taster Twitter Handle*: Twitter handle for the person who tasted ane reviewed the wine

**UPDATED 11/24/2017**
Title, Taster Name, and Taster Twitter Handle were collected and the issue with duplicate entires was resolved

I did not include the dataset that I scraped in this repository because of size, but feel free to run the scraper on your own or use the dataset that I provided on [Kaggle](https://www.kaggle.com/zynicide/wine-reviews).

# Places you may have seen this

- [Kaggle](https://www.kaggle.com/zynicide/wine-reviews)
- [Couchbase Tutorial](https://developer.couchbase.com/documentation/server/current/sdk/full-text-search-overview.html)

# Connect with me

If you'd like to collaborate on a project, learn more about me, or just say hi, feel free to contact me using any of the social channels listed below.

- [Personal Website](https://zackthoutt.com)
- [Email](mailto:zackarey.thoutt@colorado.edu)
- [LinkedIn](https://www.linkedin.com/in/zack-thoutt-57275655/)
- [Twitter](https://twitter.com/zthoutt)
- [Medium](https://medium.com/@zthoutt)
- [Quora](https://www.quora.com/profile/Zack-Thoutt)
- [HackerNews](https://news.ycombinator.com/submitted?id=zthoutt)
- [Reddit](https://www.reddit.com/user/zthoutt/)
- [Kaggle](https://www.kaggle.com/zynicide)
- [Instagram](https://www.instagram.com/zthoutt/)
- [500px](https://500px.com/zthoutt)
