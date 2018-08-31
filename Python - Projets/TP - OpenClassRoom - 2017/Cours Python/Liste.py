# -*- coding: utf-8 -*-
"""
Created on Sun Mar 26 18:23:06 2017

@author: fmonnery
"""
liste = []
texte = "Bonjour !!!!"
for elt in texte:
    liste.append("-")
    liste.append(elt)

print (liste)



for elts in enumerate(liste):
    print(elts)
    
Carac = "Created on : Sun Mar 26 18:23:06 2017"
Carac.split(":")
print (Carac)

       
"""
virgule=-1
for num,pic in enumerate(NombreS):    
            
    if (pic == '.'):
        NombreS[num]=','
        virgule=0
        
    if (virgule>=0):
        virgule=virgule+1    
        
    if (virgule >= 3):
        NombreS[num].remove()
    
print(NombreS)
"""        
        

    