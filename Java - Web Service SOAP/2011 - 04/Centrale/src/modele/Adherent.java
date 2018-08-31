package modele;

public class Adherent {

	private String nomAdherent;
	private String prenomAdherent;
	private int numeroAdherent;
	
	// initialise les variables de classe
	public void setAdherent(int numero,String nom,String prenom) {
		this.numeroAdherent=numero;
		this.nomAdherent = nom;
		this.prenomAdherent = nom;}
	
	// retourne le nom de l'adhérent
	public String getNomAdherent() {
		return this.nomAdherent;}
	
	// retourne le prénom de l'adhérent
	public String getPrenomAdherent() {
		return this.prenomAdherent;}
	
	// retourne le numéro d'identification 
	// de l'adhérent à la bibliothèque
	public int getNumeroAdherent() {
		return this.numeroAdherent;}
	
}

	

