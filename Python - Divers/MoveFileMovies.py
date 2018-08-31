import io
import os
import string
import shutil

from os import listdir
from os.path import isfile, join,isdir

referentielMovies={}

# Fichiers des listes de films
Path = 'C:\\Users\\monne\\Desktop'
nameFile = 'Listes_Repertoire'
separator ='\\'

# Répertoire source des films
Source  = 'F:\Movies'

# Répartoire racine de destination
Destination = 'F:\Movies\Z_New'

# Repertoire de stockage en vrac
Entrepot = 'F:\Movies'

# Adresse de l'arborescence miroir
Miroir = 'C:\\Users\\monne\\Desktop\\Vrac'

def generation_Dictionnaire():
    # Générer le dictionnaire mappant chaque film au nouveau répertoire cible
    pathFile = separator.join((Path,nameFile))

    onlyfiles = [f for f in listdir(pathFile) if isfile(join(pathFile, f))]

    for filenames in onlyfiles:
        fileName = separator.join((pathFile,filenames))

        with io.open(fileName, mode="r", encoding="utf-16") as f:
            repertoireCible = filenames.replace('.txt','')

            for number,line in enumerate(f):  
                if number>2:          
                    key = line.strip('\n').rstrip()
                    referentielMovies[key] = repertoireCible

def deplacement_fichier(source,destination):
    # Déplacer chaque fichier de film vers les nouveaux répertoires de destination
    movieFiles = [f for f in listdir(source) if isdir(join(source, f))]

    for movie in movieFiles:
        try:
            directory = referentielMovies[movie]
            if directory:
                try:
                    shutil.move(separator.join((source,movie)),
                                separator.join((destination,directory)))
                except:
                    print('------------------- Erreur de deplacement :')
                    print(directory)
                    pass
        except:
            print('------------------- Erreur de cle de dictionnaire :')
            print(movie)
            pass

def forage_repertoire():
    # Forer les sous répertoires du dossier racine
    listeRepertoire = [f for f in listdir(Source) if isdir(join(Source, f))]
    
    for repertoire in listeRepertoire:
        adresseSource = separator.join((Source,repertoire))    
        deplacement_fichier(adresseSource,Destination)

def mirroring_directory(source,destination):
    # Création de l'arborescence de répertoires modèle
    listeRepertoire = [f for f in listdir(source) if isdir(join(source, f))]
    
    for repertoire in listeRepertoire:
        directory = separator.join((destination,repertoire))

        if not os.path.exists(directory):        
            os.makedirs(directory)

# Création de l'arborescence miroir
#mirroring_directory(Entrepot,Miroir)

# Génération du dictionnaire
generation_Dictionnaire()

# Récursion sur les répertoires
forage_repertoire()







