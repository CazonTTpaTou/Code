package modele;

// classe abstraite cr��e pour �tre �tendue par h�ritage
public abstract class Oeuvre {

	protected int numeroOeuvre;
	protected String titreOeuvre;
	protected int refProprio;
	
	// m�thode initialisant les variables de classe
	public void init(int numero,String nom,int proprio) {
		this.titreOeuvre = nom;
		this.numeroOeuvre = numero;
		this.refProprio = proprio;}
	
	// retourne le num�ro de l'oeuvre
	public int getNumero() {
		return this.numeroOeuvre;}
	
	// retourne le titre de l'oeuvre
	public String getTitre() {
		return this.titreOeuvre;}
}

