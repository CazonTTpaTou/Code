package trace;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

/** Classe permettant de g�rer les fichiers de trace dans lesquels sont inscrits tous les d�tails des diff�rents processus de simulation de stock.
 * 
 * @author Fabien Monnery
 *
 */
public class Trace {
	 static FileWriter client;
	 static FileWriter entrepot;
	 static FileWriter resultat;
	 static FileWriter reassort;
	 static FileWriter clientfactory;
	
	 /** Constructeur de la classe cr�ant les 4 fichiers trace
	  * 
	  * @throws IOException
	  */
	private Trace() throws IOException{
	
	clientfactory = new FileWriter("Factory.txt");
	client = new FileWriter("Client.txt");
	entrepot = new FileWriter("Entrepot.txt");
	resultat = new FileWriter("Resultats.txt");
	reassort = new FileWriter("Reassort.txt");}
	
	/** 
 	* Instruction statique qui impl�mente le constructeur d�s le 
 	* chargement de la classe par la JVM
 	*/
	static {try {new Trace();} 
			catch (IOException e) {e.printStackTrace();}
			}
	/** 
 	* M�thode qui inscrit un message dans le fichier trace ClientFactory.txt
 	* @param entree 
 	* contenu du message � inscrire dans le fichier trace
 	*/
	public static void clientfactory(String entree) throws IOException {
		PrintWriter arr = new PrintWriter(new FileWriter("Factory.txt",true));
		arr.println(entree);
		arr.close();
	}
	/** 
 	* M�thode qui inscrit un message dans le fichier trace Client.txt
 	* @param entree 
 	* contenu du message � inscrire dans le fichier trace
 	*/
	public static void client(String entree) throws IOException {
		PrintWriter arr = new PrintWriter(new FileWriter("Client.txt",true));
		arr.println(entree);
		arr.close();
	}
	/** 
 	* M�thode qui inscrit un message dans le fichier trace Entrepot.txt
 	* @param entree 
 	* contenu du message � inscrire dans le fichier trace
 	*/
	public static void entrepot(String entree) throws IOException {
		PrintWriter fil = new PrintWriter(new FileWriter("Entrepot.txt",true));
		fil.println(entree);
		fil.close();
	}
	
	/** 
 	* M�thode qui inscrit un message dans le fichier trace Resultat.txt - tous contenant les r�sultats finaux de la simulation 
 	* @param entree 
 	* contenu du message � inscrire dans le fichier trace
 	*/
	public static void result(String entree) throws IOException {
		PrintWriter resu = new PrintWriter(new FileWriter("Resultats.txt",true));
		resu.println(entree);
		resu.close();
	}
	
	/** 
 	* M�thode qui inscrit un message dans le fichier trace Reassort.txt
 	* @param entree 
 	* contenu du message � inscrire dans le fichier trace
 	*/
	public static void reassort(String entree) throws IOException {
		PrintWriter lis = new PrintWriter(new FileWriter("Reassort.txt",true));
		lis.println(entree);
		lis.close();
	}
	
}

