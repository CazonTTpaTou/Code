p0 <- 0.5

Nombre_Naissance_Femme <- 381883
Nombre_Naissance_Homme <- 399284

Nombre_Naissance <- Nombre_Naissance_Femme + Nombre_Naissance_Homme
Moyenne_Naissance_Femme <- Nombre_Naissance_Femme / Nombre_Naissance
Moyenne_Naissance_Homme <- Nombre_Naissance_Homme / Nombre_Naissance

taille_Echantillon <- 100

Nombre_Femmes<- round(taille_Echantillon * Moyenne_Naissance_Femme,digit=0)
Nombre_Hommes<- taille_Echantillon * Moyenne_Naissance_Homme
Proportion_Femme <- round(Nombre_Femmes / taille_Echantillon,digit=4)

print('Proportion_Femme : ')
print(Nombre_Femmes)

#prop.test(x=Nombre_Femmes,n=taile_Echantillon,p=p0,alternative="two.sided")

#prop.test(x=Proportion_Femme,n=taile_Echantillon,p=p0,alternative="greater")

prop.test(x=c(Nombre_Femmes),n=c(taile_Echantillon),p=p0,alternative="two.sided")





