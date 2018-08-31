package service;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;


public class Search{
// On crée une variable statique de type Connection qui va référencer la connexion à la
// BDD expo
// Cette variable statique ne sera pas instanciée car la connexion à la BDD doit être
// unique
// Pour un utilisateur donné on veut une et une seule connexion et un seul accès à la
// BDD
// Si autant de connexions étaient créées que de fois où l'utilisateur se connecte à la
// BDD
// par le biais des méthodes de recherche, les ressources mémoires s'épuiseraient très
// vite
// et les performances deviendraient très vite médiocres
static Connection laConnexion ;
ArrayList <String[]> list = new ArrayList<String[]>();

public boolean requete(String requete) {
boolean success;
String[] info_pays = new String[2];
try {
// La méthode getConnexion() de la classe statique ControleConnexion
// retourne
// la référence de la connexion initialisée selon les paramètres
// utilisateur stocké dans
// le bean LesParamètres lors du chargement de la classe à la
// compilation
// On référence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
// On intercepte les éventuelles exceptions lancées par le
// référencement de la connexion
} catch (Exception e) {
e.printStackTrace();}

try {

// On crée un objet Statement à partir duquel on va lancer la requête
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On exécute la requête et onrécupère le résultat dans un objet de type
// Resultset
System.out.println(requete);
state.executeUpdate(requete);
// On referme les objets Statement et Resultset utilisés car on en aura
// plus besoin
// Il est préférable de le faire soi même plutôt que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la mémoire
// système
state.close();
success=true;
}
// On intercepte les éventuelles exceptions SQL généré par l'exécution de la
// requête
catch (SQLException e){
// On affiche un message indiquant la nature du problème par le biais
// d'une fenêtre
JOptionPane.showMessageDialog(null, "Problème lors de la recherche.","",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces éventuelle de l'exception lancée
e.printStackTrace();
success=false;}

return success;
}

// La méthode  va opérer la requête de recherche des oeuvres présentes 
// dans la table de la BDD
// et les retournera sous forme de tableau de chaîne de caractères (en effet une
// ArrayList aurait
// été plus commode d'autant qu'on ne connaît pas à l'avance le nombre d'entrées
// retournées, mais
// le type ArrayList ne passe pas dans le formatage XML des messages de type SOAP,
// utilisées par les web services
// on utilisera donc un état intermédiaire de tableau de 
// chaînes de caractères de type String[] qui sera encapsulé dans un ArrayOfString.
public String[][] getListe()
{
try {
// La méthode getConnexion() de la classe statique ControleConnexion
// retourne
// la référence de la connexion initialisée selon les paramètres
// utilisateur stocké dans
// le bean LesParamètres lors du chargement de la classe à la
// compilation
// On référence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les éventuelles exceptions lancées par le référencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On crée le code SQL de la requête de recherche de la liste de tous les
// les champs et de toutes les lignes de la table oeuvre
// contenus dans la table pays de la BDD
	requete = "select * from oeuvre";
// On crée un objet Statement à partir duquel on va lancer la requête
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On exécute la requête et onrécupère le résultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les résultats de la requête par le biais des méthodes de
// l'objet Resultset
// Ici, on a plusieurs lignes de résultat car de nombreux noms de pays
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur présente dans la
// colonne intitulée selon le paramètre passé à la méthode getString
// dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	String[] tampon = new String[4];
	tampon[0] = jeuEnregistrements.getString("num_oeuvre");
	tampon[1] = jeuEnregistrements.getString("titre_oeuvre");
	tampon[2] = jeuEnregistrements.getString("prix_oeuvre");
	tampon[3] = jeuEnregistrements.getString("statut_oeuvre");
	list.add(tampon);
i++;}
// On referme les objets Statement et Resultset utilisés car on en aura
// plus besoin
// Il est préférable de le faire soi même plutôt que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la mémoire
// système
jeuEnregistrements.close();
state.close();
}
// On intercepte les éventuelles exceptions SQL généré par l'exécution de la
// requête
catch (Exception e){
// On affiche un message indiquant la nature du problème par le biais
// d'une fenêtre
JOptionPane.showMessageDialog(null, "Problème lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces éventuelle de l'exception lancée
e.printStackTrace();
}
//On initialise une variable taille qui permettra de créer un tableau de la
// même
// taille que l'ArrayList tampon...
int taille=list.size();

int s=0;
// Génération du tableau qui va contenir toutes les oeuvres
String[][] liste_oeuvre = new String[taille][4];

// On crée une boucle qui va transférer chaque occurence de l'Arrylist dans
// une ligne du tableau
for(String[] a:list) {
	//liste_oeuvre[s]=a;
	for(int j=0;j<4;j++){liste_oeuvre[s][j]=a[j];}
s ++;}

// on renvoie le tableau de String obtenu
return liste_oeuvre;
}

public String[][] getListeAdh()
{
ArrayList <String[]> lista = new ArrayList<String[]>();

try {
// La méthode getConnexion() de la classe statique ControleConnexion
// retourne
// la référence de la connexion initialisée selon les paramètres
// utilisateur stocké dans
// le bean LesParamètres lors du chargement de la classe à la
// compilation
// On référence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les éventuelles exceptions lancées par le référencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On crée le code SQL de la requête de recherche de la liste de tous les
// noms de pays
// contenus dans la table pays de la BDD
	requete = "select * from adherent";
// On crée un objet Statement à partir duquel on va lancer la requête
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On exécute la requête et onrécupère le résultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les résultats de la requête par le biais des méthodes de
// l'objet Resultset
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur présente dans la
// colonne intitulée dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	String[] tampon = new String[3];
	tampon[0] = jeuEnregistrements.getString("numero_adherent");
	tampon[1] = jeuEnregistrements.getString("nom_adherent");
	tampon[2] = jeuEnregistrements.getString("prenom_adherent");
	lista.add(tampon);
i++;}
// On referme les objets Statement et Resultset utilisés car on en aura
// plus besoin
// Il est préférable de le faire soi même plutôt que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la mémoire
// système
jeuEnregistrements.close();
state.close();
}
// On intercepte les éventuelles exceptions SQL généré par l'exécution de la
// requête
catch (Exception e){
// On affiche un message indiquant la nature du problème par le biais
// d'une fenêtre
JOptionPane.showMessageDialog(null, "Problème lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces éventuelle de l'exception lancée
e.printStackTrace();
}
//On initialise une variable taille qui permettra de créer un tableau de la
// même
// taille que l'ArrayList tampon...
int taille=lista.size();

int s=0;
// Génération du tableau qui va contenir les noms 
String[][] liste_adh = new String[taille][3];

// On crée une boucle qui va transférer chaque occurence de l'Arrylist dans
// une ligne du tableau
for(String[] a:lista) {
	//liste_oeuvre[s]=a;
	for(int j=0;j<3;j++){liste_adh[s][j]=a[j];}
s ++;}

// On retourne le tableau de String obtenu
return liste_adh;
}

public String[] getOeuvre(int num)
{
	String[] tampon = new String[6];
try {
// La méthode getConnexion() de la classe statique ControleConnexion
// retourne
// la référence de la connexion initialisée selon les paramètres
// utilisateur stocké dans
// le bean LesParamètres lors du chargement de la classe à la
// compilation
// On référence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les éventuelles exceptions lancées par le référencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On crée le code SQL de la requête de recherche 
	requete = "select * from oeuvre,proprietaire where oeuvre.num_oeuvre=";
	requete +=num;
	requete +=" and proprietaire.numero_proprietaire=oeuvre.numero_proprietaire";
	System.out.println(requete);
	
// On crée un objet Statement à partir duquel on va lancer la requête
Statement state = (Statement) laConnexion.createStatement();
// On exécute la requête et on récupère le résultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les résultats de la requête par le biais des méthodes de
// l'objet Resultset
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur présente dans la
// colonne dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	
	tampon[0] = jeuEnregistrements.getString("num_oeuvre");
	tampon[1] = jeuEnregistrements.getString("titre_oeuvre");
	tampon[2] = jeuEnregistrements.getString("prix_oeuvre");
	tampon[3] = jeuEnregistrements.getString("statut_oeuvre");
	tampon[4] = jeuEnregistrements.getString("nom_proprietaire");
	tampon[5] = jeuEnregistrements.getString("prenom_proprietaire");
	}
// On referme les objets Statement et Resultset utilisés car on en aura
// plus besoin
// Il est préférable de le faire soi même plutôt que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la mémoire
// système
jeuEnregistrements.close();
state.close();
}
// On intercepte les éventuelles exceptions SQL généré par l'exécution de la
// requête
catch (Exception e){
// On affiche un message indiquant la nature du problème par le biais
// d'une fenêtre
JOptionPane.showMessageDialog(null, "Problème lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces éventuelle de l'exception lancée
e.printStackTrace();
}

// on retourne la tableau de String obtenu
return tampon;
}

public String[][] getListeProprio()
{
ArrayList <String[]> lista = new ArrayList<String[]>();

try {
// La méthode getConnexion() de la classe statique ControleConnexion
// retourne
// la référence de la connexion initialisée selon les paramètres
// utilisateur stocké dans
// le bean LesParamètres lors du chargement de la classe à la
// compilation
// On référence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les éventuelles exceptions lancées par le référencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On crée le code SQL de la requête 
	requete = "select * from proprietaire";
// On crée un objet Statement à partir duquel on va lancer la requête
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On exécute la requête et onrécupère le résultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les résultats de la requête par le biais des méthodes de
// l'objet Resultset
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur présente dans la
// colonne intitulée dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	String[] tampon = new String[3];
	tampon[0] = jeuEnregistrements.getString("numero_proprietaire");
	tampon[1] = jeuEnregistrements.getString("nom_proprietaire");
	tampon[2] = jeuEnregistrements.getString("prenom_proprietaire");
	lista.add(tampon);
i++;}
// On referme les objets Statement et Resultset utilisés car on en aura
// plus besoin
// Il est préférable de le faire soi même plutôt que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la mémoire
// système
jeuEnregistrements.close();
state.close();
}
// On intercepte les éventuelles exceptions SQL généré par l'exécution de la
// requête
catch (Exception e){
// On affiche un message indiquant la nature du problème par le biais
// d'une fenêtre
JOptionPane.showMessageDialog(null, "Problème lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces éventuelle de l'exception lancée
e.printStackTrace();
}
//On initialise une variable taille qui permettra de créer un tableau de la
// même taille que l'ArrayList tampon...
int taille=lista.size();

int s=0;
// Génération du tableau qui va contenir toutes les occurences
String[][] liste_adh = new String[taille][3];

// On crée une boucle qui va transférer chaque occurence de l'Arrylist dans
// une ligne du tableau
for(String[] a:lista) {
	//liste_oeuvre[s]=a;
	for(int j=0;j<3;j++){liste_adh[s][j]=a[j];}
s ++;}

// La méthode retourne un tableau de chaîne de caractère
return liste_adh;
}

}
