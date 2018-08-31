package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;
// Il s'agit d'une classe abstraite qui ne pourra donc pas être instanciée
// car on ne veut pas multiplier les connexions pour chaque utilisateur
// Un Utilisateur = Une connexion paramétrée statiquement
// L'accès aux membres de la classe est réalisé selon la syntaxe classe.accesseur et s'effectue
// directement sans recherche dynamique
public abstract class ControleConnexion {
// On initialise les variables statiques de la classe
// En déclarant les attributs d'une classe comme statique, les instances potentielles de la
// classe ne possèdent pas les attributs. L'accès peut être réalisé selon la syntaxe
// object.accesseur, l'accès
// aux attributs se faisant alors de manière dynamique.
// Les propriétés statiques appartiennent à la classe et non aux objets de la classe...
static Parametres lesParametres;
static boolean etatConnexion;
static Connection laConnectionStatique;
// On utilise un initialisateur statique pour construire la classe ControleConnexion
// Cela remplace le constructeur et permet de s'assurer que la classe ne sera pas
// instanciée
// et cela nous évite d'invoquer dans le code une instruction de construction de la classe.
// L'initialisation s'effectue immédiatement après la déclaration auprès du compilateur.
// L'intérêt d'une connexion statique est de disposer d'une connexion unique et
// utilisable
// durant toute une session.
static {
// On crée une variable booléenne qui nous servira de flag renseignant le succès
// du chargement
// du pilote JDBC de la BDD
boolean ok = true;
// On instancie la classe Parametres qui contient tous les paramètres de la
// connexion
// Idéalement les attributs de la classe Paramètres devrait être renseignés
// dynamiquement
// par l'utilisateur
lesParametres = new Parametres();
try {
// On effectue l'enregistrement du pilote de l'accès à la BDD MySQL
// Class correspond à la classe du pilote. Avec sa méthode statique
// forName(), elle crée une instance
// d'elle même - qui est donc chargée en mémoire - et l'enregistre auprès
// de la classe DriverManager
Class.forName(lesParametres.getDriverSGBD());
etatConnexion = true;
} catch(ClassNotFoundException e){
// En cas d'échec du chargement de la classe, on affiche un message
// d'erreur
JOptionPane.showMessageDialog(null, "Classes non trouvées"
+ " pour le chargement du pilote JDBC MySQL",
"ALERTE", JOptionPane.ERROR_MESSAGE);
e.printStackTrace();
ok = false;
etatConnexion = false;
}
// Si l'initialisation statique de la classe se déroule correctement le flag OK est à
// true
if (ok == true){
try {
// A partir desaccesseurs de la classe Paramètres, on récupère les
// paramètres de connexion
String urlBD = lesParametres.getServeurBD();
String nomUtilisateur = lesParametres.getNomUtilisateur();
String MDP = lesParametres.getMotDePasse();
// On crée une connection par le biais de la méthode
// getConnection de la classe
// DriverManager qui est paramétré selon les variables fournis par
// les accesseurs de la
// classe paramètre. La classe DriverManager étant une instance
// du pilote JDBC MySQL
// crée plus haut par l'instruction Class.forName() et qui
// communique directement avec
// la BDD MySQL dont on aura fourni l'adresse sous forme
// d'URL.
// On référence la connection obtenue par le biais de la variable
// laConnectionStatique
laConnectionStatique = DriverManager.getConnection(urlBD,
nomUtilisateur,
MDP);
etatConnexion = true;
} // En cas d'exceptions générées par la création de la connection à la BDD
// MySQL, on intercepte
// le message et on affiche une fenêtre d'erreur.
catch (Exception e) {
JOptionPane.showMessageDialog(null, "Impossible de se connecter" +
" à la base de données",
"ALERTE", JOptionPane.ERROR_MESSAGE);
// Etant donné que la tentative de création de connection a échoué on
// déclare
// le flag d'état de la connection à False par le biais de la variable
// etatConnexion
etatConnexion = false;
}
}
}
// Etant donné que l'on a recours à un initialisateur statique, le constructeur de la
// classe est vide
public ControleConnexion(){
}
// La méthode getParametres nous permet de récupérer les paramètres de connection à
// la BDD MySQL
// stockés dans le Bean Paramètres dans le package entite
public static Parametres getParametres(){
return lesParametres;
}
// Cette méthode retourne l'état de connection. Si la création s'est déroulée
// correctement, la valeur
// retournée sera True. Sinon, le flag retourné sera à False.
public static boolean getControleConnexion(){
return etatConnexion;
}
// Cette méthode renvoie une référence à laConnectionStatique qui est la variable qui
// référence
// la connection crée lors de l'initialisation statique de la classe ControleConnexion().
// Cette classe est crée une seule fois, lorsque l'utilisateur invoque la première fois une
// des méthodes
// de la classe. De ce fait, chaque fois que la méthode getConnexion() est invoquée, la
// référence
// renvoyée par le biais de la variable laConnectionStatique pointe toujours vers la
// même référence
// de connection créée lors de l'initialisation de la classe. Ainsi, on est assurée, que
// chaque
// utilisateur utilisera toujours la même connection à la BDD MySql au sein de la
// session qu'il
// aura créée, par le biais de l'utilisation de la JSP affichée par son navigateur.
public static Connection getConnexion(){
return laConnectionStatique;
}
// Cette méthode ne sert pas dans le présent TP, puisque les paramètres sont rentrés en
// dur dans
// le Bean Paramètres. Cependant, l'utilisateur doit au moins rentrer un mot de passe
// généralement,
// pour pouvoir se connecter à une BDD. C'est pourquoi, nous avons créé une méthode
// qui vérifie que
// les paramètres de connection rentré par l'utilisateur sont corrects. De ce fait, cela
// rend cette
// classe ControleConnexion() réutilisable dans un autre contexte que ce lui ce ce TP, ce
// qui
// est l'objectif premier d'un langage objet comme Java.
public static boolean controle(String Nom, String MotDePasse){
boolean verificationSaisie;
if (Nom.equals(lesParametres.getNomUtilisateur())
&& MotDePasse.equals(lesParametres.getMotDePasse())){
verificationSaisie = true;
} else {
JOptionPane.showMessageDialog(null, "Vérifier votre saisie.",
"ERREUR", JOptionPane.ERROR_MESSAGE);
verificationSaisie = false;
}
return verificationSaisie;
}
// Cette méthode permet de fermer la connection à la BDD MySQL, indépendamment
// du garbage collector de
// la JVM, ce qui permet un meilleur contrôle des ressources du serveur (notamment en
// cas de montée en
// charge avec de nombreux utilisateurs simultanés).
public static void fermetureSession(){
try {
laConnectionStatique.close();
} catch (
SQLException e) {
JOptionPane.showMessageDialog(null, "Problème rencontré" +
"à la fermeture de la connexion",
"ERREUR", JOptionPane.ERROR_MESSAGE);
}
}
}