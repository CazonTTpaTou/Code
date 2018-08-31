# On considère que l'hypothèse gaussienne est acceptable car :
#              n x p0 x (1 - p0) = 195291,75 
#                                > 5

# Question 1 : Test d'équiprobabilité

# H0 : Le taux de naissance des femmes en 2014 est équi-probable avec celui des hommes
# H1 : La taux de naissance des femmes en 2014 n'est pas équiprobable avec celui des hommes

# H0 : p0 = 0.5
# H0 : p0 <> 0.5

p0 <- 0.5

Nombre_Naissance_Femme <- 381883
Nombre_Naissance_Homme <- 399284
Nombre_Naissance <- Nombre_Naissance_Femme + Nombre_Naissance_Homme
Moyenne_Naissance_Femme <- Nombre_Naissance_Femme / Nombre_Naissance
Racine_Nombre_Naissance <- Nombre_Naissance^(1/2)
Numerateur <- abs(Moyenne_Naissance_Femme-p0)
Denominateur <- (p0*(1-p0))^(1/2)
valeur_limite <- Racine_Nombre_Naissance * (Numerateur / Denominateur)
valeur_Phi <- pnorm(valeur_limite)
p_value <- 1 - valeur_Phi
print(p_value)

prop.test(x=Moyenne_Naissance_Femme,n=Nombre_Naissance,p=p0,alternative="two.sided")

# H0 : Le taux de naissance des hommes en 2014 est équi-probable avec celui des femmes
# H1 : La taux de naissance des hommes en 2014 n'est pas équiprobable avec celui des femmes

# H0 : p0 = 0.5
# H0 : p0 <> 0.5

Moyenne_Naissance_Homme <- Nombre_Naissance_Homme / Nombre_Naissance
Numerateur <- abs(Moyenne_Naissance_Homme-p0)
valeur_limite <- Racine_Nombre_Naissance * (Numerateur / Denominateur)
valeur_Phi <- pnorm(valeur_limite)
p_value <- 1 - valeur_Phi
print(p_value)

prop.test(x=Moyenne_Naissance_Homme,n=Nombre_Naissance,p=p0,alternative="two.sided")

####### Question 2

print('Non, on accepte pas l\'hypothèse Ho d\'équiprobabilité au seuil de 5% ')
print('Car la p value est égale à 0 et donc inférieure à 0.05')
print('On rejette donc l\'hypothèse nulle d\'équiprobabilité des naissances !!')

###### Question 3

Moyenne_Naissance_Femme <- Nombre_Naissance_Femme / Nombre_Naissance
Moyenne_Naissance_Homme <- Nombre_Naissance_Homme / Nombre_Naissance

taille_Echantillon <- 100
Hypothèse_Gaussienne <- taille_Echantillon * p0 * (1 - p0)
print(Hypothèse_Gaussienne)

Nombre_Femmes<- taille_Echantillon * Moyenne_Naissance_Femme
Nombre_Hommes<- taille_Echantillon * Moyenne_Naissance_Homme

print(round(Nombre_Femmes,digit=0))
print(round(Nombre_Hommes,digit=0))

taille_Echantillon <- 1000
Hypothèse_Gaussienne <- taille_Echantillon * p0 * (1 - p0)
print(Hypothèse_Gaussienne)

Nombre_Femmes<- taille_Echantillon * Moyenne_Naissance_Femme
Nombre_Hommes<- taille_Echantillon * Moyenne_Naissance_Homme

print(round(Nombre_Femmes,digit=0))
print(round(Nombre_Hommes,digit=0))

taille_Echantillon <- 10000
Hypothèse_Gaussienne <- taille_Echantillon * p0 * (1 - p0)
print(Hypothèse_Gaussienne)

Nombre_Femmes<- taille_Echantillon * Moyenne_Naissance_Femme
Nombre_Hommes<- taille_Echantillon * Moyenne_Naissance_Homme

print(round(Nombre_Femmes,digit=0))
print(round(Nombre_Hommes,digit=0))

#### Question n° 4 #########################################################

taile_Echantillon <- 100

Nombre_Femmes<- round(taille_Echantillon * Moyenne_Naissance_Femme,digit=2)
Proportion_Femme <- Nombre_Femmes / taile_Echantillon
prop.test(x=Proportion_Femme,n=taile_Echantillon,p=p0,alternative="two.sided")

taile_Echantillon <- 1000

Nombre_Femmes<- round(taille_Echantillon * Moyenne_Naissance_Femme,digit=2)
Proportion_Femme <- Nombre_Femmes / taile_Echantillon
prop.test(x=Proportion_Femme,n=taile_Echantillon,p=p0,alternative="two.sided")

taile_Echantillon <- 10000

Nombre_Femmes<- round(taille_Echantillon * Moyenne_Naissance_Femme,digit=2)
Proportion_Femme <- Nombre_Femmes / taile_Echantillon
prop.test(x=Proportion_Femme,n=taile_Echantillon,p=p0,alternative="two.sided")

print('Taille échantillon = 100 - p-value = 0.9 - On accepte H0 l\'hypothèse d\'équiprobabilité des naissances !!')
print('Taille échantillon = 1000 - p-value = 0 - On rejette H0 l\'hypothèse d\'équiprobabilité des naissances !!')
print('Taille échantillon = 10000 - p-value = 0 - On rejette H0 l\'hypothèse d\'équiprobabilité des naissances !!')


