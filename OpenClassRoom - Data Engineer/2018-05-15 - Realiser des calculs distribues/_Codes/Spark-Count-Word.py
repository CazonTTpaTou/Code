from pyspark import SparkContext

# Instantiation d'un SparkContext
sc = SparkContext()

# Lecture d'un fichier texte : le fichier est décomposé en lignes.
lines = sc.textFile("text.txt")

# Décomposition de chaque ligne en mots
word_counts = lines.flatMap(lambda line: line.split(' ')) \
                   # Chacun des mots est transformé en une clé-valeur
                   .map(lambda word: (word, 1)) \
                   # Les valeurs associées à chaques clé sont sommées
                   .reduceByKey(lambda count1, count2: count1 + count2) \
                   # Le résultat est récupéré
                   .collect()

# Chaque paire (clé, valeur) est affichée
for (word, count) in word_counts:
    print word.encode("utf8"), count




    