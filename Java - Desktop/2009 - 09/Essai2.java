import java.util.*;
import java.util.Arrays;

abstract class CompteBancaire implements Comparable {

private String nom;
private String adresse;
private double solde;
private static int instance = 0;
private int numero;

CompteBancaire(String nom, String adresse) {
	this.nom = nom;
	this.adresse = adresse;
	this.solde = 0;
	instance++;
	numero = instance;
	}

void crediter(double montant) {}

void debiter(double montant) {}

String getAdresse() {
	return adresse; }

String getNom() {
	return nom; }

int getNumero() {
	return numero; }

double getSolde() {
	return solde;}

void setSolde(double montant) {
	solde += montant;}

void setAdresse(String adresse) {
	this.adresse = adresse;}

void setNom(String nom) {
	this.nom = nom;}

public String toString() {
	String chaine = "Compte n� " + this.numero + ". Nom du titulaire: " + this.nom + ". Lieu d'habitation: " + this.adresse + ". Solde de " + this.solde + " �";
	return chaine;
	}

public abstract void traitementQuotidien();

public boolean equals(CompteBancaire c) {
	return this.getNumero() == c.getNumero();}

public int compareTo(Object o) {
      CompteBancaire c = (CompteBancaire)o; 
        int nombre1 = this.getNumero();
	int nombre2 = c.getNumero(); 
	
      if (nombre1 < nombre2)  return -1; 
      else if(nombre1 == nombre2) return 0; 
      else return 1; 
   } 



}

class CompteEpargne extends CompteBancaire {

double tauxInterets;

CompteEpargne(String nom, String adresse, double tauxInterets) {
	
	super(nom, adresse);
	this.tauxInterets = tauxInterets;
	}

public void crediter(double montant) {
	
	this.setSolde(montant);
	//System.out.println("Solde du compte: " + this.getSolde());
	}

public void debiter(double montant) {

	double soldeInt;
	soldeInt = this.getSolde() - montant;	
	if (soldeInt<0) {
		System.out.println("D�bit impossible car compte insuffisamment provisionn�!!!");}
	else {setSolde(-montant);}
	System.out.println("Solde du compte: " + this.getSolde());}

public String toString() {
	String chaine2 = "CompteEpargne. " + super.toString();
	return chaine2;}

public void traitementQuotidien() {
	
	double interets = this.tauxInterets * this.getSolde();
	System.out.println("Le montant des int�r�ts du compte n� " + this.getNumero() + " est de :" + interets + " �");	
	this.crediter(interets);

	}
}


class CompteCourant extends CompteBancaire {

double tauxAgios;

CompteCourant(String nom, String adresse, double tauxAgios) {
	
	super(nom, adresse);
	this.tauxAgios = tauxAgios;
	}

public void crediter(double montant) {
	
	setSolde(montant);
	//System.out.println("Solde du compte: " + this.getSolde());
	}

public void debiter(double montant) {

	double soldeInt;
	
	setSolde(-montant);	
	if (this.getSolde()<0) {
	System.out.println("Attention solde n�gatif !!!");}
	
	//System.out.println("Solde du compte: " + this.getSolde());
	}

public String toString() {
	String chaine1 = "CompteCourant. " + super.toString();
	return chaine1;}

public void traitementQuotidien() {
	
	double agios = 0;
	if (this.getSolde()<0) {
		agios = this.getSolde() * this.tauxAgios;
		this.debiter(agios);}
	System.out.println("Le montant des agios du compte n� " + this.getNumero() + " est de :" + agios + " �");
	}
}


