Sys.setenv(HADOOP_HOME="/opt/cloudera/parcels/CDH/lib/hadoop")
Sys.setenv(HADOOP_CMD="/opt/cloudera/parcels/CDH/lib/hadoop/bin/hadoop")
Sys.setenv(HADOOP_STREAMING="/opt/cloudera/parcels//CDH-4.7.1-1.cdh4.7.1.p0.47/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.0.0-mr1-cdh4.7.1.jar")
Sys.setenv(HADOOP_CONF_DIR="/opt/cloudera/parcels/CDH/lib/hadoop/etc/hadoop")
Sys.setenv(JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre")




library(rmr2)

library(rhdfs)

hdfs.init()



cm.map = function(., texte)

 { 

		ligne = gsub('\n', ' ', ligne) 

		#Création d?une liste de mot à partir d?une ligne

		 listeMot = strsplit(ligne ,  " ");

		# Transformation de l?objet liste en un objet vecteur

		vecteurMot=unlist(listeMot);

		# Association de chaque mot dun vecteur à la valeur 1

		keyval(kevecteurMot,1 );

}





cm.reduce = function(mot, valeur){

		keyval (mot, sum(valeur))

}



res=mapreduce(input ='/user/eulidia/books/', input.format="text",map = cm.map, reduce = cm.reduce,combine=T);


print(sum(values(from.dfs(res))))

print(values(from.dfs(res2))[keys(from.dfs(res2)) == "Il"])
