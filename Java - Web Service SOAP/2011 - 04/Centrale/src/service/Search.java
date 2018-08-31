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
// On cr�e une variable statique de type Connection qui va r�f�rencer la connexion � la
// BDD expo
// Cette variable statique ne sera pas instanci�e car la connexion � la BDD doit �tre
// unique
// Pour un utilisateur donn� on veut une et une seule connexion et un seul acc�s � la
// BDD
// Si autant de connexions �taient cr��es que de fois o� l'utilisateur se connecte � la
// BDD
// par le biais des m�thodes de recherche, les ressources m�moires s'�puiseraient tr�s
// vite
// et les performances deviendraient tr�s vite m�diocres
static Connection laConnexion ;
ArrayList <String[]> list = new ArrayList<String[]>();

public boolean requete(String requete) {
boolean success;
String[] info_pays = new String[2];
try {
// La m�thode getConnexion() de la classe statique ControleConnexion
// retourne
// la r�f�rence de la connexion initialis�e selon les param�tres
// utilisateur stock� dans
// le bean LesParam�tres lors du chargement de la classe � la
// compilation
// On r�f�rence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
// On intercepte les �ventuelles exceptions lanc�es par le
// r�f�rencement de la connexion
} catch (Exception e) {
e.printStackTrace();}

try {

// On cr�e un objet Statement � partir duquel on va lancer la requ�te
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On ex�cute la requ�te et onr�cup�re le r�sultat dans un objet de type
// Resultset
System.out.println(requete);
state.executeUpdate(requete);
// On referme les objets Statement et Resultset utilis�s car on en aura
// plus besoin
// Il est pr�f�rable de le faire soi m�me plut�t que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la m�moire
// syst�me
state.close();
success=true;
}
// On intercepte les �ventuelles exceptions SQL g�n�r� par l'ex�cution de la
// requ�te
catch (SQLException e){
// On affiche un message indiquant la nature du probl�me par le biais
// d'une fen�tre
JOptionPane.showMessageDialog(null, "Probl�me lors de la recherche.","",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces �ventuelle de l'exception lanc�e
e.printStackTrace();
success=false;}

return success;
}

// La m�thode  va op�rer la requ�te de recherche des oeuvres pr�sentes 
// dans la table de la BDD
// et les retournera sous forme de tableau de cha�ne de caract�res (en effet une
// ArrayList aurait
// �t� plus commode d'autant qu'on ne conna�t pas � l'avance le nombre d'entr�es
// retourn�es, mais
// le type ArrayList ne passe pas dans le formatage XML des messages de type SOAP,
// utilis�es par les web services
// on utilisera donc un �tat interm�diaire de tableau de 
// cha�nes de caract�res de type String[] qui sera encapsul� dans un ArrayOfString.
public String[][] getListe()
{
try {
// La m�thode getConnexion() de la classe statique ControleConnexion
// retourne
// la r�f�rence de la connexion initialis�e selon les param�tres
// utilisateur stock� dans
// le bean LesParam�tres lors du chargement de la classe � la
// compilation
// On r�f�rence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les �ventuelles exceptions lanc�es par le r�f�rencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On cr�e le code SQL de la requ�te de recherche de la liste de tous les
// les champs et de toutes les lignes de la table oeuvre
// contenus dans la table pays de la BDD
	requete = "select * from oeuvre";
// On cr�e un objet Statement � partir duquel on va lancer la requ�te
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On ex�cute la requ�te et onr�cup�re le r�sultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les r�sultats de la requ�te par le biais des m�thodes de
// l'objet Resultset
// Ici, on a plusieurs lignes de r�sultat car de nombreux noms de pays
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur pr�sente dans la
// colonne intitul�e selon le param�tre pass� � la m�thode getString
// dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	String[] tampon = new String[4];
	tampon[0] = jeuEnregistrements.getString("num_oeuvre");
	tampon[1] = jeuEnregistrements.getString("titre_oeuvre");
	tampon[2] = jeuEnregistrements.getString("prix_oeuvre");
	tampon[3] = jeuEnregistrements.getString("statut_oeuvre");
	list.add(tampon);
i++;}
// On referme les objets Statement et Resultset utilis�s car on en aura
// plus besoin
// Il est pr�f�rable de le faire soi m�me plut�t que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la m�moire
// syst�me
jeuEnregistrements.close();
state.close();
}
// On intercepte les �ventuelles exceptions SQL g�n�r� par l'ex�cution de la
// requ�te
catch (Exception e){
// On affiche un message indiquant la nature du probl�me par le biais
// d'une fen�tre
JOptionPane.showMessageDialog(null, "Probl�me lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces �ventuelle de l'exception lanc�e
e.printStackTrace();
}
//On initialise une variable taille qui permettra de cr�er un tableau de la
// m�me
// taille que l'ArrayList tampon...
int taille=list.size();

int s=0;
// G�n�ration du tableau qui va contenir toutes les oeuvres
String[][] liste_oeuvre = new String[taille][4];

// On cr�e une boucle qui va transf�rer chaque occurence de l'Arrylist dans
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
// La m�thode getConnexion() de la classe statique ControleConnexion
// retourne
// la r�f�rence de la connexion initialis�e selon les param�tres
// utilisateur stock� dans
// le bean LesParam�tres lors du chargement de la classe � la
// compilation
// On r�f�rence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les �ventuelles exceptions lanc�es par le r�f�rencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On cr�e le code SQL de la requ�te de recherche de la liste de tous les
// noms de pays
// contenus dans la table pays de la BDD
	requete = "select * from adherent";
// On cr�e un objet Statement � partir duquel on va lancer la requ�te
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On ex�cute la requ�te et onr�cup�re le r�sultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les r�sultats de la requ�te par le biais des m�thodes de
// l'objet Resultset
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur pr�sente dans la
// colonne intitul�e dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	String[] tampon = new String[3];
	tampon[0] = jeuEnregistrements.getString("numero_adherent");
	tampon[1] = jeuEnregistrements.getString("nom_adherent");
	tampon[2] = jeuEnregistrements.getString("prenom_adherent");
	lista.add(tampon);
i++;}
// On referme les objets Statement et Resultset utilis�s car on en aura
// plus besoin
// Il est pr�f�rable de le faire soi m�me plut�t que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la m�moire
// syst�me
jeuEnregistrements.close();
state.close();
}
// On intercepte les �ventuelles exceptions SQL g�n�r� par l'ex�cution de la
// requ�te
catch (Exception e){
// On affiche un message indiquant la nature du probl�me par le biais
// d'une fen�tre
JOptionPane.showMessageDialog(null, "Probl�me lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces �ventuelle de l'exception lanc�e
e.printStackTrace();
}
//On initialise une variable taille qui permettra de cr�er un tableau de la
// m�me
// taille que l'ArrayList tampon...
int taille=lista.size();

int s=0;
// G�n�ration du tableau qui va contenir les noms 
String[][] liste_adh = new String[taille][3];

// On cr�e une boucle qui va transf�rer chaque occurence de l'Arrylist dans
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
// La m�thode getConnexion() de la classe statique ControleConnexion
// retourne
// la r�f�rence de la connexion initialis�e selon les param�tres
// utilisateur stock� dans
// le bean LesParam�tres lors du chargement de la classe � la
// compilation
// On r�f�rence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les �ventuelles exceptions lanc�es par le r�f�rencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On cr�e le code SQL de la requ�te de recherche 
	requete = "select * from oeuvre,proprietaire where oeuvre.num_oeuvre=";
	requete +=num;
	requete +=" and proprietaire.numero_proprietaire=oeuvre.numero_proprietaire";
	System.out.println(requete);
	
// On cr�e un objet Statement � partir duquel on va lancer la requ�te
Statement state = (Statement) laConnexion.createStatement();
// On ex�cute la requ�te et on r�cup�re le r�sultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les r�sultats de la requ�te par le biais des m�thodes de
// l'objet Resultset
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur pr�sente dans la
// colonne dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	
	tampon[0] = jeuEnregistrements.getString("num_oeuvre");
	tampon[1] = jeuEnregistrements.getString("titre_oeuvre");
	tampon[2] = jeuEnregistrements.getString("prix_oeuvre");
	tampon[3] = jeuEnregistrements.getString("statut_oeuvre");
	tampon[4] = jeuEnregistrements.getString("nom_proprietaire");
	tampon[5] = jeuEnregistrements.getString("prenom_proprietaire");
	}
