#!/bin/bash

#fonction pour l'affichage graphique, affiche une courbe en pourcentage du nombre de mot pour chaque lettre
graphique(){

  total=`wc -l $1 | cut -d " " -f 1` #pour compter le nombre de mots
  
  tableau_lettres=('') #tableau recensant le nombre de mots pour chaque lettres
  nb_lettres='0' #récupére le nombre de mots pour chaque lettres
  i='0' #compteur pour renseigner les cases du tableau
  for nb_lettres in `cut -d " " -f 1 ./resultat` #récupére dans nb_lettres le nombre de mots pour cahque lettres contenu dans le fichier temporaire de résultat
  do
    tableau_lettres[$i]=$nb_lettres #place cette valeur dans la bonne case du tableau, la position renseignant la lettre, les lettres sont toujours dans l'ordre alphabétique dans le fichier de résultat, le rang de la lettre dans l'alphabet correspond donc à la case du tableau
    let "i = i + 1" #incrémente le compteur
  done

  i='0' #réinitialise le compteur pour la boucle suivante
  while [ $i -le 26 ] #pour toute les lettres de l'alphabet
  do
    let "tableau_lettres[$i] = tableau_lettres[$i] * 100 / total" #converti le nombre de mots en pourcentage
    let "i = i + 1" #incrémente le compteur
  done

  alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ" #liste des lettres de l'alphabet
  i='1' #initialise le compteur pour la prochaine boucle
  lettre='' #utilisé pour récupérer la lettre traité
  dizaine='0' #utilisé pour vérifier les dizaines
  while [ $i -le 26 ] #boucle pour toute les lettres de l'alphabet
  do
    chaine=`echo $alphabet | cut -c $i` #récupére une lettre de l'alphabet
    j='1' #initiliase le compteur pour la prochaine boucle
    while [ $j -lt ${tableau_lettres[$i]} ] #boucle jusqu'à ce que le compteur soit plus grand que le pourcentage de mots associé à la lettre
    do
      chaine+="|" #ajoute une graduation

      let "dizaine = j % 10" #teste les dizaines, si la division de j par ne donne pas de reste, un séparateur est ajouté pour signifier les dizaines
      if [ $dizaine -eq 0 ]
      then
        chaine+="_" #ajoute un séparateur
      fi

      let "j = j + 1" #incrémente j
    done

    echo $chaine #affiche les graduation pour une lettre
    let "i = i + 1" #passe à la lettre suivante
  done

}

#-----------------------------------------------------------------

#vérifie les paramétres, si -t ou --tableau en premier paramétre, l'affichage graphique sera utilisé
graph='0'
if [ ! -z $1 ] && ([ $1 = '-t' ] || [ $1 = '--tableau' ])
then
  graph='1'
  shift #pour placer en premiére position le paramétre pour le fichier cible
fi

#test si un fichier cible est renseigné
if [ -z $1 ]
then
  echo "indiquez le fichier à traiter"
  exit 1
fi

if [ ! -e $1 ]
then
  echo "le fichier n'existe pas"
  exit 1
fi


alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZ' #liste des lettres utilisées pour les tests
fichier=$1 #prend le premier paramétre pour le fichier cible
lettre='' #lettre traité dans la boucle suivante
nb_lettres='0' #variable recensant le nombre total de lettres
i='1' #utilisé pour boucler
while [ $i -le 26 ]
do
  lettre=`echo $alphabet | cut -c $i` #récupére une lettre en fonction de i (allant de 1 à 26)
  grep $lettre $fichier >> ./donnees #récupére tous les mots contenant la lettre renseignée et les stocke dans un fichier temporaire
  nb_lettres=`wc -l ./donnees | cut -d " " -f 1` #récupére le nombre de ligne (équivalent au nombre de mots dans ce cas) du fichier temporaire le cut permet de se débarasser de toutes les données inutiles
  echo "$nb_lettres - $lettre" >> ./resultat #place le résultat convenablement traité dans le fichier temporarire de résultat
  rm donnees #pour effecer le fichier de données et en recréer un neuf à la prochaine boucle, cett solution est choisie plutôt que ">" à la deuxiéme instruction de la boucle pour s'assurer de sa suppression en sortie de boucle
  let "i = i + 1" #incrémente le compteur
done

#teste si l'affichage graphique est renseigné, sinon lance l'affichage normal
if [ $graph -eq 1 ]
then
  graphique $fichier #lance la fonction "graphique", renseigné au début du scriierut
else
  sort -n -r ./resultat #affiche le résultat trié
fi

rm ./resultat #efface le fichier temporaire de résultat
