package modele;

/** 
* Classe qui constitue chaque objet dont sera composé la liste chaînée
*/
public class Noeud2 extends LienDouble {

	protected Object valeur;

	public Noeud2(Object e) {valeur=e;}

	public Noeud2(Object e,Noeud2 p, Noeud2 s) {
		valeur=e;
		precedent(p);
		suivant(s);}

	public Object valeur() {return valeur;}

	public void changerValeur(Object e) {valeur=e;}

	public Noeud2 noeud2Suivant() {return (Noeud2) suivant();}

	public void noeudSuivant(Noeud2 s) {suivant(s);}

	public Noeud2 noeud2Precedent() {return (Noeud2) precedent();}

	public void noeudPrecedent(Noeud2 s) {precedent(s);}
}

