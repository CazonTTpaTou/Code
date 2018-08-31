package service;

//La classe Parametres est une classe de stockage des paramètres utilisateur de la connection
//à la BDD MySQL. Cette classe fait office de Bean Java même si ce n'en est pas réellement
//un.
//En effet, dans le cadre de ce TP, les paramètres sont rentrés en dur dans le constructeur de
//la classe.
//Mais en production, il est certain, que ces paramètres seraient rentrés par l'utilisateur pour
//vérifier
//qu'il possède bien les droits lui autorisant la connection à cette base de données. Ces
//paramètres
//seraient donc dynamiques et seraient enregistrés à chaque création de session utilisateur,
//par le
//biais d'une JSP proposant un formulaire de connection à l'utilisateur avec des champs à
//remplir...
public class Parametres {
//On déclare les 4 variables paramètres nécessaires à la création d'une connection à
//une BDD
//Afin de respecter le principe d'encapsulation, les attributs sont déclarés private et ne
//sont
//accessibles que par les accesseurs qui eux sont déclarés public.
//On n'utilise pas de mutateur (méthodes setXXX) dans cette classe, car nous utilisons
//des
//paramètres par défaut. Toutefois, si le contexte du TP s'y prêtait, il faudrait en
//ajouter
//afin de permettre une gestion plus fine des utilisateurs...
private String nomUtilisateur;
private String motDePasse;
private String serveurBD;
private String driverSGBD;
//Les paramètres sont rentrés par défaut au sein du constructeur de la
//classe
public Parametres (){
//Nom d'utilisateur qui doit correspondre à un à un compte utilisateur
//valide créé dans MySQL
nomUtilisateur = "root";
//Mot de passe correspondant - ici nous n'en avons pas mis ce qu'il ne
//faut surtout pas faire
//dans un contexte de production...
motDePasse = "";
//Type du driver utilisé pour communiquer avec la base de donnée (ici
//un driver JDBC fourni par MySQL)
driverSGBD ="com.mysql.jdbc.Driver";
//Adresse de type URL de la Base de donnée à laquelle on désire se
//connecter
//Ici, on passe par un middleware de type JDBC qui permet une
//connection à une BDD MySQL jdbc:mysql
//Le serveur est en local, donc le nom de domaine correspond à
//localhost (soit 127.0.0.1)
//le port par défaut utilisé par le démon mysqld du serveur de BDD
//Apache est le port 3306
//Le nom de la BDD à laquelle nous voulons nous connecter est la
//suivante: mm_d314_tp1
serveurBD = "jdbc:mysql://localhost:3306/expo";
}
//Méthode accesseur qui renvoie le type de Driver de la base de donnée à
//utiliser pour se connecter
public String getDriverSGBD() {
return driverSGBD;
}
//Méthode accesseur renvoyant le mot de passe de l'utilisateur
public String getMotDePasse() {
return motDePasse;
}
//Méthode accesseur renvoyant le nom du compte utilisateur que l'on va
//utiliser pour se connecter
public String getNomUtilisateur() {
return nomUtilisateur;
}
//Méthode acceseur renvoyant l'adresse de la BDD à laquelle on veut se
//connecter sous forme d'URL
public String getServeurBD() {
return serveurBD;
}
}
