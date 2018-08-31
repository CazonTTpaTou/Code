public abstract class CompteBancaire {

private String nom;
private String adresse;
private double solde;
private static int numero = 0;

CompteBancaire(String nom, String adresse) {
	this.nom = nom;
	this.adresse = adresse;
	this.solde = 0;
	numero++;
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

void setAdresse(String adresse) {
	this.adresse = adresse;}

void setNom(String nom) {
	this.nom = nom;}

String toString() {
	String chaine = "Compte n° " + this.numero;
	String chaine = chaine + "de " + this.nom;
	String chaine = chaine + " habitant à " + this.adresse;
	String chaine = chaine + " a un solde de " + this.solde;
	return chaine;
	}

public abstract void traitementQuotidien();

}


public class CompteEpargne extends CompteBancaire {

double tauxInterets;

CompteEpargne(String nom, String adresse, double tauxInterets) {
	
	super(nom, adresse);
	this.tauxInterets = tauxInterets;
	}

public void crediter(double montant) {
	
	this.solde += montant;
	System.out.println("Solde du compte: " + this.getSolde());}

public void debiter(double montant) {

	double soldeInt;
	soldeInt = this.solde - montant;	
	if (soldeInt<0) {
		System.out.println("Débit impossible car compte insuffisamment provisionné!!!");}
	else {this.solde -= montant;}
	System.out.println("Solde du compte: " + this.getSolde());}

public String toString() {
	string chaine = "CompteEpargne. " + super.toString();
	return chaine;}

public void traitementQuotidien() {
	
	double interets = this.tauxInterets * this.getSolde();
	this.crediter(interets);
	}
}


public class CompteCourant extends CompteBancaire {

double tauxAgios;

CompteCourant(String nom, String adresse, double tauxAgios) {
	
	super(nom, adresse);
	this.tauxAgios = tauxAgios;
	}

public void crediter(double montant) {
	
	this.solde += montant;
	System.out.println("Solde du compte: " + this.getSolde());}

public void debiter(double montant) {

	double soldeInt;
	
	this.solde -= montant;	
	if (this.solde<0) {
	System.out.println("Attention solde négatif !!!");}
	
	System.out.println("Solde du compte: " + this.getSolde());}

public String toString() {
	string chaine = "CompteCourant. " + super.toString();
	return chaine;}

public void traitementQuotidien() {
	
	double agios;
	agios = this.solde * this.tauxAgios;
	System.out.println("Le montant des agios est de :" + agios);
	this.debiter(agios);
	System.out.println("Solde du compte: " + this.getSolde());
	}
}

public class Essai {

	public static void main(String[] args) {
		CompteCourant abc = new CompteCourant("Monnery","Lyon");
		abc.tauxAgios = 0.05;
		abc.crediter(500);
		abc.debiter(1000);
		abc.crediter(2000);
		abc.toString();

		CompteEpargne def = new CompteEpargne("Monnery","Lyon");
		def.tauxInterets = 0.03;
		def.crediter(5000);
		def.debiter(10000);
		def.crediter(30000);
		def.toString();
	}
}

