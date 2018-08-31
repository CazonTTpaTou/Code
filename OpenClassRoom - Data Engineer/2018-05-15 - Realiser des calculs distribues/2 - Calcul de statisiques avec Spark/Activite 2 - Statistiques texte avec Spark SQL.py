# -*- coding: utf-8 -*-

import os
import sys
from pyspark import SparkContext

# Charger un document texte
def load_document(stringDirectory,filename):
    filepath = os.path.join(stringDirectory, filename)
    #with open(filepath,'rb') as f:
    #    data = f.read().decode("utf-8")
    return data

# Passage du texte en minuscule et en encodage utf-8    
def decodage_UTF8_minuscule(text):
    by = bytes(text,'utf-8')
    textDecode = by.decode('utf-8').lower()
    
    return textDecode

# Suppression des caractères ,.;:?!"-'
def Suppression_Ponctuation(text):
    tokenizer = nltk.RegexpTokenizer(r'\w+')
    tokenisation = tokenizer.tokenize(text)
    
    return tokenisation        

# Suppression des stopwords (mots usuels courants comme "que", "et", "ils") ainsi que les mots contenant @ et /   
def Suppression_StopWords(text):
    texteSansStopWords = []
    nltk.download('stopwords')
    
    listeStopWord = nltk.corpus.stopwords.words('english')
    
    # On écarte également les mots contenant les caractères @ et /
    listeStopWord.append('@')
    listeStopWord.append('/')
    
    texteSansStopWords += [word for word in text if not word in listeStopWord]
    
    return texteSansStopWords

# Application de toutes les règles d'extraction : passage en minuscule + extraction des caractères interdits + suppression de la ponctuation
def application_regles_extraction(texte):
    return Suppression_StopWords(
                                Suppression_Ponctuation(
                                                        decodage_UTF8_minuscule(
                                                                                texte)))

# Paramétrage de l'emplacement du texte de l'iliade à récupérer
filename ='Iliade.txt'
directory='C:\\Users\\monne\\Desktop\\'

# Chemin du fichier du texte de l'Iliade 
texte = load_document(stringDirectory,filename)

# Chargement du contexte Spark
sc = SparkContext()
lines = sc.textFile(texte)

