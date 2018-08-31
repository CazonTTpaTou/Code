package modele;

public class Proprietaire {

	private String nomProprietaire;
	private String prenomProprietaire;
	private int numeroProprietaire;
	
	// initialise les variables de classe
	public void setProprietaire(int numero,String nom,String prenom) {
		this.numeroProprietaire=numero;
		this.nomProprietaire = nom;
		this.prenomProprietaire = nom;}
	
	// renvoie le pr�nom du propri�taire
	public String getPrenomProprietaire() {
		return this.prenomProprietaire;}
	
	// renvoie le num�ro d'identifiant du propri�taire
	public int getNumeroProprietaire() {
		return this.numeroProprietaire;}
	
	// renvoie le nom du propri�taire
	public String getNomProprietaire() {
		return this.nomProprietaire;}
	
}

