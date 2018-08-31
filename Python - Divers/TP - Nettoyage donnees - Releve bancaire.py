# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import scipy.stats as st
import statsmodels.formula.api as sm

import seaborn as sns
from collections import Counter
import matplotlib.pyplot as plt
import datetime as dt

# Définition des constantes
EXPENSES = [30,100] # Bornes des catégories de dépense : petite, moyenne et grosse
LAST_BALANCE = 2968 # Solde du compte APRES la dernière opération en date
WEEKEND = ["Saturday","Sunday"] # Jours non travaillés

Categories = {
        "ADSL": "Charges",
        "EDF": "Charges",
        "FACT": "Charges",
        "FIXE": "Charges",
        "FREE": "Charges",
        "MOBILE": "Charges",
        "SFR": "Charges",
        "LECLERC": "Courses",
        "POSTE": "Courses",
        "AMAZON": "Divers",
        "ASIE": "Divers",
        "FRATELLI": "Divers",
        "MONOPOL": "Divers",
        "PALAIS": "Divers",
        "RELAY": "Divers",
        "REPUBLIQUE": "Divers",
        "RISTOR": "Divers",
        "DIRECTION": "Impôts",
        "DUPRONT": "Loyer",
        "REGIE": "Loyer",
        "ENR": "Salaire",
        "PWT": "Salaire",
        "BELLUT": "Tickets Restaurant",
        "SNCF": "Transport",
        "DANIEL": "Tickets Restaurant",
        }
Types = {
        "CARTE": "Carte",
        "CB": "Carte",
        "CHEQUES": "Chèques",
        "VIR": "Virement",
        "VISA": "Carte",
        "PRLV": "Prélèvement",
        }

################################################################################
# Définition des fonctions
def export_vers_csv():
    Termes = pd.Series(most_common_words(data.libelle))
    Termes.to_csv('Termes_Bancaires',
              #header=True,
              #index=True
              )

def most_common_words(labels):
    words = []
    for mot in labels:
        mot_str = str(mot)
        words += mot_str.split(" ")
    counter = Counter(words)
    
    return counter.most_common(100)
 
# Assignation des operations a une categorie et a un type
def detect_words(values, dictionary):
    result = []
    for lib in values:
        operation_type = "AUTRE"
        for word, val in dictionary.items():
            if word in str(lib):
                operation_type = val
        result.append(operation_type)
    return result

# creation des variables 'tranche_depense' et 'sens'
def expense_slice(value):
    value = -value # Les dépenses sont des nombres négatifs
    if value < 0:
        return "(pas une dépense)"
    elif value < EXPENSES[0]:
        return "petite"
    elif value < EXPENSES[1]:
        return "moyenne"
    else:
        return "grosse"
 
####################### Programme Principal #########################################    
data = pd.read_csv("E:\\Data\\RawData\\telechargement.csv",
                       sep=";",
                       decimal=",",
                       skiprows=4,
                       parse_dates=[0],
                       dayfirst=True,
                       encoding="ISO-8859-1",
                      )

data.columns =  ['date_operation',
                    'identifiant_transaction',
                    'libelle',
                     'debit',
                     'credit',
                     'detail',
                     'solde']

################################################################################
# Controle des colonnes
for c in ['date_operation','libelle','debit','credit']:
    if c not in data.columns:
        if (c in ['debit','credit'] and 'montant' not in data.columns) or (c not in ['debit','credit']):
            msg = "Il vous manque la colonne '{}'. Attention aux majuscules "
            msg += "et minuscules dans le nom des colonnes!"
            raise Exception(msg.format(c))

# Suppression des colonnes innutiles
for c in data.columns:
    if c not in ['date_operation','libelle','debit','credit','montant']:
        del data[c]

# Ajout de la colonne 'montant' si besoin
if 'montant' not in data.columns:
    data["debit"] = data["debit"].fillna(0)
    data["credit"] = data["credit"].fillna(0)
    data["montant"] = data["debit"] + data["credit"]
    del data["credit"], data["debit"]

# creation de la variable 'solde_avt_ope'
data = data.sort_values("date_operation")
amount = data["montant"]
balance = amount.cumsum()
balance = list(balance.values)
last_val = balance[-1]
balance = [0] + balance[:-1]
balance = balance - last_val + LAST_BALANCE
data["solde_avt_ope"] = balance

# Assignation des catégories
data["categ"] = detect_words(data["libelle"], Categories)
data["type"] = detect_words(data["libelle"], Types)

data["tranche_depense"] = data["montant"].map(expense_slice)
data["sens"] = ["credit" if m > 0 else "debit" for m in data["montant"]]

