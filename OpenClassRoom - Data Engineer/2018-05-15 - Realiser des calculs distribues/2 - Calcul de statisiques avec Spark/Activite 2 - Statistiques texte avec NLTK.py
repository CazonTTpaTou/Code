# -*- coding: utf-8 -*-

import os
import nltk
import pandas as pd
from operator import itemgetter

# Afficher les fréquence de mots d'un texte    
def analyse(stringDirectory,filename):
    
    textContent = load_document(stringDirectory,filename)
    
    textContentNormalized = Suppression_StopWords(
                                                Suppression_Ponctuation(
                                                decodage_UTF8_minuscule(
                                                                        textContent)))

    AfficherLongueurs(textContentNormalized)

# Charger un document texte
def load_document(stringDirectory,filename):
    filepath = os.path.join(stringDirectory, filename)
    with open(filepath,'rb') as f:
        data = f.read().decode("utf-8")
    return data

# Renvoyer le texte chargé
def returnText():
    return textContent

# Renvoyer le texte normalisé
def returnTextNormalised():
            
    return textContentNormalized

# Retourner les statistiques des fréquences des mots du texte
def returnStatistiques(textContentNormalized):
    stats = nltk.FreqDist(textContentNormalized)
    NombreMots = len(textContentNormalized)
    NombreMotsUniques = len(stats)
    ListeMotsTriee = sorted(stats.items(),key=itemgetter(1),reverse=True)
    statsMots = stats
    
    return statsMots

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
    
    listeStopWord.append('@')
    listeStopWord.append('/')

    listeStopWord.append('â')
    listeStopWord.append('n')
    listeStopWord.append('xc2')
    listeStopWord.append('xc3')
    listeStopWord.append('000')
    
    texteSansStopWords += [word for word in text if not word in listeStopWord]
    
    return texteSansStopWords

# Retourner les fréquences des mots du texte
def Frequence_Mots(textContentNormalized):
    stats = nltk.FreqDist(textContentNormalized)
    NombreMots = len(textContentNormalized)
    NombreMotsUniques = len(stats)
    ListeMotsTriee = sorted(stats.items(),key=itemgetter(1),reverse=True)
    statsMots = stats

# Afficher les statistiques des fréquences des mots du texte    
def AfficherStatistiques(textContentNormalized):
    Frequence_Mots(textContentNormalized)

    stats = nltk.FreqDist(textContentNormalized)
    NombreMots = len(textContentNormalized)
    NombreMotsUniques = len(stats)
    ListeMotsTriee = sorted(stats.items(),key=itemgetter(1),reverse=True)
    statsMots = stats

    print('--------------------------------------')
    print('Le texte comporte {} mot(s) '.format(len(textContentNormalized)))
    print('--------------------------------------')
    print('Le texte comporte {} mot(s) unique(s) '.format(len(nltk.FreqDist(textContentNormalized))))
    print('--------------------------------------')
    
    for occurence in sorted(stats.items(),key=itemgetter(1),reverse=True):
        print('Le mot {} a {} occurrence(s)'.format(occurence[0],occurence[1]))
    print('--------------------------------------')

# Retourner l'histogramme en baton des fréquences des mots du texte
def AfficherHistogramme(textContentNormalized):
    donnees = pd.Series(returnStatistiques(textContentNormalized))
    
    donneesTop = donnees.nlargest(20)
    donneesTrieesTop = donneesTop.sort_values(ascending=True)
    
    donneesTrieesTop.plot.barh(color="#318CE7",title="Distribution des 20 occurrences de mots les plus fréquentes")

# Afficher les statistiques des longueurs associées aux fréquences des mots du texte    
def AfficherLongueurs(textContentNormalized):

    stats = nltk.FreqDist(textContentNormalized)
    NombreMots = len(textContentNormalized)
    NombreMotsUniques = len(stats)
    ListeMotsTriee = sorted(stats.items(),key=itemgetter(1),reverse=True)
    statsMots = stats

    listeMots = []
    
    for occurence in sorted(stats.items(),key=itemgetter(1),reverse=True):
        mot={}
        mot['mot']=occurence[0]
        mot['longueur']=len(occurence[0])
        mot['fréquence']=occurence[1]
        listeMots.append(mot)
    
    WordList = pd.DataFrame(listeMots)
    #print(WordList)

    # Affichage des mots les plus longs
    print('Le mot le plus long : {}'.format(WordList.iloc[WordList.longueur.idxmax()].mot))
    
    # Affichage des mots de 4 lettres les plus fréquents
    print('Le mot de 4 lettres le plus fréquent : {}'.format(WordList.iloc[WordList.loc[WordList.longueur==4,'fréquence'].idxmax()].mot))
    
    # Affichage des mots de 15 lettres les plus fréquents
    print('Le mot de 15 lettres le plus fréquent : {}'.format(WordList.iloc[WordList.loc[WordList.longueur==15,'fréquence'].idxmax()].mot))

filename ='Iliade.txt'
directory='C:\\Users\\monne\\Desktop\\'

# Analyse des fréquences de mots du texte passé en paramètre
analyse(directory,filename)









