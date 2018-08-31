import java.io.*;
import java.util.*;

public class GestionAgenceBi{

public static void main (String[] args) throws IOException {

	//System.out.println("Choisissez le taux d'interet:");	
	final double Taux_Epargne = Double.parseDouble(args[0]);
	final double Taux_CCourant = Double.parseDouble(args[1]);
	
	AgenceBancaire Lyon = new AgenceBancaire();

	boolean FindeSaisie = false;
	String inLine="";

	Reader byteToChar = new InputStreamReader(System.in);
	BufferedReader entree = new BufferedReader(byteToChar);

	while(!(inLine.equalsIgnoreCase("q"))) {
		System.out.println("C ou E / Nom / Adresse :");
		inLine = entree.readLine();
		if (inLine.equalsIgnoreCase("q")){System.out.println("Fin de la saisie des comptes bancaires...");}
			else {try {
				Scanner sc = new Scanner(inLine);
				String type = sc.next();
				String nom = sc.next();
				String adresse = sc.next();
				
				char typec = type.charAt(0);
				final char s1='E';
				final char s2='C';
				switch(typec) {
					case s1:
						Lyon.ajouterCompte(new CompteEpargne(nom,adresse,Taux_Epargne));
						break;
					case s2:
						Lyon.ajouterCompte(new CompteCourant(nom,adresse,Taux_CCourant));
						break;
					default:
						throw new java.util.NoSuchElementException();}
						
				
			}
		
			catch (java.util.NoSuchElementException e) {System.out.println("Les elements ne sont pas au bon format - Recommencez a nouveau:");}
			}
	}
	System.out.println(Lyon.toString());
	
	inLine="";

	while(!(inLine.equalsIgnoreCase("F"))) {
		System.out.println("Tapez D pour debiter, C pour crediter, F pour quitter:");
		inLine = entree.readLine();
		if (inLine.equalsIgnoreCase("F")){System.out.println("Sortie de l'application");}
			else {try {
				
				Scanner sc1 = new Scanner(inLine);
				String type2 = sc1.next();
				
				char typeo = type2.charAt(0);
				final char s3='D';
				final char s4='C';
		
				switch(typeo) {
					case s3:
						System.out.println("Vous avez choisi une opération de debit.");
						System.out.println("Inscrivez le n° du compte et le montant à debiter:");			
						break;
					case s4:
						System.out.println("Vous avez choisi une opération de credit.");
						System.out.println("Inscrivez le n° du compte et le montant à crediter:");			
						break;
					default:
						throw new java.util.NoSuchElementException();}
				
				inLine ="";
				inLine=entree.readLine();
				Scanner sc2 = new Scanner(inLine);

				int Montant;
				int N_Compte;
								
				if(sc2.hasNextInt()) {N_Compte = sc2.nextInt();}
					else {throw new java.util.NoSuchElementException();}
				if(sc2.hasNextInt()) {Montant = sc2.nextInt();}
					else {throw new java.util.NoSuchElementException();}

					switch(typeo) {
					case s3:
						Lyon.rechercherCompte(N_Compte).debiter(Montant);
						System.out.println(Montant+ " ont ete debite du compte n° " + N_Compte);			
						break;
					case s4:
						Lyon.rechercherCompte(N_Compte).crediter(Montant);
						System.out.println(Montant+ " ont ete credite surle compte n° " + N_Compte);			
						break;
						}
				}
		
			catch (java.util.NoSuchElementException e) {System.out.println("Il y a une erreur dans le format de votre saisie - Recommencez a nouveau:");}
			}
	}
	}
}
