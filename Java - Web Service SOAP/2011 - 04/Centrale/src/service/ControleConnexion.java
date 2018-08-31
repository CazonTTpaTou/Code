package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;
// Il s'agit d'une classe abstraite qui ne pourra donc pas �tre instanci�e
// car on ne veut pas multiplier les connexions pour chaque utilisateur
// Un Utilisateur = Une connexion param�tr�e statiquement
// L'acc�s aux membres de la classe est r�alis� selon la syntaxe classe.accesseur et s'effectue
// directement sans recherche dynamique
public abstract class ControleConnexion {
// On initialise les variables statiques de la classe
// En d�clarant les attributs d'une classe comme statique, les instances potentielles de la
// classe ne poss�dent pas les attributs. L'acc�s peut �tre r�alis� selon la syntaxe
// object.accesseur, l'acc�s
// aux attributs se faisant alors de mani�re dynamique.
// Les propri�t�s statiques appartiennent � la classe et non aux objets de la classe...
static Parametres lesParametres;
static boolean etatConnexion;
static Connection laConnectionStatique;
// On utilise un initialisateur statique pour construire la classe ControleConnexion
// Cela remplace le constructeur et permet de s'assurer que la classe ne sera pas
// instanci�e
// et cela nous �vite d'invoquer dans le code une instruction de construction de la classe.
// L'initialisation s'effectue imm�diatement apr�s la d�claration aupr�s du compilateur.
// L'int�r�t d'une connexion statique est de disposer d'une connexion unique et
// utilisable
// durant toute une session.
static {
// On cr�e une variable bool�enne qui nous servira de flag renseignant le succ�s
// du chargement
// du pilote JDBC de la BDD
boolean ok = true;
// On instancie la classe Parametres qui contient tous les param�tres de la
// connexion
// Id�alement les attributs de la classe Param�tres devrait �tre renseign�s
// dynamiquement
// par l'utilisateur
lesParametres = new Parametres();
try {
// On effectue l'enregistrement du pilote de l'acc�s � la BDD MySQL
// Class correspond � la classe du pilote. Avec sa m�thode statique
// forName(), elle cr�e une instance
// d'elle m�me - qui est donc charg�e en m�moire - et l'enregistre aupr�s
// de la classe DriverManager
Class.forName(lesParametres.getDriverSGBD());
etatConnexion = true;
} catch(ClassNotFoundException e){
// En cas d'�chec du chargement de la classe, on affiche un message
// d'erreur
JOptionPane.showMessageDialog(null, "Classes non trouv�es"
+ " pour le chargement du pilote JDBC MySQL",
"ALERTE", JOptionPane.ERROR_MESSAGE);
e.printStackTrace();
ok = false;
etatConnexion = false;
}
// Si l'initialisation statique de la classe se d�roule correctement le flag OK est �
// true
if (ok == true){
try {
// A partir desaccesseurs de la classe Param�tres, on r�cup�re les
// param�tres de connexion
String urlBD = lesParametres.getServeurBD();
String nomUtilisateur = lesParametres.getNomUtilisateur();
String MDP = lesParametres.getMotDePasse();
// On cr�e une connection par le biais de la m�thode
// getConnection de la classe
// DriverManager qui est param�tr� selon les variables fournis par
// les accesseurs de la
// classe param�tre. La classe DriverManager �tant une instance
// du pilote JDBC MySQL
// cr�e plus haut par l'instruction Class.forName() et qui
// communique directement avec
// la BDD MySQL dont on aura fourni l'adresse sous forme
// d'URL.
// On r�f�rence la connection obtenue par le biais de la variable
// laConnectionStatique
laConnectionStatique = DriverManager.getConnection(urlBD,
nomUtilisateur,
MDP);
etatConnexion = true;
} // En cas d'exceptions g�n�r�es par la cr�ation de la connection � la BDD
// MySQL, on intercepte
// le message et on affiche une fen�tre d'erreur.
catch (Exception e) {
JOptionPane.showMessageDialog(null, "Impossible de se connecter" +
" � la base de donn�es",
"ALERTE", JOptionPane.ERROR_MESSAGE);
// Etant donn� que la tentative de cr�ation de connection a �chou� on
// d�clare
// le flag d'�tat de la connection � False par le biais de la variable
// etatConnexion
etatConnexion = false;
}
}
}
// Etant donn� que l'on a recours � un initialisateur statique, le constructeur de la
// classe est vide
public ControleConnexion(){
}
// La m�thode getParametres nous permet de r�cup�rer les param�tres de connection �
// la BDD MySQL
// stock�s dans le Bean Param�tres dans le package entite
public static Parametres getParametres(){
return lesParametres;
}
// Cette m�thode retourne l'�tat de connection. Si la cr�ation s'est d�roul�e
// correctement, la valeur
// retourn�e sera True. Sinon, le flag retourn� sera � False.
public static boolean getControleConnexion(){
return etatConnexion;
}
// Cette m�thode renvoie une r�f�rence � laConnectionStatique qui est la variable qui
// r�f�rence
// la connection cr�e lors de l'initialisation statique de la classe ControleConnexion().
// Cette classe est cr�e une seule fois, lorsque l'utilisateur invoque la premi�re fois une
// des m�thodes
// de la classe. De ce fait, chaque fois que la m�thode getConnexion() est invoqu�e, la
// r�f�rence
// renvoy�e par le biais de la variable laConnectionStatique pointe toujours vers la
// m�me r�f�rence
// de connection cr��e lors de l'initialisation de la classe. Ainsi, on est assur�e, que
// chaque
// utilisateur utilisera toujours la m�me connection � la BDD MySql au sein de la
// session qu'il
// aura cr��e, par le biais de l'utilisation de la JSP affich�e par son navigateur.
public static Connection getConnexion(){
return laConnectionStatique;
}
// Cette m�thode ne sert pas dans le pr�sent TP, puisque les param�tres sont rentr�s en
// dur dans
// le Bean Param�tres. Cependant, l'utilisateur doit au moins rentrer un mot de passe
// g�n�ralement,
// pour pouvoir se connecter � une BDD. C'est pourquoi, nous avons cr�� une m�thode
// qui v�rifie que
// les param�tres de connection rentr� par l'utilisateur sont corrects. De ce fait, cela
// rend cette
// classe ControleConnexion() r�utilisable dans un autre contexte que ce lui ce ce TP, ce
// qui
// est l'objectif premier d'un langage objet comme Java.
public static boolean controle(String Nom, String MotDePasse){
boolean verificationSaisie;
if (Nom.equals(lesParametres.getNomUtilisateur())
&& MotDePasse.equals(lesParametres.getMotDePasse())){
verificationSaisie = true;
} else {
JOptionPane.showMessageDialog(null, "V�rifier votre saisie.",
"ERREUR", JOptionPane.ERROR_MESSAGE);
verificationSaisie = false;
}
return verificationSaisie;
}
// Cette m�thode permet de fermer la connection � la BDD MySQL, ind�pendamment
// du garbage collector de
// la JVM, ce qui permet un meilleur contr�le des ressources du serveur (notamment en
// cas de mont�e en
// charge avec de nombreux utilisateurs simultan�s).
public static void fermetureSession(){
try {
laConnectionStatique.close();
} catch (
SQLException e) {
JOptionPane.showMessageDialog(null, "Probl�me rencontr�" +
"� la fermeture de la connexion",
"ERREUR", JOptionPane.ERROR_MESSAGE);
}
}
}