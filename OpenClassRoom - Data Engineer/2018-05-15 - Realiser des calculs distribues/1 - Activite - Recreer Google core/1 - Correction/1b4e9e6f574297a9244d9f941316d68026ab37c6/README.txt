---------------------------------------------------------------------------------------------
 Mission 1 : TFIDF 
---------------------------------------------------------------------------------------------

Plus forte pondération TF-IDF dans chaque document : 

- callwild.txt :
	TFIDF = 0.011097 => buck
	TFIDF = 0.003971 => dogs
	TFIDF = 0.002872 => thornton
	TFIDF = 0.002127 => sled
	TFIDF = 0.002127 => spitz
	TFIDF = 0.002058 => man
	TFIDF = 0.001879 => back
	TFIDF = 0.001844 => francois
	TFIDF = 0.001666 => bucks
	TFIDF = 0.001655 => men
	TFIDF = 0.001611 => time
	TFIDF = 0.001566 => day
	TFIDF = 0.001476 => made
	TFIDF = 0.001454 => trail
	TFIDF = 0.001418 => john
	TFIDF = 0.001387 => life
	TFIDF = 0.001312 => perrault
	TFIDF = 0.001275 => dog
	TFIDF = 0.001186 => camp
	TFIDF = 0.001186 => head

- defoe-robinson-103.txt :
	TFIDF = 0.002853 => great
	TFIDF = 0.002837 => made
	TFIDF = 0.002376 => found
	TFIDF = 0.002333 => friday
	TFIDF = 0.002278 => time
	TFIDF = 0.002163 => shore
	TFIDF = 0.001941 => boat
	TFIDF = 0.001858 => make
	TFIDF = 0.001825 => ship
	TFIDF = 0.001645 => place
	TFIDF = 0.001505 => good
	TFIDF = 0.001505 => island
	TFIDF = 0.001497 => began
	TFIDF = 0.001447 => thoughts
	TFIDF = 0.001381 => day
	TFIDF = 0.001365 => sea
	TFIDF = 0.001365 => things
	TFIDF = 0.001357 => thought
	TFIDF = 0.001233 => men
	TFIDF = 0.001184 => water

Le processus w_t,d = (tf_t,d / n_d) × log(N/df_t) est découpé en 3 tâches Map/Reduce :

1 - WordCount : compte la fréquence des mots tf_t 
---------------------------------------------------------------------------------------------

    /* Fonction Map de type wordcount : lit une ligne et pour chaque mot, envoie (mot, 1)
     * 
	 * Entrée : index de la ligne, contenu de la ligne 
	 * Sortie : doc_ID:mot, 1
	 */ 
	public void map(LongWritable key, Text value, Context context)

   /* Fonction Reduce de type wordcount : pour chaque mot, calcule la fréquence dans le fichier (wordcount)
     * 
	 * Entrée : doc_ID:mot, (1, 1, ...)
	 * Sortie : doc_ID:mot, wordcount
	 */ 
    public void reduce(Text key, Iterable<IntWritable> values, Context context)
	
	
2 - WordPerDoc : compte le nombre total de mot par documents n_d 
---------------------------------------------------------------------------------------------

    /* Fonction Map de pré-comptage du nombre total de mot par fichier
     * Envoie les données à Reduce sur la clé doc_ID pour que le compte des mots soit groupé par document
     * 
	 * Entrée : doc_ID:mot, wordcount
	 * Sortie : doc_ID, mot:wordcount
	 */
    public void map(Text key, Text value, Context context)

	/* Fonction Reduce de comptage du nombre total de mot par fichier
	 * Somme tous les wordcount des mots par fichier
     * 
	 * Entrée : doc_ID, mot:wordcount
	 * Sortie : doc_ID:mot, wordcount:wordperdoc
	 */
    public void reduce(Text key, Iterable<Text> values, Context context)
	
3 - WordTFIDF : calcule du TFIDF par mot par document (tf_t,d / n_d) × log(N/df_t) 
---------------------------------------------------------------------------------------------
	
	/* Fonction Map de pré-calcul du TFIDF
	 * Envoie à Reduce la clé "mot" pour pouvoir compter le nombre de documents contenant le mot
     * 
	 * Entrée : doc_ID:mot, wordcount:wordperdoc
	 * Sortie : mot, doc_ID:wordcount:wordperdoc
	 */
    public void map(Text key, Text value, Context context)

	/* Fonction Reduce de calcul du TFIDF
	 * Compte le nombre de documents contenant le mot (df_t) et finalise le calcul du TFIDF
     * 
	 * Entrée : mot, doc_ID:wordcount:wordperdoc
	 * Sortie : doc_ID:mot, TFIDF
	 */
    public void reduce(Text key, Iterable<Text> values, Context context)
	
Remarque : la classe GetTopK permet de trier les résultats et de générer le top 20 des TFIDF par fichiers.
	