# Construction du DataFrame RDD
word_length_frequence = lines.flatMap(
                            # Règle 1 : Séparation des mots par un espace
                            lambda line: line.split(' ')) \
                    .filter(
                            # Règle n°2 : Nettoyage des mots : minuscule + suppresion ponctuation + extraction caractères @ et /
                            lambda : word : application_regles_extraction(word)) \
                    .map(
                            # Règle map : Création de tuples contenant : un mot / sa longueur 
                            lambda word: (word,1) \
                   .reduceByKey(
                            # Règle reduce : L'agrégation se fait sur la clé du tuple (mot, fréquence)
                            lambda count1, count2: count1 + count2)
                    # Action : On applique toutes les règles de transformation
                   .collect()

# On supprime les doublons potentiels
unique_length_frequence = word_length_frequence.distinct()

# On persiste le résultat pour que les transformations ne soient pas répétées à chaque appel d'action
unique_length_frequence.persist()

################################################################################################################################
# Recherche du mot le plus long
################################################################################################################################

maximum_length = 0

# On recherche la longueur maximale d'un mot
for word in unique_length_frequence:
    if len(word) > maximum_length :
        maximum_length = len(word)
        longuest_word = word

print('Le mot le plus long est : {} avec une longueur de {}'.format(longuest_word,maximum_length))

################################################################################################################################
# Recherche du mot  de 4 lettres le plus fréquent
################################################################################################################################

# On applique un filtre sur la longueur du mot
liste_mots_quatre_lettres = unique_length_frequence.filter(lambda word : len(word) == 4)

# On détermine le mot de 4 lettres le plus fréquent
most_frequent_four = liste_mots_quatre_lettres.takeOrdered(1, lambda i: -i[1])

print('Le mot de 4 lettres le plus fréquent est : {}'.format(most_frequent_four))

################################################################################################################################
# Recherche du mot  de 15 lettres le plus fréquent
################################################################################################################################

# On applique un filtre sur la longueur du mot
liste_mots_quinze_lettres = unique_length_frequence.filter(lambda word : len(word) == 15)

# On détermine le mot de 4 lettres le plus fréquent
most_frequent_fifteen = liste_mots_quinze_lettres.takeOrdered(1, lambda i: -i[1])

print('Le mot de 15 lettres le plus fréquent est : {}'.format(most_frequent_fifteen))

########################## Le mot de 15 lettres le plus fréquent : accomplishments #########################################

################################################################################################################################
################################################################################################################################
################################### Version avec un DataFrame distinct pour chacune des questions
################################################################################################################################
################################################################################################################################

################################################################################################################################
# Recherche du mot le plus long
################################################################################################################################

# Construction du DataFrame RDD
word_length = lines.flatMap(
                            # Règle 1 : Séparation des mots par un espace
                            lambda line: line.split(' ')) \
                    .filter(
                            # Règle n°2 : Nettoyage des mots : minuscule + suppresion ponctuation + extraction caractères @ et /
                            lambda : word : application_regles_extraction(word)) \
                    .map(
                            # Règle map : Création de tuples contenant : un mot / sa longueur / sa fréquence (en l'occurence 1)
                            lambda word: (word, len(word))) 
                   
# On supprime les doublons potentiels
unique_length = word_length.distinct()

# On détermine le mot le plus long qui est la première occurence du tri décroissant sur la clé longueur
longest_word = different_words.takeOrdered(1, lambda i: -i[1])

################################################################################################################################
# Recherche du mot de 4 lettres le plus fréquent
################################################################################################################################

# Construction du DataFrame RDD
word_length_four = lines.flatMap(
                            # Règle 1 : Séparation des mots par un espace
                            lambda line: line.split(' ')) \
                    .filter(
                            # Règle n°2 : Nettoyage des mots : minuscule + suppresion ponctuation + extraction caractères @ et /
                            lambda : word : application_regles_extraction(word)) \
                    .map(
                            # Règle map : Création de tuples contenant : un mot / sa longueur / sa fréquence (en l'occurence 1)
                            lambda word: (if len(word)==4: (word,1)) \
                   .reduceByKey(
                            # Règle reduce : L'agrégation se fait sur la clé du tuple (mot, longueur du mot)
                            lambda count1, count2: count1 + count2)
                    # Action : On applique toutes les règles de transformation
                   .collect()

# On supprime les doublons potentiels
unique_length_four = word_length_four.distinct()

# On détermine le mot de 4 lettres le plus fréquent
most_frequent_four = unique_length_four.takeOrdered(1, lambda i: -i[1])

################################################################################################################################
# Recherche du mot de 15 lettres le plus fréquent
################################################################################################################################

# Construction du DataFrame RDD
word_length_fifteen = lines.flatMap(
                            # Règle 1 : Séparation des mots par un espace
                            lambda line: line.split(' ')) \
                    .filter(
                            # Règle n°2 : Nettoyage des mots : minuscule + suppresion ponctuation + extraction caractères @ et /
                            lambda : word : application_regles_extraction(word)) \
                    .map(
                            # Règle map : Création de tuples contenant : un mot / sa longueur / sa fréquence (en l'occurence 1)
                            lambda word: (if len(word)==15: (word,1)) \
                   .reduceByKey(
                            # Règle reduce : L'agrégation se fait sur la clé du tuple (mot, longueur du mot)
                            lambda count1, count2: count1 + count2)
                    # Action : On applique toutes les règles de transformation
                   .collect()

# On supprime les doublons potentiels
unique_length_fifteen = word_length_fifteen.distinct()

# On détermine le mot de 4 lettres le plus fréquent
most_frequent_fifteen = unique_length_fifteen.takeOrdered(1, lambda i: -i[1])

########################## Le mot de 15 lettres le plus fréquent : accomplishments #########################################

################################################################################################################################





