# -*- coding: utf-8 -*-
"""
Created on Sun Mar 26 19:21:38 2017

@author: fmonnery
"""

Nombre = float(3.9999999999999)
Nombre = str(Nombre)
print(Nombre)

Entier, Decimal = Nombre.split(".")

print(Entier)
print(Decimal)
print(Decimal[:3])

Clustre = ",".join([Entier,Decimal[:3]])
print(Clustre)


        