# Creation des autres variables
data["annee"] = data["date_operation"].map(lambda d: d.year)
data["mois"] = data["date_operation"].map(lambda d: d.month)
data["jour"] = data["date_operation"].map(lambda d: d.day)
data["jour_sem"] = data["date_operation"].map(lambda d: d.weekday_name)
data["jour_sem_num"] = data["date_operation"].map(lambda d: d.weekday()+1)
data["weekend"] = data["jour_sem"].isin(WEEKEND)
data["quart_mois"] = [int((jour-1)*4/31)+1 for jour in data["jour"]]

# Enregistrement au format CSV
data.to_csv("operations_enrichies.csv",index=False)

############## GRAPHIQUES #######################################################

# VARIABLE QUALITATIVE
# Diagramme en secteurs
data["categ"].value_counts(normalize=True).plot(kind='pie')
# Cette ligne assure que le pie chart est un cercle plutôt qu'une éllipse
plt.axis('equal') 
plt.show() # Affiche le graphique

# Diagramme en tuyaux d'orgues
data["categ"].value_counts(normalize=True).plot(kind='bar')
plt.show()

################################################################################
# VARIABLE QUANTITATIVE
# Diagramme en bâtons
data["quart_mois"].value_counts(normalize=True).plot(kind='bar',width=0.1)
plt.show()

# Histogramme
data["montant"].hist(normed=True)
plt.show()
# Histogramme plus beau
data[data.montant.abs() < 100]["montant"].hist(normed=True,bins=20)
plt.show()

############## TABLEAUX #########################################################
effectifs = data["quart_mois"].value_counts()
modalites = effectifs.index # l'index de effectifs contient les modalités

tab = pd.DataFrame(modalites, columns = ["quart_mois"]) # création du tableau à partir des modalités
tab["n"] = effectifs.values
tab["f"] = tab["n"] / len(data) # len(data) renvoie la taille de l'échantillon

tab = tab.sort_values("quart_mois") # tri des valeurs de la variable X (croissant)
tab["F"] = tab["f"].cumsum() # cumsum calcule la somme cumulée

############## STATISTIQUES UNIVARIEES #########################################################
moyenne = data['montant'].mean()
mediane = data['montant'].median()
mode = data['montant'].mode()

# Représenter les statistiques par catégoeir
for cat in data["categ"].unique():
    subset = data[data.categ == cat]
    print("-"*20)
    print(cat)
    print("moy:\n",subset['montant'].mean())
    print("med:\n",subset['montant'].median())
    print("mod:\n",subset['montant'].mode())
    print("var:\n",subset['montant'].var(ddof=0))
    print("ect:\n",subset['montant'].std(ddof=0))
    
    print("skw:\n",subset['montant'].skew())
    print("kur:\n",subset['montant'].kurtosis())
    
    subset["montant"].hist()
    plt.show()
    
    subset.boxplot(column="montant", vert=False)
    plt.show()

################################################################################    
# Courbes de Lorenz
depenses = data[data['montant'] < 0]
dep = -depenses['montant'].values

lorenz = np.cumsum(np.sort(dep)) / dep.sum()
lorenz = np.append([0],lorenz) # La courbe de Lorenz commence à 0

plt.plot(np.linspace(0,1,len(lorenz)),lorenz,drawstyle='steps-post')
plt.show()

aire_ss_courbe = lorenz[:-1].sum()/len(lorenz) # aire sous la courbe de Lorenz. La dernière valeur ne participe pas à l'aire, d'où "[:-1]"
S = 0.5 - aire_ss_courbe # aire entre la 1e bissectrice et la courbe de Lorenz
gini = 2*S
print('Coefficient de Gini ; {}'.format(gini))

################################################################################
# Coefficient de corrélation
depenses = data[data.montant < 0]
plt.plot(depenses["solde_avt_ope"],-depenses["montant"],'o',alpha=0.5)
plt.xlabel("solde avant opération")
plt.ylabel("montant de dépense")
plt.show()

coeff = st.pearsonr(depenses["solde_avt_ope"],-depenses["montant"])[0]
cov = np.cov(depenses["solde_avt_ope"],-depenses["montant"],ddof=0)[1,0]
print('Covariance ; {}'.format(cov))
print('Coefficient de corrélation ; {}'.format(coeff))

################################################################################
# Boxplots associés
taille_classe = 500 # taille des classes pour la discrétisation
groupes = [] # va recevoir les données agrégées à afficher

# on calcule des tranches allant de 0 au solde maximum par paliers de taille taille_classe
tranches = np.arange(0, max(depenses["solde_avt_ope"]), taille_classe)
tranches += taille_classe/2 # on décale les tranches d'une demi taille de classe
indices = np.digitize(depenses["solde_avt_ope"], tranches) # associe chaque solde à son numéro de classe

for ind, tr in enumerate(tranches): # pour chaque tranche, ind reçoit le numéro de tranche et tr la tranche en question
    montants = -depenses.loc[indices==ind,"montant"] # sélection des individus de la tranche ind
    if len(montants) > 0:
        g = {
            'valeurs': montants,
            'centre_classe': tr-(taille_classe/2),
            'taille': len(montants),
            'quartiles': [np.percentile(montants,p) for p in [25,50,75]]
        }
        groupes.append(g)

