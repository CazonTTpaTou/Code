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
	
	// renvoie le prénom du propriétaire
	public String getPrenomProprietaire() {
		return this.prenomProprietaire;}
	
	// renvoie le numéro d'identifiant du propriétaire
	public int getNumeroProprietaire() {
		return this.numeroProprietaire;}
	
	// renvoie le nom du propriétaire
	public String getNomProprietaire() {
		return this.nomProprietaire;}
	
}

