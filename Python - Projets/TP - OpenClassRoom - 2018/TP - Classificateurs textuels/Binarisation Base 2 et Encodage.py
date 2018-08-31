# -*- coding: utf-8 -*-

#from sklearn import preprocessing

chaine1 = [0,0,0,1,0,0,0,1]
chaine2 = [0,1,0,0,0,0,0,1]
chaine3 = [0,1,0,0,0,0,0,0]
chaine4 = [0,0,0,0,0,0,0,1]
chaine5 = [1,1,1,1,1,1,1,1]
Matrice = [chaine1,chaine2,chaine3,chaine4,chaine5]

def Transformation_Base_2_Vers_Base_10(Octets):
    valeur_base_10 = []
    for octet in Octets:
        valeur_octet = 0
        position_bit = 0
        for bit in octet:
            valeur_octet += (2**position_bit)*(int(bit))
            position_bit += 1
        valeur_base_10.append(valeur_octet)
    return valeur_base_10

print(Transformation_Base_2_Vers_Base_10(Matrice))

"""
# Encodage numérique de labels texte 
le = preprocessing.LabelEncoder()
le.fit(["paris", "paris", "tokyo", "amsterdam"])
list(le.classes_)
#['amsterdam', 'paris', 'tokyo']
le.transform(["tokyo", "tokyo", "paris"]) 
list(le.inverse_transform([2, 2, 1]))
#['tokyo', 'tokyo', 'paris']

# Transformation base 2 base 10
int('001',2)
int('011',2)

# Transformation base 10 base 2
format(129, 'b')
format(2**129, 'b')
format(2**129+1, 'b')
format(2**129+2, 'b')

"""



