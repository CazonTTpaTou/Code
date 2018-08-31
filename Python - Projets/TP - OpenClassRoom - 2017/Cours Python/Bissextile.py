# -*-coding:utf-8 -*

import os
def bissextile():
    annee= input("Annee ??")
    annee_int = int(annee)
    bis = False
    
    if ((annee_int%100==0) and (annee_int%400==0)) or ((annee_int%4==0) and (annee_int%100!=0)):
        bis = True
    
    if (bis):
        print('Année bissextile')
    else:
        print('Année non bissextile')
        
    os.system("pause")

    return bis

