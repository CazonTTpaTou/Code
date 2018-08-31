from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql import Row
import sys
sc=SparkContext()
SQL=SQLContext(sc)


def supp_char(w):
    """ fonction permettant de supprimer les caracteres de la liste (,.;:?!\"-') rencontés en debut et/ou en fin de mot (w)"""

    if (len(w)>0):
        while (w[0] in list(",.;:?!\"-'")):
            if (len(w)>1):w=w[1:]
            else: w='';break
    if (len(w)>0):
        while (w[len(w)-1] in list(",.;:?!\"-'")):
            if (len(w)>1):w=w[:-1]
            else: w='';break
    return(w)
    

lines=sc.textFile(sys.argv[1])
words=lines.flatMap(lambda line: line.split(' ')).map(supp_char).filter(lambda w:len(w)>0 and not w is None and not '/' in w and not '@' in w)
words=words.map(lambda w:w.lower())

#with RDD*******************************************************************

            
# word_count=words.map(lambda w:(w,1)).reduceByKey(lambda a,b:a+b)
# words.take(10)

# longest_word=word_count.sortBy(lambda i:-len(i[0])).first()[0]
# word4=word_count.filter(lambda w:len(w[0])==4).sortBy(lambda i:-i[1]).first()[0]
# word15=word_count.filter(lambda w:len(w[0])==15).sortBy(lambda i:-i[1]).first()[0]

# print("Longest word is : '%s'"%(longest_word))
# print("Most frequent 4-letter word is :'%s'"%(word4))
# print("Most frequent 15-letter word is : '%s'"%(word15))

##***************************************************************************

#WITH DATAFRAME

df=SQL.createDataFrame(words.map(lambda w: Row(word=w,length=len(w))))
longest_word=df.sort('length',ascending=False).first()[1]

df_count=df.groupBy(df.word).count()
word4=df_count.filter(length('word')==4).sort('count',ascending=False).first()[0]
word15=df_count.filter(length('word')==15).sort('count',ascending=False).first()[0]

print("Longest word is : '%s'"%(longest_word))
print("Most frequent 4-letter word is :'%s'"%(word4))
print("Most frequent 15-letter word is : '%s'"%(word15))