class AgenceBancaire {

private CompteBancaire[] agenceBancaire;
private int capacite = 10;
private int nbComptes = 0;

AgenceBancaire() {
	agenceBancaire = new CompteBancaire[capacite];
	CompteCourant blanc = new CompteCourant("","",0);
	
	for(int i=0 ; i<agenceBancaire.length ; i++) { 
			 
			agenceBancaire[i] = blanc;}
	}

public void ajouterCompte(CompteBancaire c) {
	
	try{
	if (nbComptes >= capacite) {this.redimensionner();}
	
	agenceBancaire[nbComptes] = c;
	nbComptes++;}

	catch(ArrayIndexOutOfBoundsException e) {this.redimensionner();}
	}
	

public void redimensionner() {
	capacite *= 2;
	CompteBancaire[] tampon = new CompteBancaire[capacite];
	for (int i=0;i<agenceBancaire.length;i++) {
		tampon[i] = agenceBancaire[i];}
	for(int j=agenceBancaire.length;j<tampon.length;j++) {
	tampon[j] = agenceBancaire[0];}

	agenceBancaire = tampon;
	}		

public CompteBancaire rechercherCompte(int numero) {
	int number=0;
	boolean trouve;
	trouve = false;
	
	for (int i=0;i<nbComptes;i++) {
		if (agenceBancaire[i].getNumero() == numero) {
			number = i;
			trouve = true;}
	}
		if (trouve) {
		      return agenceBancaire[number];}
		else {return null;
		      //System.out.println("Ce compte n'est pas dans l'agence bancaire.");
		}
	}


public void supprimerCompte(CompteBancaire c) {
	int number=0;
	boolean trouve;
	trouve = false;
	
	if (c == null) {System.out.println("Le compte n'existe pas");}
	else{
	for (int i=0;i<nbComptes;i++) {
		if (agenceBancaire[i].equals(c)) {
			number = i;
			trouve = true;}
	}
		if (trouve) {
			nbComptes--;
			agenceBancaire[number] = agenceBancaire[nbComptes];
			}
		else {System.out.println("Ce compte n'est pas dans l'agence");}}
	}


public void traitementQuotidien() {
	for (int i=0;i<nbComptes;i++) {
		agenceBancaire[i].traitementQuotidien();}
	}
	
			
public String toString() {
	String chainage = "";
	for (int i=0;i<nbComptes;i++) {
		chainage = chainage + agenceBancaire[i].toString() + "\n";
		}
	return chainage;}

public void trierComptes() {
	CompteBancaire[] copie = new CompteBancaire[nbComptes];
	for (int i=0;i<nbComptes;i++) {
			copie[i] = agenceBancaire[i];}

		Arrays.sort(copie);
		agenceBancaire = copie;

	//for (int j=0;j<nbComptes;j++) {
	//		copie[j].toString();}	
	}
}

public class Essai2 {

	public static void main(String[] args) {

		CompteCourant abc = new CompteCourant("Monnery","Lyon",0.05);
		
		abc.crediter(500);
		abc.debiter(1000);
		abc.crediter(2000);
		System.out.println(abc.toString());
		abc.traitementQuotidien();

		System.out.println("");
		CompteEpargne def = new CompteEpargne("Monnery","Lyon",0.03);
		
		def.crediter(5000);
		def.debiter(10000);
		def.crediter(30000);
		System.out.println(def.toString());
		def.traitementQuotidien();

		System.out.println("\n");

		AgenceBancaire Lyon = new AgenceBancaire();

		Lyon.ajouterCompte(abc);
		Lyon.ajouterCompte(def);

		for(int i=0;i<8;i++) {
			Lyon.ajouterCompte(new CompteCourant("Client n� " +i,"Lyon",0.03));
			Lyon.rechercherCompte(2*i+4).crediter(1000*i);
			Lyon.ajouterCompte(new CompteEpargne("Client n� " +i,"Lyon",0.05));
			Lyon.rechercherCompte(2*i+5).crediter(500*3*i);
			}
		
		System.out.println(Lyon.toString());

		Lyon.supprimerCompte(Lyon.rechercherCompte(4));
		Lyon.supprimerCompte(Lyon.rechercherCompte(6));
		Lyon.supprimerCompte(Lyon.rechercherCompte(7));
		Lyon.supprimerCompte(Lyon.rechercherCompte(8));
		
		Lyon.traitementQuotidien();
		System.out.println("\n");
		System.out.println(Lyon.toString());

		Lyon.trierComptes();
		System.out.println(Lyon.toString());
		
	}
}