# affichage des boxplots
plt.boxplot([g["valeurs"] for g in groupes],
            positions= [g["centre_classe"] for g in groupes], # abscisses des boxplots
            showfliers= False, # on ne prend pas en compte les outliers
            widths= taille_classe*0.7, # largeur graphique des boxplots
            manage_xticks= False)

# affichage des effectifs de chaque classe
for g in groupes:
    plt.text(g["centre_classe"],0,"(n={})".format(g["taille"]),horizontalalignment='center',verticalalignment='top')     
plt.show()

# affichage des quartiles
for n_quartile in range(3):
    plt.plot([g["centre_classe"] for g in groupes],
             [g["quartiles"][n_quartile] for g in groupes])
plt.show()

################################################################################
# Selection du sous-échantillon
courses = data[data.categ == "Courses"]
# On trie les opérations par date
courses = courses.sort_values("date_operation")

# On ramène les montants en positif
courses["montant"] = -courses["montant"]

# calcul de la variable attente
r = []
last_date = dt.datetime.now()
for i,row in courses.iterrows():
    days = (row["date_operation"]-last_date).days
    if days == 0:
        r.append(r[-1])
    else:
        r.append(days)
    last_date = row["date_operation"]

courses["attente"] = r
courses = courses.iloc[1:,]

# on regroupe les opérations qui ont été effectués à la même date
# (courses réalisées le même jour mais dans 2 magasins différents)
a = courses.groupby("date_operation")["montant"].sum()
b = courses.groupby("date_operation")["attente"].first()
courses = pd.DataFrame([a for a in zip(a,b)])
courses.columns = ["montant","attente"]

print(courses)

################################################################################
Y = courses['montant']
X = courses[['attente']]
X = X.copy() # On modifiera X, on en crée donc une copie
X['intercept'] = 1.
result = sm.OLS(Y, X).fit() # OLS = Ordinary Least Square (Moindres Carrés Ordinaire)
a,b = result.params['attente'],result.params['intercept']

print('Coefficient de corrélation ; {}'.format(a))
print('Intersection ; {}'.format(b))

################################################################################
# ANALYSE BIVARIEE
X = "categ" # qualitative
Y = "montant" # quantitative

# On ne garde que les dépenses
sous_echantillon = data[data["montant"] < 0].copy()
# On remet les dépenses en positif
sous_echantillon["montant"] = -sous_echantillon["montant"]
# On n'étudie pas les loyers car trop gros:
sous_echantillon = sous_echantillon[sous_echantillon["categ"] != "Loyer"] 

modalites = sous_echantillon[X].unique()
groupes = []
for m in modalites:
    groupes.append(sous_echantillon[sous_echantillon[X]==m][Y])
# Propriétés graphiques (pas très importantes)    
medianprops = {'color':"black"}
meanprops = {'marker':'o', 'markeredgecolor':'black',
            'markerfacecolor':'firebrick'}

plt.boxplot(groupes, labels=modalites, showfliers=False, medianprops=medianprops, 
            vert=False, patch_artist=True, showmeans=True, meanprops=meanprops)
plt.show()

################################################################################
# ANOVA ########################################################################

X = "categ" # qualitative
Y = "montant" # quantitative

sous_echantillon = data[data["montant"] < 0] # On ne garde que les dépenses

def eta_squared(x,y):
    moyenne_y = y.mean()
    classes = []
    
    for classe in x.unique():
        yi_classe = y[x==classe]
        classes.append({'ni': len(yi_classe),
                        'moyenne_classe': yi_classe.mean()})
    SCT = sum([(yj-moyenne_y)**2 for yj in y])
    SCE = sum([c['ni']*(c['moyenne_classe']-moyenne_y)**2 for c in classes])

    return SCE/SCT
    
print('Rapport de corrélation ; {}'.format(eta_squared(sous_echantillon[X],sous_echantillon[Y])))

################################################################################
# TCD ########################################################################

X = "quart_mois"
Y = "categ"

c = data[[X,Y]].pivot_table(index=X,columns=Y,aggfunc=len)
cont = c.copy()

tx = data[X].value_counts()
ty = data[Y].value_counts()

cont.loc[:,"Total"] = tx
cont.loc["total",:] = ty
cont.loc["total","Total"] = len(data)

print(cont)

################################################################################
# KHI-DEUX ########################################################################

tx = pd.DataFrame(tx)
ty = pd.DataFrame(ty)
tx.columns = ["foo"]
ty.columns = ["foo"]
n = len(data)
indep = tx.dot(ty.T) / n

c = c.fillna(0) # on remplace les valeurs nulles par des 0
mesure = (c-indep)**2/indep
xi_n = mesure.sum().sum()
sns.heatmap(mesure/xi_n,annot=c)

plt.show()


