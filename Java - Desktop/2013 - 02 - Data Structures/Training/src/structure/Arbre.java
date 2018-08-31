package structure;

public interface Arbre {
	public Noeud Racine();
	public Forêt forêt();
	
	public void parcoursPréfixe(Operation op);
}

