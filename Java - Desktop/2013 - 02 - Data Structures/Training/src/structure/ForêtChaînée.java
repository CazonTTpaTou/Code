package structure;

public class For�tCha�n�e extends ListeChainee implements For�t {
	public For�tCha�n�e() throws Exception {
		super(ArbreCha�n�.class);
	}
	public Arbre i�meArbre(int r) {
		try {
			return (Arbre) super.i�me(r);
		} catch (RangInvalideException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public void ajouterArbre(int r,Arbre a)
	{try {
		super.ajouter(r,a);
	} catch (RangInvalideException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (TypeIncompatibleException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}}
	
	public void supprimerArbre(int r) {
		try {
			super.supprimer(r);
		} catch (RangInvalideException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}}
	
	public Enumeration lesFreres() {
		// TODO Auto-generated method stub
		return super.listeEnumeration();
	}

}
