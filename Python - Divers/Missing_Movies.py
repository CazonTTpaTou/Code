import io
import os
import string

from os import listdir
from os.path import isfile, join,isdir

liste_old = []
liste_new = []
liste_manquant = []

Path = 'C:\\Users\\monne\\Desktop'
separator ='\\'
Destination = 'Missing Movies.txt'

def generate_dictionnary(folder):
    liste=[]
    pathFile = separator.join((Path,folder))
    onlyfiles = [f for f in listdir(pathFile) if isfile(join(pathFile, f))]

    for filenames in onlyfiles:
        fileName = separator.join((pathFile,filenames))           
        with io.open(fileName, mode="r",encoding="utf-16") as f:
                for index,line in enumerate(f):
                    if index > 2:
                        if line.strip('\n').rstrip() != '':
                            liste.append(line.strip('\n').rstrip())
    return liste

liste_old = generate_dictionnary('Old')

liste_new = generate_dictionnary('New')

for movie in liste_old:
    if not(movie in liste_new):
        liste_manquant.append(movie)

file_destination = separator.join((Path,Destination))

with io.open(file_destination,mode="w",encoding="utf-16") as f:
    for movie in liste_manquant:
        f.write(movie)
        f.write('\n')

print(len(liste_manquant))

"""
print(liste_old)
print(liste_new)
print(liste_manquant)

print(len(liste_old))
print(len(liste_new))
print(len(liste_manquant))
"""   

