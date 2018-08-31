#Variables Globales
Sys.setenv(HADOOP_HOME="/opt/cloudera/parcels/CDH/lib/hadoop")
Sys.setenv(HADOOP_CMD="/opt/cloudera/parcels/CDH/lib/hadoop/bin/hadoop")
Sys.setenv(HADOOP_STREAMING="/opt/cloudera/parcels//CDH-4.7.1-1.cdh4.7.1.p0.47/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.0.0-mr1-cdh4.7.1.jar")
Sys.setenv(HADOOP_CONF_DIR="/opt/cloudera/parcels/CDH/lib/hadoop/etc/hadoop")
Sys.setenv(JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre")

#Appel des librairies
library(rmr2)
library(rhdfs)


#Initialisation de HDFS
hdfs.init()



# fonction principale
kmeans.mr = function(P,num.clusters,num.iter){
# fonction à définir de calcul des distances
# ici euclidienne classique

dist.fun = function(C, P){
apply(C,1,function(x)colSums((t(P) - x)^2))}

#Fonction Reduce

km.reduce = function(., G) t(as.matrix(apply(G, 2,
mean)))

# fonction de l étape map
km.map = function(., P){
nearest = {
if(is.null(C)) # initialisation le 1er tour
sample(1:num.clusters,nrow(P),replace = TRUE)
else { # sinon cherche centre le plus proche
D = dist.fun(C, P)
nearest = max.col(-D)}}
keyval(nearest, P)}


C=NULL

##itérations
for(i in 1:num.iter ) {
res = from.dfs(
mapreduce(P,
map = km.map,
reduce = km.reduce))
C=values(res)
### si des centres ont disparu
if(nrow(C) < num.clusters) {
C = rbind(C,matrix(rnorm(
(num.clusters-nrow(C))*nrow(C)),
ncol = nrow(C))%*%C)}}
C}

#simulation de cinq centres avec du bruit gaussien
set.seed(1)
P=do.call(rbind,rep(list(matrix(rnorm(10,sd = 10),ncol=2)),20))+matrix(rnorm(200), ncol =2)
out = kmeans.mr(to.dfs(P), num.clusters = 5, num.iter = 8)
#Sortie map reduce
plot(P)
points(out,col="blue",pch=16)

# Sortie sans map reduce
kmeans.normal = kmeans(P,5, 8)
points(kmeans.normal$centers,col="red")


