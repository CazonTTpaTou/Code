package modele;

	/** 
	* Classe qui permet de lier deux objets cons�cutifs entre eux
	*/
public class Lien {

	protected Lien suivant;
	protected Lien suivant() {return suivant;}
	protected void suivant(Lien s) {suivant=s;}
	}


