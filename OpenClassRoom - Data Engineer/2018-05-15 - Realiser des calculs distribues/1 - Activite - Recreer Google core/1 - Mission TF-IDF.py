import os
import numpy
from nltk.corpus import stopwords
from nltk.tokenize import RegexpTokenizer
import string
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.stem.snowball import SnowballStemmer
import pickle

#Data set loading
def load_obj_1(name):
    with open('callwild', 'rb') as f:
        return pickle.load(f)

def load_obj_2(name):
    with open('defoe-robinson-103.txt', 'rb') as f:
        return pickle.load(f)

# load doc into memory
def load_doc(filepath):
    with open(filepath,'rb') as f:
        data = f.read().decode("utf-8")
    return data

#Punctuation cleaning,
def punctation_cleaning(article):
    toreturn = article.translate(str.maketrans(dict([(x, None) for x in string.punctuation])))
    return toreturn
punctation_cleaning('ab,cd()!')

#Number  cleaning,
def number_cleaning(article):
    toreturn = article.translate(str.maketrans(dict([(str(x), None) for x in range(10)])))
    return toreturn
number_cleaning('ab1 2cd34e5')

#word stemming
stemmer = SnowballStemmer("english")
def wordstemmer(word):
    return stemmer.stem(word)

wordstemmer('bones')

#Stopwords suppression
def clean_stopwords(article):
    data = article.split(' ')
    toreturn = [word for word in data if word not in stopwords.words('english')]
    return ' '.join(toreturn)

#Token separation, no capital letters
def tokenizer_article(article):
    tokenizer = RegexpTokenizer(r'\w+')
    toreturn = tokenizer.tokenize(article.lower())
    toreturn = [wordstemmer(w) for w in toreturn]
    return ' '.join(toreturn)

#Dataset creation and treatment
article_dict = {}
listeStories = ['defoe-robinson-103.txt','callwild']

# Compute the TF-IDF calculus
counter =  0
for filename in listeStories:
    counter += 1
    filepath = os.path.join(toexplore, filename)
    story = load_doc(filepath)
    
    story = punctation_cleaning(story)
    story = clean_stopwords(story)
    story = number_cleaning(story)
    story = tokenizer_article(story)
    article_dict[filename] = story    
    
print('Completed')

#TF-IDF score calculation
tokenize = RegexpTokenizer(r'\w+')
tfidfarticle = TfidfVectorizer()
tfidf_article_results = tfidfarticle.fit_transform(article_dict.values())

#tfidf results
tfidf_article_results.toarray()#.shape

#feature names for articles
tfidfarticle.get_feature_names()[:10]

# Saving TF-IDF results
dataset = {'article_dict':article_dict, 
           'tfidfarticle':tfidfarticle, 
           'tfidf_article_results':tfidf_article_results}

with open('dataset.pkl', 'wb') as f:
    pickle.dump(dataset, f, pickle.HIGHEST_PROTOCOL)

# Loading TF-IDF results
dataset = load_obj('dataset')

article_dict = dataset['article_dict']
tfidfarticle = dataset['tfidfarticle']
tfidf_article_results = dataset['tfidf_article_results']







