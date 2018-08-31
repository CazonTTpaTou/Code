package structure;

public class Noeud extends Lien{
	
	protected Object valeur;
	protected For�t laFor�t;
	
	public Noeud(Object e) {valeur=e;}
	
	public Noeud(Object e,Noeud s) {valeur=e;suivant(s);}
	
	public Noeud(Object e, For�t f) {
		valeur = e;
		laFor�t = f;
	}
	public For�t for�t() {return laFor�t;}
	
	public Object valeur() {return valeur;}
	
	public void changerValeur(Object e) {valeur = e;}
	
	public Noeud noeudSuivant() {return (Noeud) suivant();}
	
	public void noeudSuivant(Noeud s) {suivant(s);}

}
