# -*- coding: utf-8 -*-
from PIL import Image
from PIL import ImageFilter

import numpy as np
import matplotlib.pyplot as plt
################################################################################
################################################################################
# Charger l'image
img = Image.open("E:\Data\RawData\Donnees_Visuelles\simba.png") 
# Afficher l'image chargée
#img.show()

# Récupérer et afficher la taille de l'image (en pixels)
w, h = img.size
print("Largeur : {} px, hauteur : {} px".format(w, h))
# Afficher son mode de quantification
print("Format des pixels : {}".format(img.mode))
# Récupérer et afficher la valeur du pixel à une position précise
px_value = img.getpixel((20,100))
print("Valeur du pixel situé en (20,100) : {}".format(px_value))
# Récupérer les valeurs de tous les pixels sous forme d'une matrice
mat = np.array(img)
mat
# Afficher la taille de la matrice de pixels
print("Taille de la matrice de pixels : {}".format(mat.shape))
################################################################################
################################################################################
# Générer et afficher l'histogramme
# Pour le normaliser : argument density=True dans plt.hist
# Pour avoir l'histogramme cumulé : argument cumulative=True

n, bins, patches = plt.hist(mat.flatten(), bins=range(256),color='green')
plt.show()

n, bins, patches = plt.hist(mat.flatten(), bins=range(256),density=True)
plt.plot([256/2,256/2],[0,0.01],color='red',linestyle='--')
plt.show()

n, bins, patches = plt.hist(mat.flatten(), bins=range(256),cumulative=True,density=True)
plt.plot([256/2,256/2],[0,1],color='red',linestyle='--')
plt.plot([0,256],[0,1],color='black',linestyle='--')
plt.show()

# Générer le bruit gaussien de moyenne nulle et d'écart-type 7 (variance 49)
noise = np.random.normal(0, 7, mat.shape)
# Créer l'image bruitée et l'afficher
noisy_img = Image.fromarray(mat + noise).convert('L')
#noisy_img.show()

# Appliquer le lissage par moyennage (fenêtre de taille 9) et afficher le résultat
noisy_img.filter(ImageFilter.BoxBlur(1)).show()



"""

"""

