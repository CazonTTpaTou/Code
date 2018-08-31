package structure;

public class ForêtChaînée extends ListeChainee implements Forêt {
	public ForêtChaînée() throws Exception {
		super(ArbreChaîné.class);
	}
	public Arbre ièmeArbre(int r) {
		try {
			return (Arbre) super.ième(r);
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
