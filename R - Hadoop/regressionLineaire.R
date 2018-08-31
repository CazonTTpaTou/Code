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



data(cars)
donnees=cars
attach(donnees)

#graphique
plot(dist, speed);

#Regression lineaire avec (lm)
reg_lm=lm(speed ~ dist);

#Données
donnees=cbind(speed,1, dist)
donnees_dfs<-to.dfs(donnees)

#Fonction Reduce
Sum= function(., YY) 
	{
		 keyval(1, list(Reduce("+", YY))); 	
	}

#Fonction XTX
XtX =
  values(
  from.dfs(
    mapreduce(
      input = donnees_dfs,
      map=
        function(.,X){
			Xi = X[,-1];
          keyval(1,list(t(Xi)%*% Xi))
        },
      reduce = Sum ,
      combine = TRUE)))[[1]]

#Fonction XTY
XtY =
values(	
from.dfs(
		mapreduce(			
		input = donnees_dfs,						
		map = function(., X) {		 #Définition de la fonction map
			y = X[,1]			# Récupération de la variable à expliquer
			Xi = X[,-1]			# Récupération des variables explicatives
			keyval(1, list(t(Xi) %*% y))
},			
			reduce = Sum,			
			combine = TRUE
		)
	)
)[[1]]

#Calcul des indicateurs
Indic_MR=solve(XtX, XtY)

#Y estimé
YESTIM=Indic_MR[1]*1+Indic_MR[2]*dist

#droite Map reduce
lines(dist,YESTIM, col="blue")

abline(lm(speed ~ dist), col="red");
