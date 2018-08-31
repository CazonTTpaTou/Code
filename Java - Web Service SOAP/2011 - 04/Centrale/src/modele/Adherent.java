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
	
	// retourne le nom de l'adh�rent
	public String getNomAdherent() {
		return this.nomAdherent;}
	
	// retourne le pr�nom de l'adh�rent
	public String getPrenomAdherent() {
		return this.prenomAdherent;}
	
	// retourne le num�ro d'identification 
	// de l'adh�rent � la biblioth�que
	public int getNumeroAdherent() {
		return this.numeroAdherent;}
	
}

	

