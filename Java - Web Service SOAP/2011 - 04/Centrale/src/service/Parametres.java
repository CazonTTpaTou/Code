package service;

//La classe Parametres est une classe de stockage des param�tres utilisateur de la connection
//� la BDD MySQL. Cette classe fait office de Bean Java m�me si ce n'en est pas r�ellement
//un.
//En effet, dans le cadre de ce TP, les param�tres sont rentr�s en dur dans le constructeur de
//la classe.
//Mais en production, il est certain, que ces param�tres seraient rentr�s par l'utilisateur pour
//v�rifier
//qu'il poss�de bien les droits lui autorisant la connection � cette base de donn�es. Ces
//param�tres
//seraient donc dynamiques et seraient enregistr�s � chaque cr�ation de session utilisateur,
//par le
//biais d'une JSP proposant un formulaire de connection � l'utilisateur avec des champs �
//remplir...
public class Parametres {
//On d�clare les 4 variables param�tres n�cessaires � la cr�ation d'une connection �
//une BDD
//Afin de respecter le principe d'encapsulation, les attributs sont d�clar�s private et ne
//sont
//accessibles que par les accesseurs qui eux sont d�clar�s public.
//On n'utilise pas de mutateur (m�thodes setXXX) dans cette classe, car nous utilisons
//des
//param�tres par d�faut. Toutefois, si le contexte du TP s'y pr�tait, il faudrait en
//ajouter
//afin de permettre une gestion plus fine des utilisateurs...
private String nomUtilisateur;
private String motDePasse;
private String serveurBD;
private String driverSGBD;
//Les param�tres sont rentr�s par d�faut au sein du constructeur de la
//classe
public Parametres (){
//Nom d'utilisateur qui doit correspondre � un � un compte utilisateur
//valide cr�� dans MySQL
nomUtilisateur = "root";
//Mot de passe correspondant - ici nous n'en avons pas mis ce qu'il ne
//faut surtout pas faire
//dans un contexte de production...
motDePasse = "";
//Type du driver utilis� pour communiquer avec la base de donn�e (ici
//un driver JDBC fourni par MySQL)
driverSGBD ="com.mysql.jdbc.Driver";
//Adresse de type URL de la Base de donn�e � laquelle on d�sire se
//connecter
//Ici, on passe par un middleware de type JDBC qui permet une
//connection � une BDD MySQL jdbc:mysql
//Le serveur est en local, donc le nom de domaine correspond �
//localhost (soit 127.0.0.1)
//le port par d�faut utilis� par le d�mon mysqld du serveur de BDD
//Apache est le port 3306
//Le nom de la BDD � laquelle nous voulons nous connecter est la
//suivante: mm_d314_tp1
serveurBD = "jdbc:mysql://localhost:3306/expo";
}
//M�thode accesseur qui renvoie le type de Driver de la base de donn�e �
//utiliser pour se connecter
public String getDriverSGBD() {
return driverSGBD;
}
//M�thode accesseur renvoyant le mot de passe de l'utilisateur
public String getMotDePasse() {
return motDePasse;
}
//M�thode accesseur renvoyant le nom du compte utilisateur que l'on va
//utiliser pour se connecter
public String getNomUtilisateur() {
return nomUtilisateur;
}
//M�thode acceseur renvoyant l'adresse de la BDD � laquelle on veut se
//connecter sous forme d'URL
public String getServeurBD() {
return serveurBD;
}
}
