package structure;

public interface For�t {
	public int longueur();
	public Arbre i�meArbre(int r) throws RangInvalideException;
	public void ajouterArbre(int r, Arbre a) throws RangInvalideException;
	public void supprimerArbre(int r) throws RangInvalideException;
	public Enumeration lesFreres();
}
