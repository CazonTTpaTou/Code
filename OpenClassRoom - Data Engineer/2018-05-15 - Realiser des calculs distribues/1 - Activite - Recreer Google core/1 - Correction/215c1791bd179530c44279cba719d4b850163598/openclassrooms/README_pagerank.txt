Pour pagerank, on a une seule étape mapreduce pour une itération de l'algorithme

Le vecteur X est stocké dans "/tmp/pagerank_old_x". Si ce fichier n'existe pas, on l'initialise avec un vecteur uniforme.

Pour calculer la k-ième composante du vecteur X_l+1, on a :

X^(l+1)_k = (1-s)*sommme_j (x^l_j * T_k_j) + s/n

Le mapper va alors emettre (j, x^l_j * T_k_j)
Le reducer va faire la somme et ajouter la composante de téléportation, et emetre (j, X^(l+1)_k)

On peut lancer et copier les résulats avec avec :


**********************
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
   -input /user/cloudera/input_openclassrooms/adj_list \
   -output /user/cloudera/output_openclassrooms \
   -mapper /home/cloudera/workspace/openclassrooms/pagerank_mapper.py \
   -reducer /home/cloudera/workspace/openclassrooms/pagerank_reducer.py

rm /tmp/pagerank_x
hdfs dfs -copyToLocal /user/cloudera/output_openclassrooms/part-00000 /tmp/pagerank_x
hdfs dfs -rm -r /user/cloudera/output_openclassrooms
**********************

Si /tmp/pagerank_x et /tmp/pagerank_old_x sont suffisement proches, on a terminé.
Un script d'analyse permet de calculer la norme de la différence entre x et old_x ainsi que d'afficher les 20
meilleurs sites

**********************
./pagerank_analysis.py
**********************

Avant de relancer une nouvelle itération, il faut copier le nouveau x :

**********************
rm /tmp/pagerank_old_x
cp /tmp/pagerank_x /tmp/pagerank_old_x
**********************


Après la première itération, on a une différence entre les x de  0.00275272268306
Après la deuxième itération, on a une différence entre les x de  0.000847552992984
Après la troisième itération, on a une différence entre les x de 0.000200963262369
Après la quatrième itération, on a une différence entre les x de 5.89687662747e-05

Finalement, les 20 meilleurs sites sont (dans l'ordre) :
Le site 218 a le score 0.0245149091797
	http://www.amazon.com/exec/obidos/redirect-home/internetmoviedat
Le site 1 a le score 0.00769516610328
	http://www.imdb.com
Le site 6680 a le score 0.00631824564686
	http://www.knightridder.com
Le site 7830 a le score 0.00583932809034
	http://affiliates.allposters.com/link/redirect.asp?aid=445601&parentaid=445601
Le site 681 a le score 0.0051277551854
	http://www.google.com
Le site 1980 a le score 0.00494278543047
	http://www.gannett.com
Le site 6230 a le score 0.00431514483658
	http://www.earthweb.com
Le site 3937 a le score 0.00428290277532
	http://www.yahooligans.com
Le site 4230 a le score 0.00407339433029
	http://docs.yahoo.com/info/terms
Le site 7252 a le score 0.00399793016858
	http://www.mac.com
Le site 3636 a le score 0.00381248491686
	http://www.usatoday.com
Le site 2999 a le score 0.00373245729656
	http://www.capeweek.com
Le site 76 a le score 0.00345134518873
	http://www.signs.movies.com
Le site 6529 a le score 0.00320908155768
	http://www.gannettfoundation.org
Le site 7386 a le score 0.00318324476437
	http://www.store.yahoo.com/dayspringcards
Le site 1119 a le score 0.00317914278407
	http://www.zap2it.com
Le site 2779 a le score 0.00314018268809
	http://www.boston.com
Le site 5792 a le score 0.00303756404539
	http://www.cninewsonline.com
Le site 4229 a le score 0.00301773645118
	http://www.yahooligans.com/docs/privacy
Le site 2727 a le score 0.0028383835735
	http://www.dealtime.com

