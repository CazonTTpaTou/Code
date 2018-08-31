#
# OpenClassroom Exercice Spark : Réalisez des statistiques sur un texte avec Spark SQL
# Le mot de 15 caracteres trouvé est : many-fountained 

from pyspark import SparkContext
from pyspark.sql import Row
from pyspark.sql.session import SparkSession
import sys

sc = SparkContext()
spark = SparkSession(sc)

# Charger le texte en argument.
File_Name=sys.argv[1]
# supprimer le mot contenant '@' et '/'
def stop_word(word):
    stop_words = ['@', '/']
    return stop_words

# Supprimer les caracters ',-;:?".!\''  du debut et de la fin d'un mot
def strip_word(word):
    return word.strip(',-;:?".!\'')

# Fonctionde chargement du texte et filtrage
# Retourne un DataFrame
def load_text(text_path):

    Mots = sc.textFile(text_path)\
        .flatMap(lambda lines: lines.lower().split())\
        .filter(lambda word: "@" not in word)\
        .filter(lambda word: "/" not in word)\
        .map(lambda word: strip_word(word))\
        .filter(lambda word: word is not None and len(word) > 0)\
        .filter(stop_word)

    # Nombre total des mots dans le texte
    word_count = Mots.count()

    # Calcul de la frequence de chaque mot et sa longueur
    word_freq_len = Mots.map(lambda word: (word, 1))\
        .reduceByKey(lambda count1, count2: count1 + count2)\
        .map(lambda (word, count): (word, count/float(word_count), len(word)))\

    return spark.createDataFrame(word_freq_len)

# Appel de la fonction de chargement du texte 
# et récupération d'un DataFrame Df1
Df1 = load_text(File_Name)

# Creation d'une vue temporaire Table1 a partir du DataFrame Df1.
TmpTable = Df1.createOrReplaceTempView("Table1")

# Requêtes sur la Vue Table1
# Le mot le plus long
Longest_Word = spark.sql("SELECT * FROM Table1 ORDER BY _3 DESC LIMIT 5").first()
if Longest_Word != None:
    print("Longest word: " + Longest_Word[0])
else:
    print("Longest word: " + "None")

# le mot de quatre lettres le plus fréquent
MF_Four_Letters =  spark.sql("SELECT * FROM Table1 WHERE _3 == 4 ORDER BY _2 DESC LIMIT 5").first()
if MF_Four_Letters != None:
    print("Most frequent 4-letter word: " + MF_Four_Letters[0])
else:
        print("Most frequent 4-letter word: " + "None")

#le mot de quinze lettres le plus fréquent
MF_Fifteen_Letters = spark.sql("SELECT * FROM Table1 WHERE _3 == 15 ORDER BY _2 DESC LIMIT 5").first()
if MF_Fifteen_Letters != None:
    print("Most frequent 15-letter word: " + MF_Fifteen_Letters[0])
else:
    print("Most frequent 15-letter word: " + "None")


