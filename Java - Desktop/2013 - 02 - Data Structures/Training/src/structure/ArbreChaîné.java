package structure;

public class ArbreCha�n� extends Noeud implements Arbre 
{
	public ArbreCha�n�(Object e,For�t f) {
		super(e,f);
	}
	public For�t for�t() {
		return super.for�t();
	}
	public Noeud Racine() {
		return this;
	}
	public void parcoursPr�fixe(Operation op) {
		op.executer(valeur());
		try {
			Enumeration f=for�t().lesFreres();
		
		while (!f.finEnumeration())
		{ ((Arbre) f.elementSuivant()).parcoursPr�fixe(op);}
		} 
		catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("Fin de l'arbre !!!");
		}
	}
}
