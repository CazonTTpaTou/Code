# -*- coding: utf-8 -*-
from PIL import Image
from PIL import ImageFilter
from PIL.ImageFilter import (GaussianBlur,MedianFilter)

import numpy as np
import matplotlib.pyplot as plt
import os
import errno
from os import listdir
from os.path import isfile, join

from PIL.ImageFilter import (
    BLUR, CONTOUR, DETAIL, EDGE_ENHANCE, EDGE_ENHANCE_MORE,
    EMBOSS, FIND_EDGES, SMOOTH, SMOOTH_MORE, SHARPEN
    )

# Définitions des constantes de l'apllication
BAD_SYNTAX_FILTER = 'Le nom du filtre que vous avez saisi est incorrect... Réessayez SVP !!!'
SAVING_DIRECTORY = 'C:\\Users\\monne\\Desktop\\Pictures\\'
SOURCE_DIRECTORY = 'E:\Data\RawData\Cours_Vision_par_ordinateur-Images'

# Liste des fichiers à tester
def Liste_Fichiers_Images_Test(chemin):
    # Renvoie le nom des fichiers image à tester
    liste_fichiers = [f for f in listdir(chemin) if isfile(join(chemin, f))]
    return liste_fichiers

# Définition des fonctions de l'application
def Apply_Filter_Picture(nameFile,directory,parametres_filtre):
    # Applique le filtre passé en paramètre à une image donné également en paramètre     
    File='\\'.join([SOURCE_DIRECTORY,nameFile])
    img = Image.open(File)

    nomFichier = (SAVING_DIRECTORY
                      +directory+ '\\'
                      +parametres_filtre['nom_filtre']
                      +'_'
                      +parametres_filtre['nom_combinaison_parametres']
                      +'_'
                      + nameFile)
    
    # Filtre de type Moyenneur
    if parametres_filtre['nom_filtre']=='moyenneur':
        # Noyau de convolution du filtre moyenneur
        noyau = parametres_filtre['noyau']
        # Taille du masque de convolution
        taille = parametres_filtre['taille']
        # Paramètre par défaut pour les pixels de bords d'image
        bordure = parametres_filtre['bordure']
        # facteur de ponderation du noyau de convolution
        ponderation = parametres_filtre['ponderation']
        
        filtre = ImageFilter.Kernel(            
                                    size=(taille, taille), 
                                    kernel=noyau,
                                    scale=ponderation,  
                                    offset=bordure)    
         
    # Filtre de type Gaussien
    elif parametres_filtre['nom_filtre']=='gaussien':
        # Rayon du noyau gaussien
        radius=parametres_filtre['radius']        
        filtre = ImageFilter.GaussianBlur(radius)
     
    # Filtre de type médian    
    elif parametres_filtre['nom_filtre']=='median':
        # Taille du voisinage pour calcul de la médiane
        taille=parametres_filtre['size']  
        filtre = ImageFilter.MedianFilter(size=taille)
    else:
        print(BAD_SYNTAX_FILTER)

    img.filter(filtre).save(nomFichier)

param_filtre_moy1 = {
                    'nom_filtre':'moyenneur',
                    'nom_combinaison_parametres':'noyau_dim_3_const',
                    'noyau':(np.ones(9)),
                    'taille':3,
                    'ponderation':3*3,
                    'bordure':0
                    }

param_filtre_moy2 = {
                    'nom_filtre':'moyenneur',
                    'nom_combinaison_parametres':'noyau_dim_5_const',
                    'noyau':(np.ones(25)),
                    'taille':5,
                    'ponderation':5*5,
                    'bordure':0
                    }

param_filtre_moy3 = {
                    'nom_filtre':'moyenneur',
                    'nom_combinaison_parametres':'noyau_dim_3_prog',
                    'noyau':(np.linspace(-4,4,9)),
                    'taille':3,
                    'ponderation':1,#np.size(np.linspace(-4,4,9)),
                    'bordure':0
                    }

param_filtre_moy4 = {
                    'nom_filtre':'moyenneur',
                    'nom_combinaison_parametres':'noyau_dim_5_prog',
                    'noyau':(np.linspace(-12,12,25)),
                    'taille':5,
                    'ponderation':1,#np.size(np.linspace(-12,12,25)),
                    'bordure':0
                    }

param_filtre_moy5 = {
                    'nom_filtre':'moyenneur',
                    'nom_combinaison_parametres':'noyau_dim_3_tuple',
                    'noyau':(-2,-1,0,-1,1,1,0,1,2),
                    'taille':3,
                    'ponderation':sum((-2,-1,0,-1,1,1,0,1,2)),#np.size(np.linspace(-12,12,25)),
                    'bordure':0
                    }

param_filtre_moy6 = {
                    'nom_filtre':'moyenneur',
                    'nom_combinaison_parametres':'noyau_dim_3_random',
                    'noyau':(np.random.randint(-5,5,9)),
                    'taille':3,
                    'ponderation':1,
                    'bordure':0
                    }

param_filtre_moy7 = {
                    'nom_filtre':'gaussien',
                    'nom_combinaison_parametres':'radius_blur_1',
                    'radius':1
                    }

param_filtre_moy8 = {
                    'nom_filtre':'gaussien',
                    'nom_combinaison_parametres':'radius_blur_2',
                    'radius':2
                    }

param_filtre_moy9 = {
                    'nom_filtre':'gaussien',
                    'nom_combinaison_parametres':'radius_blur_3',
                    'radius':3
                    }

