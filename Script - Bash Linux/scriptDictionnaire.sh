#!/bin/bash

# On récupère le nom du fichier
nomFichier=$1

# On récupère l'ordre de tri
ordreTri=$2
ascendant="ASC"
descendant="DESC"

# On vérifie qu'au moins un argument a bien été passé au script
if [ $# -lt 1 ] 
then 
	echo "Veuillez renseigner le nom du fichier de dictionnaire en argument du script SVP"
	exit1
fi

# On vérifie que l'argument renvoie vers un nom de fichier valide
if [ ! -f $nomFichier ]
then
	echo "Le nom transmis en argument ne correspond pas à un fichier valide !!"
	exit2
fi
	
# On exécute la boucle décomptant le nombre de lettres dans le fichier
if [ $ordreTri == $ascendant ]
then
	while read -n 1 c
	do
		echo "$c"
	done < $nomFichier | grep '[[:alpha:]]' | sort | uniq -c | sort -n
else
	while read -n 1 c
	do
		echo "$c"
	done < $nomFichier | grep '[[:alpha:]]' | sort | uniq -c | sort -nr
fi


