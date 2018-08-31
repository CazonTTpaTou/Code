package modele;

// classe abstraite créée pour être étendue par héritage
public abstract class Oeuvre {

	protected int numeroOeuvre;
	protected String titreOeuvre;
	protected int refProprio;
	
	// méthode initialisant les variables de classe
	public void init(int numero,String nom,int proprio) {
		this.titreOeuvre = nom;
		this.numeroOeuvre = numero;
		this.refProprio = proprio;}
	
	// retourne le numéro de l'oeuvre
	public int getNumero() {
		return this.numeroOeuvre;}
	
	// retourne le titre de l'oeuvre
	public String getTitre() {
		return this.titreOeuvre;}
}

