package modele;

/** 
* Classe qui permet de lier deux objets cons�cutifs entre eux dans les deux sens avant et arri�re
*/
public class LienDouble extends Lien {

	protected Lien precedent;
	protected Lien precedent() {return precedent;}
	protected void precedent(Lien s) {precedent=s;}

	}




