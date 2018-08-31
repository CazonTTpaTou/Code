package structure;

public class ArbreChaîné extends Noeud implements Arbre 
{
	public ArbreChaîné(Object e,Forêt f) {
		super(e,f);
	}
	public Forêt forêt() {
		return super.forêt();
	}
	public Noeud Racine() {
		return this;
	}
	public void parcoursPréfixe(Operation op) {
		op.executer(valeur());
		try {
			Enumeration f=forêt().lesFreres();
		
		while (!f.finEnumeration())
		{ ((Arbre) f.elementSuivant()).parcoursPréfixe(op);}
		} 
		catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("Fin de l'arbre !!!");
		}
	}
}