param_filtre_moy10 = {
                    'nom_filtre':'gaussien',
                    'nom_combinaison_parametres':'radius_blur_4',
                    'radius':4
                    }

param_filtre_moy11 = {
                    'nom_filtre':'gaussien',
                    'nom_combinaison_parametres':'radius_blur_5',
                    'radius':5
                    }

param_filtre_moy12 = {
                    'nom_filtre':'gaussien',
                    'nom_combinaison_parametres':'radius_blur_6',
                    'radius':6
                    }

param_filtre_moy13 = {
                    'nom_filtre':'median',
                    'nom_combinaison_parametres':'size_9',
                    'size':9
                    }

param_filtre_moy14 = {
                    'nom_filtre':'median',
                    'nom_combinaison_parametres':'size_25',
                    'size':25
                    }

param_filtre_moy15 = {
                    'nom_filtre':'median',
                    'nom_combinaison_parametres':'size_49',
                    'size':49
                    }

param_filtre_moy16 = {
                    'nom_filtre':'median',
                    'nom_combinaison_parametres':'size_81',
                    'size':81
                    }

param_filtre_moy17 = {
                    'nom_filtre':'median',
                    'nom_combinaison_parametres':'size_121',
                    'size':121
                    }

param_filtre_moy18 = {
                    'nom_filtre':'median',
                    'nom_combinaison_parametres':'size_169',
                    'size':169
                    }

liste_parametres = [param_filtre_moy1,
                    param_filtre_moy2,
                    param_filtre_moy3,
                    param_filtre_moy4,
                    param_filtre_moy5,
                    param_filtre_moy6,
                    param_filtre_moy7,
                    param_filtre_moy8,
                    param_filtre_moy9,
                    param_filtre_moy10,
                    param_filtre_moy11,
                    param_filtre_moy12,
                    param_filtre_moy13,
                    param_filtre_moy14,
                    param_filtre_moy15,
                    param_filtre_moy16,
                    param_filtre_moy17,
                    param_filtre_moy18
                    ]

for fichier in Liste_Fichiers_Images_Test(SOURCE_DIRECTORY):
        # Nom du répertoire associé à l'image testé
        nomRepertoire=fichier[0].upper()+fichier[1:fichier.find('.')]
        # Création du répertoire si'il n'existe pas encore
        try:
            os.chdir(SAVING_DIRECTORY)
            os.makedirs(nomRepertoire)
        except OSError as exception:
            if exception.errno != errno.EEXIST:
                raise
        # Création des nouvelles iamges après application des filtres                
        for param in liste_parametres:
            pass
            #Apply_Filter_Picture(fichier,nomRepertoire,param)


# Création de graphiques de comparaison des distributions

Image_Etalon = Image.open(SAVING_DIRECTORY + '\\Lena_Etalon\\lena_original.png')
Image_Bruit_Gaussien = Image.open(SAVING_DIRECTORY + '\\Lena_bruit_gaussien\\gaussien_radius_blur_2_lena_bruit_gaussien.png')
Image_Poivre_Sel = Image.open(SAVING_DIRECTORY + '\\Lena_poivre_et_sel\\median_size_9_lena_poivre_et_sel.png')
Image_Speckle = Image.open(SAVING_DIRECTORY + '\\Lena_speckle\\moyenneur_noyau_dim_5_const_lena_speckle.png')

mat_Image_Etalon=np.array(Image_Etalon)
mat_Image_Bruit_Gaussien=np.array(Image_Bruit_Gaussien)
mat_Image_Poivre_Sel=np.array(Image_Poivre_Sel)
mat_Image_Speckle=np.array(Image_Speckle)

fig = plt.figure(figsize=(6,4))
ax1 = fig.add_subplot(3,2,1)
ax2 = fig.add_subplot(3,2,2)
ax3 = fig.add_subplot(3,2,3)
ax4 = fig.add_subplot(3,2,4)
ax5 = fig.add_subplot(3,2,5)
ax6 = fig.add_subplot(3,2,6)

ax1.hist(mat_Image_Etalon.flatten(), bins=range(256),density=True,color='blue')
ax3.hist(mat_Image_Etalon.flatten(), bins=range(256),density=True,color='blue')
ax5.hist(mat_Image_Etalon.flatten(), bins=range(256),density=True,color='blue')

ax2.hist(mat_Image_Bruit_Gaussien.flatten(), bins=range(256),density=True,color='red')
ax4.hist(mat_Image_Poivre_Sel.flatten(), bins=range(256),density=True,color='green')
ax6.hist(mat_Image_Speckle.flatten(), bins=range(256),density=True,color='purple')

ax1.set_title('Image Etalon')
ax1.set_ylabel('Densité normalisée')
ax1.set_xlabel('Intensité niveaux de gris')

ax3.set_title('Image Etalon')
ax3.set_ylabel('Densité normalisée')
ax3.set_xlabel('Intensité niveaux de gris')

ax5.set_title('Image Etalon')
ax5.set_ylabel('Densité normalisée')
ax5.set_xlabel('Intensité niveaux de gris')

ax2.set_title('Bruit Gausien corrigée')
ax2.set_ylabel('Densité normalisée')
ax2.set_xlabel('Intensité niveaux de gris')

ax4.set_title('Poivre et sel corrigée')
ax4.set_ylabel('Densité normalisée')
ax4.set_xlabel('Intensité niveaux de gris')

ax6.set_title('Speckle corrigée')
ax6.set_ylabel('Densité normalisée')
ax6.set_xlabel('Intensité niveaux de gris')

plt.show()