La structure HDFS utilisée est la suivante :
	/input	
	/input/callwild.txt	
	/input/defoe-robinson-103.txt	
	/output	
	 /output/step_1	
	 /output/step_1/_SUCCESS	
	 /output/step_1/part-r-00000	
	 /output/step_2	
	 /output/step_2/_SUCCESS	
	 /output/step_2/part-r-00000	
	 /output/step_3	
	 /output/step_3/_SUCCESS	
	 /output/step_3/part-r-00000	
	 /resources	
	 /resources/stopwords_en.txt	

	 
---------------------------------------------------------------------------------------------
 Mission 2 : Page Rank 
---------------------------------------------------------------------------------------------

Nœuds avec le plus fort pagerank :

0218 => 0.007934501736377915	
0001 => 0.0025219901765739195	
2999 => 0.00227287045151345	    
6680 => 0.0020552043013663023	
6230 => 0.0019550214060555936	
7830 => 0.001947251161039281	
4230 => 0.0018573322573090531	
0681 => 0.0017395286009598723	
1980 => 0.0017001563568392595	
7386 => 0.0015360585551962686	
2126 => 0.0015050168250249564	
0164 => 0.0014045397807340406	
6897 => 0.0013725843591527254	
6896 => 0.0013489292324169	    
2786 => 0.0012989999555698168	
7252 => 0.0012812652586138462	
3937 => 0.0012505681921796052	
4002 => 0.0012436103109652345	
2788 => 0.0011681835401610454	
2789 => 0.0011674561076838947	


Le processus est divisé en 4 étapes :


1 - TransMatrix : génère la matrice de transition P au format i:j, p 
---------------------------------------------------------------------------------------------

	/* Fonction Map de transposition de la liste adjacente sous forme de matrice
	 *  au format (page source, page cible) => probabilité de passer de la page source à la page cible
     * 
	 * Entrée : pid, pid1 pid2 ... pidN -1 (pid = index de la page source, pidN : index des pages cibles)
	 * Sortie : i:j, p (i = pid de la page source, j = pid de la page cible, p = probabilité de transition)
	 */
	public void map(Text key, Text value, Context context)

	Pas de Reducer (IdentityReducer)
	
2 - InitVector : inititalise le 1er vecteur x_0
---------------------------------------------------------------------------------------------
	
	/* Fonction Map d'initialisation du vecteur 1
	 *  La 1ère étape du parcours : toutes les pages ont la même probabilité 1/n où n = nombre total de pages
     * 
	 * Entrée : pid, pid1 pid2 ... pidN -1 (pid = index de la page source, pidN : index des pages cibles)
	 * Sortie : pid, 1/n (n = nombre total de pages dans la collection)
	 */
	public void map(Text key, Text value, Context context)
	
	Pas de Reducer (IdentityReducer)
	
3 à 11 - NextStep : multiplie le vecteur x_i par la matrice de transition P (i = 1 à 9)
---------------------------------------------------------------------------------------------
	
	/* Fonction Map pour la multiplication du vecteur V par la matrice de transition M
	 *  Envoie à Reduce les sous-calculs (Mij x Vj) 
     * 
	 * Entrée : i:j, p (i,j coordonnées de la matrice de transition, p = probabilité de transition)
	 * Sortie : j, p (j = indexe de colonne de la matrice, p = probabilité de la page x probabilité de transition)
	 */
	public void map(Text key, Text value, Context context)

	/* Fonction Reduce pour la multiplication du vecteur V par la matrice de transition M
	 *  Somme pour la ligne j tous les sous-calculs (Mij x Vj) 
     * 
	 * Entrée : j, p (j = indexe de colonne de la matrice, p = probabilité de la page x probabilité de transition)
	 * Sortie : j, p (j = index de la page, p = somme des probabilités de transition)
	 */
	public void reduce(Text key, Iterable<DoubleWritable> values, Context context)
	 
12 - SortVector : trie le dernier vecteur x_9 par pagerank
---------------------------------------------------------------------------------------------

	/* Fonction Map de tri du vecteur en entrée par PageRank
	 *  Envoie à Reduce la paire inversée (key, value) => (value, key) où key=pid et value=pagerank
	 *  Reduce applique le tri via le comparateur custom DoubleWritableDescSortComparator 
     *  
	 * Entrée : pid, pagerank
	 * Sortie : pagerank, pid
	 */
	public void map(Text key, Text value, Context context)

	Pas de Reducer (IdentityReducer)
	 
	
La structure HDFS utilisée est la suivante :

/pagerank/input
/pagerank/input/adj_list
/pagerank/output
/pagerank/output/step_1
/pagerank/output/step_1/_SUCCESS
/pagerank/output/step_1/part-r-00000
/pagerank/output/step_2
/pagerank/output/step_2/_SUCCESS
/pagerank/output/step_2/part-r-00000
/pagerank/output/step_3
/pagerank/output/step_3/_SUCCESS
/pagerank/output/step_3/part-r-00000
/pagerank/resources
/pagerank/resources/vector_0
/pagerank/resources/vector_1
/pagerank/resources/vector_2
/pagerank/resources/vector_3
/pagerank/resources/vector_4
/pagerank/resources/vector_5
/pagerank/resources/vector_6
/pagerank/resources/vector_7
/pagerank/resources/vector_8
/pagerank/resources/vector_9
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
