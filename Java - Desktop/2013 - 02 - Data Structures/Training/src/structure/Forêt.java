package structure;

public interface Forêt {
	public int longueur();
	public Arbre ièmeArbre(int r) throws RangInvalideException;
	public void ajouterArbre(int r, Arbre a) throws RangInvalideException;
	public void supprimerArbre(int r) throws RangInvalideException;
	public Enumeration lesFreres();
}
