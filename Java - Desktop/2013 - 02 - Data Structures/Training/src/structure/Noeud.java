package structure;

public class Noeud extends Lien{
	
	protected Object valeur;
	protected Forêt laForêt;
	
	public Noeud(Object e) {valeur=e;}
	
	public Noeud(Object e,Noeud s) {valeur=e;suivant(s);}
	
	public Noeud(Object e, Forêt f) {
		valeur = e;
		laForêt = f;
	}
	public Forêt forêt() {return laForêt;}
	
	public Object valeur() {return valeur;}
	
	public void changerValeur(Object e) {valeur = e;}
	
	public Noeud noeudSuivant() {return (Noeud) suivant();}
	
	public void noeudSuivant(Noeud s) {suivant(s);}

}