// On referme les objets Statement et Resultset utilis�s car on en aura
// plus besoin
// Il est pr�f�rable de le faire soi m�me plut�t que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la m�moire
// syst�me
jeuEnregistrements.close();
state.close();
}
// On intercepte les �ventuelles exceptions SQL g�n�r� par l'ex�cution de la
// requ�te
catch (Exception e){
// On affiche un message indiquant la nature du probl�me par le biais
// d'une fen�tre
JOptionPane.showMessageDialog(null, "Probl�me lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces �ventuelle de l'exception lanc�e
e.printStackTrace();
}

// on retourne la tableau de String obtenu
return tampon;
}

public String[][] getListeProprio()
{
ArrayList <String[]> lista = new ArrayList<String[]>();

try {
// La m�thode getConnexion() de la classe statique ControleConnexion
// retourne
// la r�f�rence de la connexion initialis�e selon les param�tres
// utilisateur stock� dans
// le bean LesParam�tres lors du chargement de la classe � la
// compilation
// On r�f�rence cette connexion avec notre variable statique de classe
// laConnexion
laConnexion= (Connection) ControleConnexion.getConnexion();
}
// On intercepte les �ventuelles exceptions lanc�es par le r�f�rencement de la
// connexion
catch (Exception e) {
e.printStackTrace();}
String requete = null;
int i=0;
try {
// On cr�e le code SQL de la requ�te 
	requete = "select * from proprietaire";
// On cr�e un objet Statement � partir duquel on va lancer la requ�te
// SQL
Statement state = (Statement) laConnexion.createStatement();
// On ex�cute la requ�te et onr�cup�re le r�sultat dans un objet de type
// Resultset
ResultSet jeuEnregistrements = state.executeQuery(requete);
// On parcourt les r�sultats de la requ�te par le biais des m�thodes de
// l'objet Resultset
// On utilise donc une boucle While pour parcourir chaque ligne du
// Resultset
// A chaque ligne du Resultset, on ajoute la valeur pr�sente dans la
// colonne intitul�e dans la variable tampon de type ArrayList
while(jeuEnregistrements.next()) {
	String[] tampon = new String[3];
	tampon[0] = jeuEnregistrements.getString("numero_proprietaire");
	tampon[1] = jeuEnregistrements.getString("nom_proprietaire");
	tampon[2] = jeuEnregistrements.getString("prenom_proprietaire");
	lista.add(tampon);
i++;}
// On referme les objets Statement et Resultset utilis�s car on en aura
// plus besoin
// Il est pr�f�rable de le faire soi m�me plut�t que d'attendre que le
// "ramasse miette"
// de la JVM s'en charge, au risque d'occuper inutilement la m�moire
// syst�me
jeuEnregistrements.close();
state.close();
}
// On intercepte les �ventuelles exceptions SQL g�n�r� par l'ex�cution de la
// requ�te
catch (Exception e){
// On affiche un message indiquant la nature du probl�me par le biais
// d'une fen�tre
JOptionPane.showMessageDialog(null, "Probl�me lors de la recherche : "+
i,"",
JOptionPane.ERROR_MESSAGE);
// On imprime les traces �ventuelle de l'exception lanc�e
e.printStackTrace();
}
//On initialise une variable taille qui permettra de cr�er un tableau de la
// m�me taille que l'ArrayList tampon...
int taille=lista.size();

int s=0;
// G�n�ration du tableau qui va contenir toutes les occurences
String[][] liste_adh = new String[taille][3];

// On cr�e une boucle qui va transf�rer chaque occurence de l'Arrylist dans
// une ligne du tableau
for(String[] a:lista) {
	//liste_oeuvre[s]=a;
	for(int j=0;j<3;j++){liste_adh[s][j]=a[j];}
s ++;}

// La m�thode retourne un tableau de cha�ne de caract�re
return liste_adh;
}

}
