== Première étape : Calcul du wordPerDoc ==

Le mapper va filter les mots trop courts et les stopword et emetre ((word,doc), 1) pour chaque mot des documents.
Le reducer va compte le nombre d'occurence de chaque mot pour chaque document ((word,doc), count).

On a donc une tache MapReduce lancée avec la commande :

**************
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
   -input /user/cloudera/input_openclassrooms/callwild.txt /user/cloudera/input_openclassrooms/defoe-robinson-103.txt \
   -output /user/cloudera/output_openclassrooms \
   -mapper /home/cloudera/workspace/openclassrooms/wordPerDoc_mapper.py \
   -reducer /home/cloudera/workspace/openclassrooms/wordPerDoc_reducer.py
*************

On obtiens alors le résultat qu'on peut copier avec 

*************
hdfs dfs -cp -f /user/cloudera/output_openclassrooms/part-00000 /user/cloudera/input_openclassrooms/WordPerDoc
hdfs dfs -rm -r /user/cloudera/output_openclassrooms
*************

== Deuxième étape : Calcul du wordCound ==

Le mapper va récupérer ((word, doc), count) et emettre (doc, (word,count))
Le reducer va faire la somme des count pour chaque mot et emettre ((word, doc), (count, wordcount)) pour chaque document où count est le nombre d'occurence du mot dans le document et wordcount le nombre de mot total dans le document.

On a donc une tache MapReduce lancée avec la commande :

**************
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
   -input /user/cloudera/input_openclassrooms/WordPerDoc \
   -output /user/cloudera/output_openclassrooms \
   -mapper /home/cloudera/workspace/openclassrooms/wordCount_mapper.py \
   -reducer /home/cloudera/workspace/openclassrooms/wordCount_reducer.py
*************

On obtiens alors le résultat qu'on peut copier avec 

*************
hdfs dfs -cp -f /user/cloudera/output_openclassrooms/part-00000 /user/cloudera/input_openclassrooms/WordCout
hdfs dfs -rm -r /user/cloudera/output_openclassrooms
*************

== Troisième étape : on calcule le TD-IDF ==

Le mapper va juste récuperer les ((word, doc), (count, wordcount)) et emettre (word, (doc, count, wordcount))
Le reducer aura alors toutes les infos nécessaires pour calculer le TF-IDF pour chaque mot. Il emet ((word, doc), tf-idf)

**************
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
   -input /user/cloudera/input_openclassrooms/WordCout \
   -output /user/cloudera/output_openclassrooms \
   -mapper /home/cloudera/workspace/openclassrooms/tfidf_mapper.py \
   -reducer /home/cloudera/workspace/openclassrooms/tfidf_reducer.py
*************

On obtiens alors le résultat qu'on peut copier avec 

*************
hdfs dfs -cp -f /user/cloudera/output_openclassrooms/part-00000 /user/cloudera/input_openclassrooms/tfidf
hdfs dfs -rm -r /user/cloudera/output_openclassrooms
*************

== Dernière étape : on veut calculer les 20 plus gros TD-IDF par document ==

Le mapper va récupérer les ((word, doc), td-idf) et emettre (doc, (word,tf-idf)) si le tf-idf est non nul.
Le reducer va garder les 20 plus gros td-idf pour chaque document

**************
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
   -input /user/cloudera/input_openclassrooms/tfidf \
   -output /user/cloudera/output_openclassrooms \
   -mapper /home/cloudera/workspace/openclassrooms/analysis_mapper.py \
   -reducer /home/cloudera/workspace/openclassrooms/analysis_reducer.py
*************

On copie le résultat :

*************
hdfs dfs -cp -f /user/cloudera/output_openclassrooms/part-00000 /user/cloudera/input_openclassrooms/analysis
hdfs dfs -rm -r /user/cloudera/output_openclassrooms
*************

Et on l'affiche :

*************
hdfs dfs -cat /user/cloudera/input_openclassrooms/analysis
*************

On obtient : 

	callwild.txt	0.00457928235568,great
	callwild.txt	0.00403578167205,time
	callwild.txt	0.00361948327608,buck
	callwild.txt	0.00307598259245,shore
	callwild.txt	0.0028100141728,boat
	callwild.txt	0.00257873728615,place
	callwild.txt	0.0023474603995,good
	callwild.txt	0.00225494964484,things
	callwild.txt	0.00220869426751,began
	callwild.txt	0.00202367275819,knew
	callwild.txt	0.00200054506952,back
	callwild.txt	0.00197741738086,water
	callwild.txt	0.00195428969219,thought
	callwild.txt	0.00187334278187,till
	callwild.txt	0.00178083202721,side
	callwild.txt	0.00167675742821,long
	callwild.txt	0.00144548054156,night
	callwild.txt	0.00144548054156,left
	callwild.txt	0.00143391669723,work
	callwild.txt	0.00132984209824,gave
	defoe-robinson-103.txt	0.00582803373771,made
	defoe-robinson-103.txt	0.00446674118584,found
	defoe-robinson-103.txt	0.00343159164118,make
	defoe-robinson-103.txt	0.00316216915696,ship
	defoe-robinson-103.txt	0.00263750431926,island
	defoe-robinson-103.txt	0.00253824340402,friday
	defoe-robinson-103.txt	0.00204193882781,part
	defoe-robinson-103.txt	0.00195685804332,brought
	defoe-robinson-103.txt	0.00187177725883,head
	defoe-robinson-103.txt	0.00180087660508,told
	defoe-robinson-103.txt	0.00177251634359,days
	defoe-robinson-103.txt	0.00150309385936,fire
	defoe-robinson-103.txt	0.00148891372861,mind
	defoe-robinson-103.txt	0.00147473359786,ground
	defoe-robinson-103.txt	0.00146055346712,resolved
	defoe-robinson-103.txt	0.00144637333637,captain
	defoe-robinson-103.txt	0.00143219320562,hand
	defoe-robinson-103.txt	0.00141801307487,hands
	defoe-robinson-103.txt	0.00120531111364,country
	defoe-robinson-103.txt	0.00119113098289,carried

